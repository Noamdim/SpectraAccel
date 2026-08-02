import numpy as np
import time
import json
import rasterio
from rasterio.enums import Resampling
import plotly.express as px
import plotly.graph_objects as go
from dash import Dash, dcc, html, Input, Output, State, callback, no_update



def files_to_cube(band_paths):
    print("#################################################################################################################")
    print("collecting data from files to numpy 3d array ")
    start_time = time.perf_counter()
    bands_10m = {}

    for b in ["B02", "B03", "B04", "B08"]:
        with rasterio.open(band_paths[b]) as src:
            bands_10m[b] = src.read(1).astype(np.float32)
            profile_10m = src.profile  # save for resampling reference

    bands_20m = {}

    for b in ["B05", "B06", "B07", "B11", "B12"]:
        with rasterio.open(band_paths[b]) as src:
            data_20m = src.read(
                out_shape=(
                    src.count,
                    profile_10m["height"],
                    profile_10m["width"]
                ),
                resampling=Resampling.bilinear
            )[0]
            bands_20m[b] = data_20m.astype(np.float32)
    ordered_bands = ["B02","B03","B04","B08","B05","B06","B07","B11","B12"]

    cube = np.stack(
        [bands_10m.get(b, bands_20m.get(b)) for b in ordered_bands],
        axis=-1
    )

    print("Cube shape:", cube.shape)
    end_time = time.perf_counter()
    run_time = end_time - start_time
    print(f"The code run in {run_time:.6f} seconds")
    print("#################################################################################################################")
    return cube

#####################  NORMALIZATION FUNCTION  ######################


def normalize_to_uint8(cube, per_band=False):
    """
    Normalizes a numpy array to the range 0-255 and converts to uint8.

    Parameters
    ----------
    cube : np.ndarray
        Input data (any shape).
    per_band : bool, optional
        If False (default), scales using the Global Min/Max of the entire cube. 
        (Best for preserving spectral ratios between bands).
        If True, scales each band independently. 
        (Best for visualization if some bands are very dark).
    """
    # Create a float copy to avoid integer division errors
    img = cube.astype(float)

    if per_band and cube.ndim == 3:
        # Normalize each band separately
        rows, cols, bands = cube.shape
        out_cube = np.zeros((rows, cols, bands), dtype=np.uint8)
        
        for i in range(bands):
            band_data = img[:, :, i]
            min_val = np.nanmin(band_data)
            max_val = np.nanmax(band_data)
            
            # Avoid divide by zero for constant bands
            if max_val == min_val:
                out_cube[:, :, i] = 0
            else:
                norm = (band_data - min_val) / (max_val - min_val)
                out_cube[:, :, i] = (norm * 255).astype(np.uint8)
        return out_cube

    else:
        # Global Normalization (Preserves spectral curve shape)
        min_val = np.nanmin(img)
        max_val = np.nanmax(img)

        if max_val == min_val:
            return np.zeros_like(cube, dtype=np.uint8)

        # Formula: (x - min) / (max - min) * 255
        norm = (img - min_val) / (max_val - min_val)
        return (norm * 255).astype(np.uint8)


#####################  HARDWARE SIMULATION LOGIC  ######################

