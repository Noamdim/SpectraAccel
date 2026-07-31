module colorizer_pixel (
    clk, rst_n, valid_in,
    classification_vector,
    brightness_in, red_in, green_in, blue_in,
    rgb_library_packed,
    
    valid_out,
    red_out, green_out, blue_out
);

    // --- System Inputs ---
    input  wire        clk;
    input  wire        rst_n;
    input  wire        valid_in;

    // --- Decision Inputs ---
    input  wire [7:0]  classification_vector; // The 8-bit Rule Vector
    input  wire [2:0]  brightness_in;         // 0-7 Brightness Factor

    // --- Original Image (for "No Match" case) ---
    input  wire [7:0]  red_in;
    input  wire [7:0]  green_in;
    input  wire [7:0]  blue_in;

    // --- Configuration Inputs ---
    // 8 Rules * 24 bits (R,G,B) = 192 bits
    // Format: {Rule7_RGB, Rule6_RGB, ... Rule0_RGB}
    input  wire [191:0] rgb_library_packed;

    // --- Final Image Output ---
    output reg         valid_out;
    output reg [7:0]   red_out;
    output reg [7:0]   green_out;
    output reg [7:0]   blue_out;

    // =========================================================
    // 1. Unpack RGB Library
    // =========================================================
    // We create a 2D array for easier indexing: library[Rule][Channel]
    wire [7:0] lib_r [0:7];
    wire [7:0] lib_g [0:7];
    wire [7:0] lib_b [0:7];

    genvar k;
    generate
        for (k=0; k<8; k=k+1) begin : unpack_lib
            // Each rule is 24 bits: {R[7:0], G[7:0], B[7:0]}
            assign lib_r[k] = rgb_library_packed[(k*24)+23 : (k*24)+16];
            assign lib_g[k] = rgb_library_packed[(k*24)+15 : (k*24)+8];
            assign lib_b[k] = rgb_library_packed[(k*24)+7  : (k*24)];
        end
    endgenerate

    // =========================================================
    // 2. Priority Encoder & Base Color Selection
    // =========================================================
    reg [2:0] rule_idx;
    reg       match_found;
    
    // Temporary variables for the selected "Base Color"
    reg [7:0] base_r;
    reg [7:0] base_g;
    reg [7:0] base_b;

    // =========================================================
    // 3. Multiplier Variables (For Brightness Modulation)
    // =========================================================
    // 8-bit Color * 3-bit Brightness = 11-bit Result
    reg [10:0] mult_r;
    reg [10:0] mult_g;
    reg [10:0] mult_b;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_out <= 0;
            red_out   <= 0;
            green_out <= 0;
            blue_out  <= 0;
            match_found <= 0;
            rule_idx    <= 0;
        end else begin
            if (valid_in) begin
                valid_out <= 1;

                // --- Step A: Priority Encoder (Combinational Logic inside Clock) ---
                // Find the first '1' starting from Rule 0
				casez (classification_vector)
					8'b???????1: begin rule_idx <= 0; match_found <= 1; end
					8'b??????10: begin rule_idx <= 1; match_found <= 1; end
					8'b?????100: begin rule_idx <= 2; match_found <= 1; end
					8'b????1000: begin rule_idx <= 3; match_found <= 1; end
					8'b???10000: begin rule_idx <= 4; match_found <= 1; end
					8'b??100000: begin rule_idx <= 5; match_found <= 1; end
					8'b?1000000: begin rule_idx <= 6; match_found <= 1; end
					8'b10000000: begin rule_idx <= 7; match_found <= 1; end
					default:     begin rule_idx <= 0; match_found <= 0; end
				endcase

                // --- Step B: Select Base Color ---
                if (match_found) begin
                    // Pick from Library
                    base_r = lib_r[rule_idx];
                    base_g = lib_g[rule_idx];
                    base_b = lib_b[rule_idx];

                    // --- Step C: Apply Brightness Texture ---
                    // Formula: (Color * Brightness) / 8
                    // Division by 8 is just a logical shift right by 3 (>>> 3)
                    
                    mult_r = base_r * brightness_in;
                    mult_g = base_g * brightness_in;
                    mult_b = base_b * brightness_in;

                    // Output the textured color
                    // Note: If Brightness is 7, result is (Color * 7)/8 = ~87% intensity
                    // If Brightness is 0, result is Black.
                    red_out   <= mult_r[10:3];
                    green_out <= mult_g[10:3];
                    blue_out  <= mult_b[10:3];
                end 
                else begin
                    // --- Case: No Match (Pass Through Original) ---
                    red_out   <= red_in;
                    green_out <= green_in;
                    blue_out  <= blue_in;
                end

            end else begin
                valid_out <= 0;
            end
        end
    end

endmodule