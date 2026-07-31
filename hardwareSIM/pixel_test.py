"""
Standalone pixel tester for the hardware classification pipeline.
All configuration data is defined in hex.
Accepts an input pixel (8 bands as hex bytes) and prints the classified output.

Pixel band order: B02(Blue), B03(Green), B04(Red), B08(NIR), B05(RE1), B06(RE2), B07(RE3), B11(SWIR1)
All band values are uint8 (0x00 - 0xFF), already normalized.
"""

# ========================== CONFIGURATION (ALL HEX) ==========================

# --- Thresholds (Q1.8 signed: 0x100 = 1.0, 0x80 = 0.5) ---
# Th0 (FDI)=0.04,  Th1 (NDVI)=0.30,  Th2 (NDRE)=0.25
# Th3 (NDBI)=0.35, Th4 (MNDWI)=-0.10, Th5=unused
THRESHOLDS = [0x0B, 0x4D, 0x40, 0x5A, -0x1A, 0x00]
#              11     77     64    90    -26     0

# --- Controllers (MUX selectors for 6 comparator flags) ---
# MUX pool: 0=MNDWI, 1=NDVI, 2=NDBI, 3=NDRE, 4=BSI, 5=FDI
#           6=Th0, 7=Th1, 8=Th2, 9=Th3, 10=Th4, 11=Th5
#           0xC=ZERO, 0xD=ONE(256)
CONTROLLERS = [
    0x0, 0xC,   # Flag 0: MNDWI  > 0      (Water?)
    0x5, 0x6,   # Flag 1: FDI    > Th0     (Debris?)
    0x1, 0x7,   # Flag 2: NDVI   > Th1     (Vegetation?)
    0x3, 0x8,   # Flag 3: NDRE   > Th2     (High veg/build?)
    0x2, 0x9,   # Flag 4: NDBI   > Th3     (Glass?)
    0x4, 0x2,   # Flag 5: BSI    > NDBI    (Soil vs Urban?)
]

# --- Classifier Rules (12-bit each) ---
# Per-flag 2-bit encoding: 0x0=Ignore, 0x1=Must be FALSE, 0x3=Must be TRUE
# Bit layout: [F5][F4][F3][F2][F1][F0] (each 2 bits)
CLASSIFIER_RULES = [
    0x00F,  # Rule 0: "plastic or metal" -> F0=TRUE, F1=TRUE
    0x000,  # Rule 1: "water"            -> DISABLED (was 0x007)
    0x0F1,  # Rule 2: "trees"            -> F0=FALSE, F2=TRUE, F3=TRUE
    0x071,  # Rule 3: "field"            -> F0=FALSE, F2=TRUE, F3=FALSE
    0x311,  # Rule 4: "glass/solar"      -> F0=FALSE, F2=FALSE, F4=TRUE
    0x511,  # Rule 5: "Building"         -> F0=FALSE, F2=FALSE, F3=TRUE, F4=FALSE (was 0xDD1)
    0x000,  # Rule 6: "road"             -> DISABLED (was 0xD51)
    0x000,  # Rule 7: "soil"             -> DISABLED (was 0x511)
]

# --- RGB Library (8 entries, order matches rules) ---
RGB_LIBRARY = [
    [0xFF, 0xA5, 0x00],  # Rule 0: plastic or metal  (Orange)
    [0x33, 0x96, 0xF2],  # Rule 1: water             (Blue)
    [0x22, 0x8B, 0x22],  # Rule 2: trees             (Forest Green)
    [0x7C, 0xFC, 0x00],  # Rule 3: field             (Lawn Green)
    [0x94, 0x67, 0xBD],  # Rule 4: glass/solar panel (Purple)
    [0xDC, 0xDC, 0xDC],  # Rule 5: Building          (Light Gray)
    [0x32, 0x32, 0x37],  # Rule 6: road              (Dark Asphalt)
    [0x8B, 0x45, 0x13],  # Rule 7: soil              (Brown)
]

RGB_NAMES = [
    "plastic or metal",
    "water",
    "trees",
    "field",
    "glass/solar panel",
    "Building",
    "road",
    "soil",
]


# ========================== PIPELINE FUNCTIONS ==========================

