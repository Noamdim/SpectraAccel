import numpy as np
import time
import rasterio
from rasterio.windows import Window
import matplotlib.pyplot as plt


def load_half_image_cropped(band_paths):
    # defining a crop window of half the map at the center (5490 by 5490 pixels)
    row_start, row_count = 2745, 4000
    col_start, col_count = 2745, 4000

    window_10m = rasterio.windows.Window(col_start, row_start, col_count, row_count)
    # a window parallel to the 20 meter channels (half the resolution, so the values are divided by 2)
    window_20m = rasterio.windows.Window(col_start // 2, row_start // 2, col_count // 2, row_count // 2)

    ordered_bands = ["B02", "B03", "B04", "B08", "B05", "B06", "B07", "B11", "B12"]
    cube_bands = []

    for b in ordered_bands:
        with rasterio.open(band_paths[b]) as src:
            if b in ["B02", "B03", "B04", "B08"]:
                # direct reading of half the area at 10 meter resolution
                data = src.read(1, window=window_10m).astype(np.float32)
            else:
                # reading the 20-meter channels and upsampling to the exact window size (5490x5490)
                data = src.read(
                    1,
                    window=window_20m,
                    out_shape=(row_count, col_count),
                    resampling=rasterio.enums.Resampling.bilinear
                ).astype(np.float32)
            cube_bands.append(data)

    return np.stack(cube_bands, axis=-1)


def normalize_to_uint8(cube):
    img = cube.astype(float)
    min_val, max_val = np.nanmin(img), np.nanmax(img)
    if max_val == min_val: return np.zeros_like(cube, dtype=np.uint8)
    return ((img - min_val) / (max_val - min_val) * 255).astype(np.uint8)


def fixed_div(num, den, q_factor=8):
    if den == 0: return 0
    return int((num << q_factor) // den)


# defining paths
path_pre = ".\\IMG_DATA\\"
band_paths_nat = {
    "B02": path_pre + "T36SXA_20260124T082231_B02_10m.jp2", "B03": path_pre + "T36SXA_20260124T082231_B03_10m.jp2",
    "B04": path_pre + "T36SXA_20260124T082231_B04_10m.jp2", "B08": path_pre + "T36SXA_20260124T082231_B08_10m.jp2",
    "B05": path_pre + "T36SXA_20260124T082231_B05_20m.jp2", "B06": path_pre + "T36SXA_20260124T082231_B06_20m.jp2",
    "B07": path_pre + "T36SXA_20260124T082231_B07_20m.jp2", "B11": path_pre + "T36SXA_20260124T082231_B11_20m.jp2",
    "B12": path_pre + "T36SXA_20260124T082231_B12_20m.jp2",
}

print("Loading 5490x5490 Cropped Data Cube (Half Size)...")
cube = load_half_image_cropped(band_paths_nat)
cube_uint8 = normalize_to_uint8(cube)
rows, cols, _ = cube_uint8.shape

# logic definitions and default rules
thresholds = [11, 77, 64, 90, -26, 0]
controllers = [0, 12, 5, 6, 1, 7, 3, 8, 2, 9, 4, 2]
classifier_rules = [0x00F, 0x000, 0x0F1, 0x071, 0x311, 0x511, 0x000, 0x000]

# arrays for storing the absolute errors of the metrics
errors_dict = {'MNDWI': [], 'NDVI': [], 'NDRE': [], 'NDBI': [], 'BSI': [], 'FDI': []}
match_count = 0
total_pixels = rows * cols

print("Processing pixels and comparing Float vs Fixed...")
eps = 1e-6

for r in range(rows):
    for c in range(cols):
        pixel = cube_uint8[r, c, :].astype(float)
        b_blue, b_green, b_red, b_nir, b_re1, b_re2, b_re3, b_swir1 = pixel[:8]

        # 1. floating point calculation (float - theoretical and ideal – uses float)
        mndwi_fl = (b_green - b_swir1) / (b_green + b_swir1 + eps)
        ndvi_fl = (b_nir - b_red) / (b_nir + b_red + eps)
        ndre_fl = (b_nir - b_re1) / (b_nir + b_re1 + eps)
        ndbi_fl = (b_swir1 - b_nir) / (b_swir1 + b_nir + eps)
        bsi_fl = ((b_swir1 + b_red) - (b_nir + b_blue)) / ((b_swir1 + b_red) + (b_nir + b_blue) + eps)
        fdi_fl = ((b_nir * 2) - (b_re2 + b_swir1)) / ((b_nir * 2) + (b_re2 + b_swir1) + eps)

        # conversion of channel values to integers, specifically for hardware simulation
        ib_blue, ib_green, ib_red, ib_nir, ib_re1, ib_re2, ib_re3, ib_swir1 = pixel[:8].astype(int)

        # 2. fixed point calculation (hardware simulation uses int)
        mndwi_fx = fixed_div(ib_green - ib_swir1, ib_green + ib_swir1)
        ndvi_fx = fixed_div(ib_nir - ib_red, ib_nir + ib_red)
        ndre_fx = fixed_div(ib_nir - ib_re1, ib_nir + ib_re1)
        ndbi_fx = fixed_div(ib_swir1 - ib_nir, ib_swir1 + ib_nir)
        bsi_fx = fixed_div((ib_swir1 + ib_red) - (ib_nir + ib_blue), (ib_swir1 + ib_red) + (ib_nir + ib_blue))
        fdi_fx = fixed_div((ib_nir * 2) - (ib_re2 + ib_swir1), (ib_nir * 2) + (ib_re2 + ib_swir1))

        # 3. calculating the absolute error (normalizing the fixed-point value back to the range of -1 to 1 by dividing by 256)
        errors_dict['MNDWI'].append(abs(mndwi_fl - (mndwi_fx / 256.0)))
        errors_dict['NDVI'].append(abs(ndvi_fl - (ndvi_fx / 256.0)))
        errors_dict['NDRE'].append(abs(ndre_fl - (ndre_fx / 256.0)))
        errors_dict['NDBI'].append(abs(ndbi_fl - (ndbi_fx / 256.0)))
        errors_dict['BSI'].append(abs(bsi_fl - (bsi_fx / 256.0)))
        errors_dict['FDI'].append(abs(fdi_fl - (fdi_fx / 256.0)))

        # 4. verification of the synchronization of the rules logical flags across the two models
        pool_fx = [mndwi_fx, ndvi_fx, ndbi_fx, ndre_fx, bsi_fx, fdi_fx] + thresholds + [0, 256]
        flags_fx = [pool_fx[controllers[i]] > pool_fx[controllers[i + 1]] for i in range(0, 12, 2)]

        pool_fl = [int(mndwi_fl * 256), int(ndvi_fl * 256), int(ndbi_fl * 256), int(ndre_fl * 256), int(bsi_fl * 256),
                   int(fdi_fl * 256)] + thresholds + [0, 256]
        flags_fl = [pool_fl[controllers[i]] > pool_fl[controllers[i + 1]] for i in range(0, 12, 2)]

        if flags_fx == flags_fl:
            match_count += 1

# calculation of accuracy percentages
accuracy = (match_count / total_pixels) * 100

print("\n" + "="*50)
print("             STATISTICAL REPORT FOR POSTER")
print("="*50)
print(f"Total Pixels Analyzed: {total_pixels:,}")
print(f"Pixels Classified Identically: {match_count:,}")
print(f"Hardware Classification Accuracy (Match %): {accuracy:.4f}%")
print(f"Average Hardware Classification Error: {100 - accuracy:.4f}%")
print("-"*50)
print("Mean Absolute Error (MAE) Per Spectral Indicator:")

indicators_list = []
mae_list = []

for ind, err_list in errors_dict.items():
    mae = np.mean(err_list)
    indicators_list.append(ind)
    mae_list.append(mae)
    print(f"  -> {ind}: {mae:.6f}")
print("="*50)

# creating the professional bar chart for the poster (sorted from highest to lowest error)
sorted_indices = np.argsort(mae_list)[::-1]
indicators_list = [indicators_list[i] for i in sorted_indices]
mae_list = [mae_list[i] for i in sorted_indices]

plt.figure(figsize=(9, 5.5))
bars = plt.bar(indicators_list, mae_list, color='#2196F3', edgecolor='black', alpha=0.85, width=0.6)

plt.title('Hardware Quantization Noise Analysis\nMean Absolute Error (MAE) per Spectral Indicator (Fixed vs. Float)', fontsize=13, fontweight='bold', pad=15)
plt.ylabel('Mean Absolute Error (MAE)', fontsize=11, fontweight='bold')
plt.xlabel('Spectral Indicator', fontsize=11, fontweight='bold')
plt.grid(axis='y', linestyle='--', alpha=0.5)

for bar in bars:
    yval = bar.get_height()
    plt.text(bar.get_x() + bar.get_width()/2.0, yval + (max(mae_list)*0.01), f'{yval:.5f}', ha='center', va='bottom', fontsize=10, fontweight='bold', color='#333333')

plt.ylim(0, max(mae_list) * 1.15)
plt.tight_layout()

# saving the graph in DPI300
plt.savefig('indicator_errors_poster.png', dpi=300)
print("Success: Poster graph saved as 'indicator_errors_poster.png'!")