def fixed_div(num, den, q_factor=8):
    """Simulates the fixed-point division hardware module."""
    if den == 0:
        return 0
    # Hardware shift logic (numerator << Q) / denominator
    return int((num << q_factor) // den)

def process_pixel(pixel, thresholds, controllers, classifier_rules, rgb_library_values):
    """
    Simulates the Verilog Pipeline on a single ALREADY NORMALIZED pixel.
    """
    
    # --- 1. Bit Slicing ---
    # Note: We cast to int to prevent overflow during addition (uint8 overflow wraps at 255)
    b_blue  = int(pixel[0])
    b_green = int(pixel[1])
    b_red   = int(pixel[2])
    b_nir   = int(pixel[3])
    b_re1   = int(pixel[4])
    b_re2   = int(pixel[5])
    b_re3   = int(pixel[6])
    b_swir1 = int(pixel[7])

    # --- 2. IPU (Index Calculation Cores) ---
    # Q1.8 Fixed Point (256 = 1.0)

    # MNDWI: (Green - SWIR1) / (Green + SWIR1)
    mndwi = fixed_div(b_green - b_swir1, b_green + b_swir1)
    
    # NDVI: (NIR - Red) / (NIR + Red)
    ndvi = fixed_div(b_nir - b_red, b_nir + b_red)

    # NDRE: (NIR - RE1) / (NIR + RE1)
    ndre = fixed_div(b_nir - b_re1, b_nir + b_re1)
    
    # NDBI: (SWIR1 - NIR) / (SWIR1 + NIR)
    ndbi = fixed_div(b_swir1 - b_nir, b_swir1 + b_nir)
    
    # BSI: ((SWIR1 + Red) - (NIR + Blue)) / ((SWIR1 + Red) + (NIR + Blue))
    bsi = fixed_div((b_swir1 + b_red) - (b_nir + b_blue), (b_swir1 + b_red) + (b_nir + b_blue))
    
    # ndFDI: (2*NIR - (RE2 + SWIR1)) / (2*NIR + (RE2 + SWIR1))
    fdi = fixed_div((b_nir * 2) - (b_re2 + b_swir1), (b_nir * 2) + (b_re2 + b_swir1))
    
    # Brightness: Sum / 4 (Hardware takes top bits [9:7])
    pixel_sum = b_blue + b_green + b_red + b_nir
    brightness_idx = (pixel_sum >> 7) & 0x7 # Extracts 3 bits (0-7)

    # --- 3. Feature Selector  ---
    # MUX Pool matching the Verilog 'mux_pool'
    # 0:mndwi, 1:ndvi, 2:ndbi, 3:ndre, 4:bsi, 5:fdi, 6-11:thresholds, 12:0, 13:'1'
    pool = [mndwi, ndvi, ndbi, ndre, bsi, fdi] + thresholds + [0, 256]
    
    mux_outputs = []
    for sel in controllers:
        val = pool[sel] if sel < len(pool) else 0
        mux_outputs.append(val)
    # --- 4. Comparator ---
    # Pairwise Comparisons
    flags = []
    for i in range(0, 12, 2):
        flags.append(mux_outputs[i] > mux_outputs[i+1])

    # --- 5. Logical Expressions (Classifier) ---
    classification_vector = 0
    for r in range(8):
        rule_cfg = classifier_rules[r]
        rule_result = True
        if rule_cfg == 0x000:
            continue # Skip this rule (result remains 0/False)
        for f in range(6):
            flag_cfg = (rule_cfg >> (f * 2)) & 0x3 
            enable = flag_cfg & 0x1
            polarity = (flag_cfg >> 1) & 0x1
            
            if enable:
                term = flags[f] if polarity else not flags[f]
                rule_result = rule_result and term
        
        if rule_result:
            classification_vector |= (1 << r)

    # --- 5. Colorizer ---
    match_found = False
    rule_idx = 0
    for r in range(8):
        if (classification_vector >> r) & 0x1:
            rule_idx = r
            match_found = True
            break

    if match_found:
        base_color = rgb_library_values[rule_idx]
        # Texture Logic: (Color * Brightness) / 8
        brightness_idx = brightness_idx + 1
        r_out = (base_color[0] * brightness_idx) >> 3
        g_out = (base_color[1] * brightness_idx) >> 3
        b_out = (base_color[2] * brightness_idx) >> 3
        return [r_out, g_out, b_out]
    else:
        # No Match: Pass through original RGB
        return [b_red, b_green, b_blue]
##################### GUI  ######################

def calculate_indices_new(cube):
    """
    Classifies pixels using the custom 9-band subset.
    
    Expected Band Order in 'cube':
    0: B02 (Blue)
    1: B03 (Green)
    2: B04 (Red)
    3: B08 (NIR)
    4: B05 (Red Edge 1)
    5: B06 (Red Edge 2)
    6: B07 (Red Edge 3)
    7: B11 (SWIR 1)
    8: B12 (SWIR 2)
    """
    print("################################################################################")
    print("Processing 9-Band Sentinel-2 Cube")
    start_time = time.perf_counter()

    # --- 1. Extract Bands ---
    # Using explicit names makes the logic below much safer
    try:
        b_blue  = cube[:, :, 0]
        b_green = cube[:, :, 1]
        b_red   = cube[:, :, 2]
        b_nir   = cube[:, :, 3]
        b_re1   = cube[:, :, 4] # B5
        b_re2   = cube[:, :, 5] # B6
        b_re3   = cube[:, :, 6] # B7
        b_swir1 = cube[:, :, 7] # B11
        b_swir2 = cube[:, :, 8] # B12
    except IndexError:
        return "Error: Input cube must have exactly 9 bands."

    # --- 2. Calculate Indices ---
    eps = 1e-6 
    
    # A. Water & Plastic
    # MNDWI: Uses Green(B3) and SWIR1(B11)
    mndwi = (b_green - b_swir1) / (b_green + b_swir1 + eps)
    
    # Advanced Indices (Plastics & Metals)
    # ndFDI (Floating Debris) approximation using B5 instead of B6 (if B6 unavailable)
    baseline = b_re2 + (b_swir2 - b_re2) * 0.5
    fdi = (b_nir - baseline) / (b_nir + baseline + eps)

    # B. Vegetation
    # NDVI: The standard veg check
    ndvi = (b_nir - b_red) / (b_nir + b_red + eps)
    
    # NDRE2 (Red Edge 2): Superior for Forest vs Field
    # Uses B7 (Deep Red Edge) vs B5 (Red Edge start)
    ndre2 = (b_re3 - b_re1) / (b_re3 + b_re1 + eps)

    # C. Urban & Soil
    # NDBI: Built-up index
    ndbi = (b_swir1 - b_nir) / (b_swir1 + b_nir + eps)
    
    # BSI (Bare Soil Index) - Adjusted for available bands
    # ((SWIR1 + Red) - (NIR + Blue)) / ((SWIR1 + Red) + (NIR + Blue))
    bsi_top = ((b_swir1 + b_red) - (b_nir + b_blue))
    bsi_bot = ((b_swir1 + b_red) + (b_nir + b_blue))
    bsi = bsi_top / (bsi_bot + eps)

    # --- 3. Brightness (For Visuals & Road detection) ---
    # Simple average of Visible bands
    brightness = (b_blue + b_green + b_red) / 3.0
    # Normalize for display (assuming 0-10000 range usually, or 0-1 floats)
    # IF your data is 0-10000 integers:
    brightness_norm = np.clip(brightness / 3000.0, 0, 1)
    # IF your data is 0-1 floats:
    # brightness_norm = np.clip(brightness / 0.3, 0, 1) 
    print("#################################################################################################################")

    title1 = "ndvi"
    fig1 = px.imshow(ndvi, title=title1,
            color_continuous_scale="RdYlGn",
            labels=dict(color="NDVI"))
    title2 = "mndwi"
    fig2 = px.imshow(mndwi, title=title2,
            color_continuous_scale="RdBu",
            labels=dict(color="MNDWI"))
    title3 = "fdi"
    fig3 = px.imshow(fdi, title=title3,
            color_continuous_scale="RdBu",
            labels=dict(color="fdi"))
    title4 = "ndbi"
    fig4 = px.imshow(ndbi, title=title4,
            color_continuous_scale="RdYlGn",
            labels=dict(color="NDBI"))
    title5 = "bsi"
    fig5 = px.imshow(bsi, title=title5,
            color_continuous_scale="RdYlGn",
            labels=dict(color="BSI"))
    title6 = "ndre"
    fig6 = px.imshow(ndre2, title=title6,
            color_continuous_scale="RdYlGn",
            labels=dict(color="NDRE"))
    all_figs = [fig1, fig2, fig3, fig4, fig5, fig6]

    # Loop to center the title for every figure
    for f in all_figs:
        f.update_layout(
            title_x=0.5,          # Moves title to the horizontal center
            title_xanchor='center', # Ensures the text is centered on that point
            margin=dict(l=0, r=0, t=30, b=0), # Remove empty whitespace around the image
            coloraxis_colorbar=dict(
                thickness=15,        # Make the bar thinner (sleeker look)
                len=0.9,             # Make it 90% of the plot height
                xpad=5,              # Distance between image and bar (5 pixels)
                tickfont=dict(size=10) # Smaller font for numbers
            )
            )
    return fig1, fig2, fig3, fig4, fig5, fig6


#####################  MAIN PROCESSOR  ######################

def sentinel_data_processor(cube, thresholds, controllers, classifier_rules, rgb_library):
    print("################################################################################")

    
    # --- PRE-PROCESSING: Normalization ---
    # Using Global Normalization (per_band=False) to preserve spectral ratios!
    print("Normalizing Cube (Global Min/Max)...")
    cube_uint8 = normalize_to_uint8(cube, per_band=False)
    print("Processing Sentinel-2 Cube like the hardware")
    start_time = time.perf_counter()
    
    rows, cols, bands = cube_uint8.shape
    final_img = np.zeros((rows, cols, 3), dtype=np.uint8)
    rgb_values_list = list(rgb_library.values())

    # --- PIXEL LOOP (FLOATING POINT COMPONENT VERSION) ---
    eps = 1e-6
    for r in range(rows):
        if r % (rows // 10 + 1) == 0:
            print(f"Row {r}/{rows}")

        for c in range(cols):
            pixel = cube_uint8[r, c, :].astype(float)
            b_blue, b_green, b_red, b_nir, b_re1, b_re2, b_re3, b_swir1 = pixel[:8]
            brightness_idx = int(b_blue + b_green + b_red + b_nir) >> 7

            # 1. Floating point index calculation
            mndwi = (b_green - b_swir1) / (b_green + b_swir1 + eps)
            ndvi = (b_nir - b_red) / (b_nir + b_red + eps)
            ndre = (b_nir - b_re1) / (b_nir + b_re1 + eps)
            ndbi = (b_swir1 - b_nir) / (b_swir1 + b_nir + eps)
            bsi = ((b_swir1 + b_red) - (b_nir + b_blue)) / ((b_swir1 + b_red) + (b_nir + b_blue) + eps)
            fdi = ((b_nir * 2) - (b_re2 + b_swir1)) / ((b_nir * 2) + (b_re2 + b_swir1) + eps)

            # Convert back to fake Q1.8 scaling so we can reuse the rules/thresholds dynamically from the GUI
            pool = [int(mndwi * 256), int(ndvi * 256), int(ndbi * 256), int(ndre * 256), int(bsi * 256),
                    int(fdi * 256)] + list(thresholds) + [0, 256]

            mux_outputs = [pool[sel] if sel < len(pool) else 0 for sel in controllers]
            flags = [mux_outputs[i] > mux_outputs[i + 1] for i in range(0, 12, 2)]

            classification_vector = 0
            for rule_r in range(8):
                rule_cfg = classifier_rules[rule_r]
                if rule_cfg == 0x000: continue
                rule_result = True
                for f in range(6):
                    flag_cfg = (rule_cfg >> (f * 2)) & 0x3
                    if flag_cfg & 0x1:
                        term = flags[f] if ((flag_cfg >> 1) & 0x1) else not flags[f]
                        rule_result = rule_result and term
                if rule_result:
                    classification_vector |= (1 << rule_r)

            match_found = False
            for rule_r in range(8):
                if (classification_vector >> rule_r) & 0x1:
                    base_color = rgb_values_list[rule_r]
                    final_img[r, c] = [(c_val * (brightness_idx + 1)) >> 3 for c_val in base_color]
                    match_found = True
                    break
            if not match_found:
                final_img[r, c] = [int(b_red), int(b_green), int(b_blue)]

    end_time = time.perf_counter()
    print(f"Classification run in {end_time - start_time:.6f} seconds")

    # --- Plotly Figure ---
    fig = px.imshow(final_img, title="Sentinel-2 Analysis (Hardware Simulation)")
    fig.update_xaxes(visible=False)
    fig.update_yaxes(visible=False)
    fig.update_layout(margin=dict(l=10, r=10, t=40, b=10))

    # Legend
    for name, color_list in rgb_library.items():
        hex_color = '#%02x%02x%02x' % tuple(color_list)
        fig.add_trace(go.Scatter(
            x=[None], y=[None], mode='markers',
            marker=dict(size=10, color=hex_color),
            name=name
        ))

    return fig




######################################################################### 
############################# MAIN ######################################
#########################################################################
path_pre = ".\\IMG_DATA\\"
    # --- DEFINING COLORS (R, G, B) ---
rgb_library = {
        "water":            [51, 150, 242],   # Blue
        "plastic or metal": [255, 165, 0],#[0, 255, 255],    # Cyan
        "trees":            [34, 139, 34],    # Forest Green
        "field":            [124, 252, 0],    # Lawn Green
        "road":             [50, 50, 55],     # Dark Asphalt
        "soil":             [139, 69, 19],    # Brown
        "Building":         [220, 220, 220],   # Light Gray
        "glass/solar panel": [148, 103, 189]  # purple
    }

band_paths_ams = {
    "B02": path_pre + "T31UFU_20240110T105421_B02_10m.jp2",
    "B03": path_pre + "T31UFU_20240110T105421_B03_10m.jp2",
    "B04": path_pre + "T31UFU_20240110T105421_B04_10m.jp2",
    "B08": path_pre + "T31UFU_20240110T105421_B08_10m.jp2",

    "B05": path_pre + "T31UFU_20240110T105421_B05_20m.jp2",
    "B06": path_pre + "T31UFU_20240110T105421_B06_20m.jp2",
    "B07": path_pre + "T31UFU_20240110T105421_B07_20m.jp2",
    "B11": path_pre + "T31UFU_20240110T105421_B11_20m.jp2",
    "B12": path_pre + "T31UFU_20240110T105421_B12_20m.jp2",
}
band_paths_isr_leb = {
    "B02": path_pre + "T36SYB_20231022T081959_B02_10m.jp2",
    "B03": path_pre + "T36SYB_20231022T081959_B03_10m.jp2",
    "B04": path_pre + "T36SYB_20231022T081959_B04_10m.jp2",
    "B08": path_pre + "T36SYB_20231022T081959_B08_10m.jp2",

    "B05": path_pre + "T36SYB_20231022T081959_B05_20m.jp2",
    "B06": path_pre + "T36SYB_20231022T081959_B06_20m.jp2",
    "B07": path_pre + "T36SYB_20231022T081959_B07_20m.jp2",
    "B11": path_pre + "T36SYB_20231022T081959_B11_20m.jp2",
    "B12": path_pre + "T36SYB_20231022T081959_B12_20m.jp2",
}

band_paths_nat = {
    "B02": path_pre + "T36SXA_20260124T082231_B02_10m.jp2",
    "B03": path_pre + "T36SXA_20260124T082231_B03_10m.jp2",
    "B04": path_pre + "T36SXA_20260124T082231_B04_10m.jp2",
    "B08": path_pre + "T36SXA_20260124T082231_B08_10m.jp2",

    "B05": path_pre + "T36SXA_20260124T082231_B05_20m.jp2",
    "B06": path_pre + "T36SXA_20260124T082231_B06_20m.jp2",
    "B07": path_pre + "T36SXA_20260124T082231_B07_20m.jp2",
    "B11": path_pre + "T36SXA_20260124T082231_B11_20m.jp2",
    "B12": path_pre + "T36SXA_20260124T082231_B12_20m.jp2",
}

# --- HARDWARE MAPPING CONFIGURATION ---

# 1. THRESHOLDS (Q1.8 Format: Value * 256)
# ----------------------------------------
# Th0 (FDI):    0.04 * 256 = 10.24 -> 11
# Th1 (NDVI):   0.30 * 256 = 76.8 -> 77
# Th2 (NDRE):   0.25 * 256 = 64.0 -> 64  (Merged threshold for Forest & Buildings)
# Th3 (NDBI):   0.35 * 256 = 89.6 -> 90
# Th4 (MNDWI): -0.10 * 256 = -25.6 -> -26 (NEW Threshold)
# Th5:     Unused (0)
thresholds = [11, 77, 64, 90, -26, 0]

# 2. CONTROLLERS (Comparators Setup)
# ----------------------------------------
# =========================================================
#  CONTROLLER INPUT MAP (MUX POOL)
# =========================================================
#  The hardware 'feature_selector' module maps these indices 
#  to specific calculated values or configuration thresholds.
#  Use these indices when defining the 'controllers' list.
#
#  --- CALCULATED INDICES ---
#  0  : MNDWI (Water)
#  1  : NDVI  (Vegetation)
#  2  : NDBI  (Urban/Roads)
#  3  : NDRE  (Red Edge / Veg Health)
#  4  : BSI   (Bare Soil)
#  5  : FDI   (Floating Debris)
#
#  --- CONFIGURATION THRESHOLDS ---
#  6  : Threshold 0 (th[0])
#  7  : Threshold 1 (th[1])
#  8  : Threshold 2 (th[2])
#  9  : Threshold 3 (th[3])
#  10 : Threshold 4 (th[4])
#  11 : Threshold 5 (th[5])
#
#  --- CONSTANTS ---
#  12 : CONST_ZERO (0.0)
#  13 : CONST_ONE  (1.0 / 256 in Q1.8)
# =========================================================
# We define 6 Boolean Flags (Flag0 to Flag5):
# Flag 0: Is Water? (MNDWI > 0)     -> Input 0 (MNDWI) vs Input 12 (Const 0)
# Flag 1: Is Debris? (FDI > 0.04)   -> Input 5 (FDI)   vs Input 6 (Th0)
# Flag 2: Is Veg? (NDVI > 0.3)      -> Input 1 (NDVI)  vs Input 7 (Th1)
# Flag 3: High Veg/Build? (NDRE > 0.25) -> Input 3 (NDRE) vs Input 8 (Th2)
# Flag 4: Is Glass? (NDBI > 0.35)   -> Input 2 (NDBI)  vs Input 9 (Th3)
# Flag 5: Urban vs Soil (BSI > NDBI)-> Input 4 (BSI)   vs Input 2 (NDBI)

controllers = [
    0, 12,  # Flag 0
    5, 6,   # Flag 1
    1, 7,   # Flag 2
    3, 8,   # Flag 3
    2, 9,   # Flag 4
    4, 2    # Flag 5
]

# ==============================================================================
#  CLASSIFIER RULES MAP & EXPLANATION
# ==============================================================================
#  Each Rule is a 12-bit integer configuring how the 6 Comparison Flags affect
#  the decision. The logic is an AND chain of all enabled flags.
#
#  --- BITWISE FORMAT (Per Flag) ---
#  Each Flag (F0 to F5) controls 2 bits:
#  [Polarity Bit, Enable Bit]
#
#  * 00 (0): IGNORE this flag (Don't care)
#  * 01 (1): MUST BE FALSE (Logic: AND NOT Flag)
#  * 11 (3): MUST BE TRUE  (Logic: AND Flag)
#  * 10 (2): Invalid/Undefined
#
#  Structure: [F5_bits][F4_bits][F3_bits][F2_bits][F1_bits][F0_bits]
#             (Bits 11-10) ... ... ... ... ... (Bits 1-0)
#
#  Disabling a rule is 0x000
#
#  --- CURRENT FLAG DEFINITIONS ---

# Rule 0: "plastic or metal"
# Logic: (MNDWI > 0) AND (FDI > 0.05)
# Flags: F0=True, F1=True
# Binary: ... F1(11) F0(11) -> 0x00F
rule_plastic = 0x00F

# Rule 1: "water"
# Logic: (MNDWI > 0) AND NOT (FDI > 0.05)
# Flags: F0=True, F1=False
# Binary: ... F1(01) F0(11) -> 0x007
rule_water = 0x000 #0x007

# Rule 2: "trees" (Forest)
# Logic: NOT Water (F0=0) AND Veg (F2=1) AND High NDRE (F3=1)
# Binary: F3(11) F2(11) F1(00) F0(01) -> 0000 1111 0001 -> 0x0F1
rule_trees = 0x0F1

# Rule 3: "field"
# Logic: NOT Water (F0=0) AND Veg (F2=1) AND Low NDRE (F3=0)
# Binary: F3(01) F2(11) F1(00) F0(01) -> 0000 0111 0001 -> 0x071
rule_field = 0x071

# Rule 4: "glass/solar panel"
# Logic: NOT Water (F0=0) AND NOT Veg (F2=0) AND High NDBI (F4=1)
# Note: Tree says "else if ndbi < 0.35...". So "else" (Glass) is ndbi >= 0.35
# Binary: F4(11) F3(00) F2(01) F1(00) F0(01) -> 0011 0001 0001 -> 0x311
rule_glass = 0x311

# Rule 5: "Building"
# Logic: NOT Water, NOT Veg, Low NDBI (F4=0), Is Urban (F5=1), High NDRE (F3=1)
# Binary: F5(11) F4(01) F3(11) F2(01) F1(00) F0(01) -> 1101 1101 0001 -> 0xDD1
rule_building = 0x511 #0xDD1

# Rule 6: "road"
# Logic: NOT Water, NOT Veg, Low NDBI (F4=0), Is Urban (F5=1), Low NDRE (F3=0)
# Binary: F5(11) F4(01) F3(01) F2(01) F1(00) F0(01) -> 1101 0101 0001 -> 0xD51
rule_road = 0x000 #0xD51

# Rule 7: "soil"
# Logic: NOT Water, NOT Veg, Low NDBI (F4=0), Is Soil (F5=0)
# Binary: F5(01) F4(01) F3(00) F2(01) F1(00) F0(01) -> 0101 0001 0001 -> 0x511
rule_soil = 0x000# 0x511

# Combine into the list (Order must match RGB Library keys!)
classifier_rules = [
    rule_plastic,   # Index 0
    rule_water,     # Index 1
    rule_trees,     # Index 2
    rule_field,     # Index 3
    rule_glass,     # Index 4
    rule_building,  # Index 5
    rule_road,      # Index 6
    rule_soil       # Index 7
]

# 4. RGB LIBRARY (Must match the order above)
# ----------------------------------------
rgb_library = {
    "plastic or metal": [255, 165, 0],    # Index 0
    "water":            [51, 150, 242],   # Index 1
    "trees":            [34, 139, 34],    # Index 2
    "field":            [124, 252, 0],    # Index 3
    "glass/solar panel":[148, 103, 189],  # Index 4
    "Building":         [220, 220, 220],  # Index 5
    "road":             [50, 50, 55],     # Index 6
    "soil":             [139, 69, 19]     # Index 7
}

#band_paths = band_paths_ams
#cube = files_to_cube(band_paths)
#cube = cube[3000:3500,1500:2000,:]

#yahud- natbag
band_paths = band_paths_nat
cube = files_to_cube(band_paths)
cube = cube[5000:6500,7000:8500,:]
cube = cube[490:930,660:1000,:]


fig1, fig2, fig3, fig4, fig5, fig6 = calculate_indices_new(cube)
fig_main = sentinel_data_processor(cube, thresholds, controllers, classifier_rules, rgb_library)

# Store indices as global arrays for pixel info display
eps = 1e-6
b_blue_g  = cube[:, :, 0]; b_green_g = cube[:, :, 1]; b_red_g = cube[:, :, 2]
b_nir_g   = cube[:, :, 3]; b_re1_g   = cube[:, :, 4]; b_re2_g = cube[:, :, 5]
b_re3_g   = cube[:, :, 6]; b_swir1_g = cube[:, :, 7]; b_swir2_g = cube[:, :, 8]
ndvi_arr   = (b_nir_g - b_red_g) / (b_nir_g + b_red_g + eps)
mndwi_arr  = (b_green_g - b_swir1_g) / (b_green_g + b_swir1_g + eps)
baseline_g = b_re2_g + (b_swir2_g - b_re2_g) * 0.5
fdi_arr    = (b_nir_g - baseline_g) / (b_nir_g + baseline_g + eps)
ndbi_arr   = (b_swir1_g - b_nir_g) / (b_swir1_g + b_nir_g + eps)
bsi_arr    = ((b_swir1_g + b_red_g) - (b_nir_g + b_blue_g)) / ((b_swir1_g + b_red_g) + (b_nir_g + b_blue_g) + eps)
ndre_arr   = (b_re3_g - b_re1_g) / (b_re3_g + b_re1_g + eps)


# ====================== DASH APP ======================

external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']
app = Dash(__name__, external_stylesheets=external_stylesheets)

# --- Helper: Build threshold controls ---
threshold_labels = ["Th0 (FDI)", "Th1 (NDVI)", "Th2 (NDRE)", "Th3 (NDBI)", "Th4 (MNDWI)", "Th5 (Unused)"]
# Convert Q1.8 defaults to real float values for display
thresholds_float = [v / 256.0 for v in thresholds]

def make_threshold_inputs():
    children = []
    for i, (label, val) in enumerate(zip(threshold_labels, thresholds_float)):
        children.append(html.Div([
            html.Label(label, style={"fontSize": "11px", "fontWeight": "bold"}),
            dcc.Input(id=f"th-{i}", type="number", value=round(val, 4), step=0.01,
                      style={"width": "80px", "marginLeft": "4px"})
        ], style={"display": "inline-block", "marginRight": "12px", "marginBottom": "6px"}))
    return html.Div(children)

# --- Helper: Build controller controls ---
mux_pool_options = [
    {"label": "0: MNDWI", "value": 0}, {"label": "1: NDVI", "value": 1},
    {"label": "2: NDBI", "value": 2}, {"label": "3: NDRE", "value": 3},
    {"label": "4: BSI", "value": 4}, {"label": "5: FDI", "value": 5},
    {"label": "6: Th0", "value": 6}, {"label": "7: Th1", "value": 7},
    {"label": "8: Th2", "value": 8}, {"label": "9: Th3", "value": 9},
    {"label": "10: Th4", "value": 10}, {"label": "11: Th5", "value": 11},
    {"label": "12: ZERO", "value": 12}, {"label": "13: ONE", "value": 13},
]

def make_controller_inputs():
    children = []
    for flag_i in range(6):
        a_val = controllers[flag_i * 2]
        b_val = controllers[flag_i * 2 + 1]
        children.append(html.Div([
            html.Label(f"Flag {flag_i}:", style={"fontWeight": "bold", "fontSize": "11px", "width": "50px", "display": "inline-block"}),
            dcc.Dropdown(id=f"ctrl-{flag_i*2}", options=mux_pool_options, value=a_val,
                         style={"width": "110px", "display": "inline-block", "verticalAlign": "middle"}, clearable=False),
            html.Span(" > ", style={"margin": "0 4px", "fontWeight": "bold"}),
            dcc.Dropdown(id=f"ctrl-{flag_i*2+1}", options=mux_pool_options, value=b_val,
                         style={"width": "110px", "display": "inline-block", "verticalAlign": "middle"}, clearable=False),
        ], style={"marginBottom": "4px", "display": "flex", "alignItems": "center"}))
    return html.Div(children)

# --- Helper: Build combined Rules + RGB table ---
flag_options = [
    {"label": "Ignore", "value": 0},
    {"label": "Must be FALSE", "value": 1},
    {"label": "Must be TRUE", "value": 3},
]

def make_combined_rules_table():
    rgb_list = list(rgb_library.items())
    rows = []
    # Header row
    header = [
        html.Th("Color", style={"fontSize": "10px", "padding": "4px 6px"}),
        html.Th("Hex", style={"fontSize": "10px", "padding": "4px 6px"}),
        html.Th("Class Name", style={"fontSize": "10px", "padding": "4px 6px"}),
    ] + [html.Th(f"F{i}", style={"fontSize": "10px", "padding": "4px 6px"}) for i in range(6)]
    rows.append(html.Tr(header))

    for r_idx in range(8):
        rule_val = classifier_rules[r_idx]
        name, color = rgb_list[r_idx]
        hex_color = '#{:02x}{:02x}{:02x}'.format(*color)

        cols = [
            # Color swatch
            html.Td(
                html.Div(id=f"rgb-swatch-{r_idx}",
                         style={"width": "22px", "height": "22px", "backgroundColor": hex_color,
                                "border": "1px solid #999", "borderRadius": "3px"}),
                style={"padding": "3px 4px"}
            ),
            # Hex input
            html.Td(
                dcc.Input(id=f"rgb-color-{r_idx}", type="text", value=hex_color,
                          style={"width": "72px", "fontSize": "11px", "fontFamily": "monospace"}),
                style={"padding": "3px 4px"}
            ),
            # Name input
            html.Td(
                dcc.Input(id=f"rgb-name-{r_idx}", type="text", value=name,
                          style={"width": "120px", "fontSize": "11px"}),
                style={"padding": "3px 4px"}
            ),
        ]
        # Flag dropdowns
        for f_idx in range(6):
            flag_cfg = (rule_val >> (f_idx * 2)) & 0x3
            if flag_cfg == 2:
                flag_cfg = 0
            cols.append(html.Td(
                dcc.Dropdown(id=f"rule-{r_idx}-{f_idx}", options=flag_options, value=flag_cfg,
                             style={"width": "105px", "fontSize": "11px"}, clearable=False),
                style={"padding": "3px 2px"}
            ))
        rows.append(html.Tr(cols))
    return html.Table(rows, style={"borderCollapse": "collapse", "width": "100%"})


# ====================== LAYOUT ======================

app.layout = html.Div(
    style={"padding": "12px", "fontFamily": "Arial, sans-serif"},
    children=[
        html.H2("Sentinel-2 Analytics Dashboard"),
        dcc.Tabs(
            id="tabs",
            value="tab-all",
            children=[
                # ===== TAB 1: Indices + Controls =====
                dcc.Tab(label="Spectral Indices", value="tab-all", children=[
                    # --- Index figures ---
                    html.Div([
                        html.Div(dcc.Graph(id="fig-1", figure=fig1, config={"displaylogo": False}), style={'width': '33.3%'}),
                        html.Div(dcc.Graph(id="fig-2", figure=fig2, config={"displaylogo": False}), style={'width': '33.3%'}),
                        html.Div(dcc.Graph(id="fig-3", figure=fig3, config={"displaylogo": False}), style={'width': '33.3%'}),
                        html.Div(dcc.Graph(id="fig-4", figure=fig4, config={"displaylogo": False}), style={'width': '33.3%'}),
                        html.Div(dcc.Graph(id="fig-5", figure=fig5, config={"displaylogo": False}), style={'width': '33.3%'}),
                        html.Div(dcc.Graph(id="fig-6", figure=fig6, config={"displaylogo": False}), style={'width': '33.3%'}),
                    ], style={'display': 'flex', 'flexWrap': 'wrap'}),

                    # --- Pixel Info Panel ---
                    html.Div([
                        html.H4("Pixel Info (click on any index plot)", style={"marginBottom": "4px"}),
                        html.Div(id="pixel-info", children="Click on a pixel to see its values.",
                                 style={"padding": "8px", "background": "#f4f4f4", "borderRadius": "4px",
                                        "fontFamily": "monospace", "fontSize": "13px", "whiteSpace": "pre"})
                    ], style={"margin": "12px 0", "border": "1px solid #ddd", "padding": "10px", "borderRadius": "6px"}),

                    # --- Classification Parameters ---
                    html.Hr(),
                    html.H3("Classification Parameters", style={"marginBottom": "8px"}),

                    # Thresholds
                    html.Details([
                        html.Summary("Thresholds (enter real values, e.g. 0.3 for NDVI)", style={"fontWeight": "bold", "cursor": "pointer"}),
                        html.Div(make_threshold_inputs(), style={"padding": "8px 0"})
                    ], open=True, style={"marginBottom": "12px"}),

                    # Controllers
                    html.Details([
                        html.Summary("Controllers (Flag comparisons: A > B)", style={"fontWeight": "bold", "cursor": "pointer"}),
                        html.Div(make_controller_inputs(), style={"padding": "8px 0"})
                    ], open=True, style={"marginBottom": "12px"}),

                    # Classifier Rules & RGB Library (combined)
                    html.Details([
                        html.Summary("Classifier Rules & Colors (class name, color, and flag logic per rule)", style={"fontWeight": "bold", "cursor": "pointer"}),
                        html.Div(make_combined_rules_table(), style={"padding": "8px 0", "overflowX": "auto"})
                    ], open=True, style={"marginBottom": "12px"}),

                    # Run Button
                    html.Div([
                        html.Button("Run Classification", id="run-btn",
                                    style={"fontSize": "16px", "padding": "10px 32px", "backgroundColor": "#2196F3",
                                           "color": "white", "border": "none", "borderRadius": "4px", "cursor": "pointer"}),
                        dcc.Loading(id="loading", type="circle", children=[
                            html.Div(id="run-status", style={"marginTop": "8px", "fontStyle": "italic"})
                        ])
                    ], style={"textAlign": "center", "margin": "20px 0"}),
                ]),

                # ===== TAB 2: Classification Result =====
                dcc.Tab(label="Spectral Classification", value="tab-classification", children=[
                    dcc.Graph(id="classification-graph", figure=fig_main, config={"displaylogo": False})
                ])
            ],
        ),
    ],
)


# ====================== CALLBACKS ======================

# --- Pixel click callback ---
@callback(
    Output("pixel-info", "children"),
    [Input("fig-1", "clickData"), Input("fig-2", "clickData"), Input("fig-3", "clickData"),
     Input("fig-4", "clickData"), Input("fig-5", "clickData"), Input("fig-6", "clickData")],
)
def display_pixel_info(click1, click2, click3, click4, click5, click6):
    # Find the most recent click
    from dash import ctx
    clicks = {"fig-1": click1, "fig-2": click2, "fig-3": click3,
              "fig-4": click4, "fig-5": click5, "fig-6": click6}
    triggered = ctx.triggered_id
    if triggered is None:
        return "Click on a pixel to see its values."
    
    click_data = clicks.get(triggered)
    if click_data is None:
        return "Click on a pixel to see its values."
    
    point = click_data["points"][0]
    row, col = int(point["y"]), int(point["x"])
    
    # Bounds check
    if row < 0 or row >= ndvi_arr.shape[0] or col < 0 or col >= ndvi_arr.shape[1]:
        return "Out of bounds."
    
    info = (
        f"Pixel ({row}, {col})\n"
        f"{'─' * 30}\n"
        f"  NDVI:   {ndvi_arr[row, col]:.4f}\n"
        f"  MNDWI:  {mndwi_arr[row, col]:.4f}\n"
        f"  FDI:    {fdi_arr[row, col]:.4f}\n"
        f"  NDBI:   {ndbi_arr[row, col]:.4f}\n"
        f"  BSI:    {bsi_arr[row, col]:.4f}\n"
        f"  NDRE:   {ndre_arr[row, col]:.4f}\n"
        f"{'─' * 30}\n"
        f"  Raw bands: B={b_blue_g[row,col]:.0f} G={b_green_g[row,col]:.0f} "
        f"R={b_red_g[row,col]:.0f} NIR={b_nir_g[row,col]:.0f}\n"
        f"  RE1={b_re1_g[row,col]:.0f} RE2={b_re2_g[row,col]:.0f} "
        f"RE3={b_re3_g[row,col]:.0f} SWIR1={b_swir1_g[row,col]:.0f} SWIR2={b_swir2_g[row,col]:.0f}"
    )
    return info


# --- Update color swatches when hex input changes ---
@callback(
    [Output(f"rgb-swatch-{i}", "style") for i in range(8)],
    [Input(f"rgb-color-{i}", "value") for i in range(8)],
)
def update_swatches(*colors):
    styles = []
    for hex_color in colors:
        styles.append({
            "width": "24px", "height": "24px",
            "backgroundColor": hex_color or "#000000",
            "border": "1px solid #999", "borderRadius": "3px", "marginRight": "4px"
        })
    return styles


# --- Run Classification callback ---
@callback(
    Output("classification-graph", "figure"),
    Output("run-status", "children"),
    Input("run-btn", "n_clicks"),
    # Thresholds
    [State(f"th-{i}", "value") for i in range(6)] +
    # Controllers
    [State(f"ctrl-{i}", "value") for i in range(12)] +
    # Classifier Rules (8 rules × 6 flags = 48 dropdowns)
    [State(f"rule-{r}-{f}", "value") for r in range(8) for f in range(6)] +
    # RGB Library (names + colors)
    [State(f"rgb-name-{i}", "value") for i in range(8)] +
    [State(f"rgb-color-{i}", "value") for i in range(8)],
    prevent_initial_call=True
)
def run_classification(n_clicks, *args):
    if n_clicks is None:
        return no_update, ""
    
    # Parse args
    idx = 0
    # Thresholds (6 float values -> convert to Q1.8 integers)
    new_thresholds = [int(round(float(v or 0) * 256)) for v in args[idx:idx+6]]
    idx += 6
    # Controllers (12 values)
    new_controllers = list(args[idx:idx+12])
    idx += 12
    # Classifier rules (8×6 = 48 values -> encode to 8 integers)
    new_rules = []
    for r in range(8):
        rule_val = 0
        for f in range(6):
            flag_cfg = args[idx] or 0
            idx += 1
            rule_val |= (int(flag_cfg) & 0x3) << (f * 2)
        new_rules.append(rule_val)
    # RGB names (8)
    new_names = list(args[idx:idx+8])
    idx += 8
    # RGB colors (8 hex strings)
    new_colors_hex = list(args[idx:idx+8])
    idx += 8
    
    # Convert hex colors to [R, G, B] lists
    new_rgb_library = {}
    for name, hex_color in zip(new_names, new_colors_hex):
        hex_color = hex_color.lstrip('#')
        r_val = int(hex_color[0:2], 16)
        g_val = int(hex_color[2:4], 16)
        b_val = int(hex_color[4:6], 16)
        new_rgb_library[name] = [r_val, g_val, b_val]
    
    # Run classification
    new_fig = sentinel_data_processor(cube, new_thresholds, new_controllers, new_rules, new_rgb_library)
    
    return new_fig, f"Classification complete! ({time.strftime('%H:%M:%S')})"


if __name__ == '__main__':
    app.run(debug=True, use_reloader=False, port=8060)