def fixed_div(num, den, q_factor=8):
    """Fixed-point division: (num << Q) / den. Returns 0 if den=0."""
    if den == 0:
        return 0
    return int((num << q_factor) // den)


def process_pixel(pixel, thresholds, controllers, classifier_rules, rgb_library):
    """Simulates the full Verilog pipeline on a single normalized uint8 pixel."""

    # --- 1. Bit Slicing ---
    b_blue  = pixel[0]
    b_green = pixel[1]
    b_red   = pixel[2]
    b_nir   = pixel[3]
    b_re1   = pixel[4]
    b_re2   = pixel[5]
    b_re3   = pixel[6]
    b_swir1 = pixel[7]

    # --- 2. IPU (Index Calculation) - Q1.8 fixed point ---
    mndwi = fixed_div(b_green - b_swir1, b_green + b_swir1)
    ndvi  = fixed_div(b_nir - b_red, b_nir + b_red)
    ndre  = fixed_div(b_nir - b_re1, b_nir + b_re1)
    ndbi  = fixed_div(b_swir1 - b_nir, b_swir1 + b_nir)
    bsi   = fixed_div((b_swir1 + b_red) - (b_nir + b_blue),
                       (b_swir1 + b_red) + (b_nir + b_blue))
    fdi   = fixed_div((b_nir * 2) - (b_re2 + b_swir1),
                       (b_nir * 2) + (b_re2 + b_swir1))

    # Brightness: (sum of B,G,R,NIR) >> 7, take 3 bits
    pixel_sum = b_blue + b_green + b_red + b_nir
    brightness_idx = (pixel_sum >> 7) & 0x7

    print(f"\n--- Computed Indices (Q1.8, 256=1.0) ---")
    print(f"  MNDWI = {mndwi:>5d}  ({mndwi/256:.4f})")
    print(f"  NDVI  = {ndvi:>5d}  ({ndvi/256:.4f})")
    print(f"  NDBI  = {ndbi:>5d}  ({ndbi/256:.4f})")
    print(f"  NDRE  = {ndre:>5d}  ({ndre/256:.4f})")
    print(f"  BSI   = {bsi:>5d}  ({bsi/256:.4f})")
    print(f"  FDI   = {fdi:>5d}  ({fdi/256:.4f})")
    print(f"  Brightness idx = {brightness_idx}")

    # --- 3. Feature Selector (MUX pool) ---
    pool = [mndwi, ndvi, ndbi, ndre, bsi, fdi] + thresholds + [0, 256]

    mux_outputs = []
    for sel in controllers:
        mux_outputs.append(pool[sel] if sel < len(pool) else 0)

    # --- 4. Comparator (pairwise) ---
    flags = []
    for i in range(0, 12, 2):
        flags.append(mux_outputs[i] > mux_outputs[i + 1])

    print(f"\n--- Comparison Flags ---")
    flag_labels = ["Water(MNDWI>0)", "Debris(FDI>Th0)", "Veg(NDVI>Th1)",
                   "HighNDRE(>Th2)", "Glass(NDBI>Th3)", "Soil(BSI>NDBI)"]
    for i, (label, flag) in enumerate(zip(flag_labels, flags)):
        a, b = mux_outputs[i*2], mux_outputs[i*2+1]
        print(f"  Flag {i}: {label:22s} = {flag}  ({a} > {b})")

    # --- 5. Classifier (logical AND of enabled flags per rule) ---
    classification_vector = 0
    print(f"\n--- Classifier Rules ---")
    for r in range(8):
        rule_cfg = classifier_rules[r]
        if rule_cfg == 0x000:
            print(f"  Rule {r} [{RGB_NAMES[r]:20s}]: DISABLED")
            continue
        rule_result = True
        details = []
        for f in range(6):
            flag_cfg = (rule_cfg >> (f * 2)) & 0x3
            enable = flag_cfg & 0x1
            polarity = (flag_cfg >> 1) & 0x1
            if enable:
                term = flags[f] if polarity else not flags[f]
                rule_result = rule_result and term
                details.append(f"F{f}={'T' if polarity else '!T'}({term})")
        if rule_result:
            classification_vector |= (1 << r)
        print(f"  Rule {r} [{RGB_NAMES[r]:20s}]: {' AND '.join(details)} => {'MATCH' if rule_result else 'no'}")

    print(f"\n  Classification vector: 0x{classification_vector:02X} (bin: {classification_vector:08b})")

    # --- 6. Colorizer ---
    match_found = False
    rule_idx = 0
    for r in range(8):
        if (classification_vector >> r) & 0x1:
            rule_idx = r
            match_found = True
            break

    if match_found:
        base_color = rgb_library[rule_idx]
        brightness_idx = brightness_idx + 1
        r_out = (base_color[0] * brightness_idx) >> 3
        g_out = (base_color[1] * brightness_idx) >> 3
        b_out = (base_color[2] * brightness_idx) >> 3
        print(f"\n=== OUTPUT ===")
        print(f"  Matched Rule {rule_idx}: \"{RGB_NAMES[rule_idx]}\"")
        print(f"  Base color:   R=0x{base_color[0]:02X} G=0x{base_color[1]:02X} B=0x{base_color[2]:02X}")
        print(f"  Brightness:   {brightness_idx}/8")
        print(f"  Final pixel:  R=0x{r_out:02X} G=0x{g_out:02X} B=0x{b_out:02X}  ({r_out}, {g_out}, {b_out})")
        return [r_out, g_out, b_out]
    else:
        print(f"\n=== OUTPUT ===")
        print(f"  No rule matched -> passthrough original RGB")
        print(f"  Final pixel:  R=0x{b_red:02X} G=0x{b_green:02X} B=0x{b_blue:02X}  ({b_red}, {b_green}, {b_blue})")
        return [b_red, b_green, b_blue]


# ========================== MAIN ==========================

def parse_pixel_input(hex_str):
    """
    Parse pixel input from hex string.
    Accepts formats:
      - 8 separate hex bytes:   "1A 2B 3C 4D 5E 6F 70 80"
      - One concatenated hex:   "1A2B3C4D5E6F7080"  (16 hex chars = 8 bytes)
    """
    hex_str = hex_str.strip().replace("0x", "").replace(",", " ")

    parts = hex_str.split()
    if len(parts) == 8:
        return [int(p, 16) for p in parts]
    elif len(parts) == 1 and len(hex_str) == 16:
        return [int(hex_str[i:i+2], 16) for i in range(0, 16, 2)]
    else:
        raise ValueError(
            "Expected 8 hex bytes.\n"
            "  e.g. '1A 2B 3C 4D 5E 6F 70 80'\n"
            "  or   '1A2B3C4D5E6F7080'"
        )


if __name__ == "__main__":
    print("=" * 60)
    print("  HARDWARE PIXEL CLASSIFIER - Standalone Tester")
    print("=" * 60)
    print("\nCurrent Configuration:")
    print(f"  Thresholds:  {['0x{:02X}'.format(t & 0xFF) for t in THRESHOLDS]}")
    print(f"  Controllers: {['0x{:X}'.format(c) for c in CONTROLLERS]}")
    print(f"  Rules:       {['0x{:03X}'.format(r) for r in CLASSIFIER_RULES]}")
    print(f"  RGB Library:")
    for i, (name, color) in enumerate(zip(RGB_NAMES, RGB_LIBRARY)):
        print(f"    [{i}] {name:20s} -> #{color[0]:02X}{color[1]:02X}{color[2]:02X}")

    print("\nPixel band order: Blue, Green, Red, NIR, RE1, RE2, RE3, SWIR1")
    print("Enter pixel as 8 hex bytes (e.g. '1A 2B 3C 4D 5E 6F 70 80')")
    print("Type 'q' to quit.\n")

    while True:
        try:
            user_input = input("Pixel> ").strip()
        except (EOFError, KeyboardInterrupt):
            break

        if user_input.lower() in ('q', 'quit', 'exit'):
            break
        if not user_input:
            continue

        try:
            pixel = parse_pixel_input(user_input)
        except ValueError as e:
            print(f"Error: {e}")
            continue

        print(f"\nInput pixel (hex): {' '.join(f'0x{b:02X}' for b in pixel)}")
        print(f"  Blue={pixel[0]:3d}  Green={pixel[1]:3d}  Red={pixel[2]:3d}  NIR={pixel[3]:3d}")
        print(f"  RE1 ={pixel[4]:3d}  RE2  ={pixel[5]:3d}  RE3={pixel[6]:3d}  SWIR1={pixel[7]:3d}")

        process_pixel(pixel, THRESHOLDS, CONTROLLERS, CLASSIFIER_RULES, RGB_LIBRARY)
        print()
