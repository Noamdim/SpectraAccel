module SpectraAccel (
    // --- Clock & Reset ---
    input  wire        clk,
    input  wire        rst_n,

    // --- Stream Interface (Input) ---
    input  wire        valid_in,
    input  wire [63:0] pixel_data,

    // --- Configuration Registers (The "Software" Control) ---
    // 1. Feature Selector Controls
    input  wire [95:0] thresholds_packed,      // 6 x 16-bit Thresholds
    input  wire [47:0] selector_ctrl_packed,   // 12 x 4-bit Mux Selectors
    
    // 2. Classifier Controls
    input  wire [95:0] classifier_rules_packed,// 8 Rules x 12 bits (Logic Def)
    
    // 3. Colorizer Controls
    input  wire [191:0] rgb_library_packed,    // 8 Rules x 24 bits (Output Colors)

    // --- Stream Interface (Output) ---
    output wire        valid_out,
    output wire [7:0]  red_out,
    output wire [7:0]  green_out,
    output wire [7:0]  blue_out
);

    parameter Q_FACTOR = 8; // Global Precision Setting

    // =========================================================
    // 1. Interconnect Wires (The Pipeline "Veins")
    // =========================================================
    
    // --- Stage 1 Output: Indices ---
    wire        val_s1;
    wire signed [15:0] w_mndwi, w_ndvi, w_ndbi, w_ndre, w_bsi, w_fdi;
    wire [2:0]  w_bright_s1;
    wire [7:0]  w_r_s1, w_g_s1, w_b_s1;

    // --- Stage 2 Output: Selected Features ---
    wire        val_s2;
    wire [191:0] w_mux_packed;
    wire [2:0]  w_bright_s2;
    wire [7:0]  w_r_s2, w_g_s2, w_b_s2;

    // --- Stage 3 Output: Comparison Flags ---
    wire        val_s3;
    wire [5:0]  w_flags;
    wire [2:0]  w_bright_s3;
    wire [7:0]  w_r_s3, w_g_s3, w_b_s3;

    // --- Stage 4 Output: Classification Vector ---
    wire        val_s4;
    wire [7:0]  w_class_vector;
    wire [2:0]  w_bright_s4;
    wire [7:0]  w_r_s4, w_g_s4, w_b_s4;
    // --- Pipeline Stage Delay Registers ---
    reg valid_in_d1 = 1'b0;
    reg val_s1_d1   = 1'b0;
    reg val_s2_d1   = 1'b0;
    reg val_s3_d1   = 1'b0;
    reg val_s4_d1   = 1'b0;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_in_d1 <= 1'b0;
            val_s1_d1   <= 1'b0;
            val_s2_d1   <= 1'b0;
            val_s3_d1   <= 1'b0;
            val_s4_d1   <= 1'b0;
        end else begin
            valid_in_d1 <= valid_in;
            val_s1_d1   <= val_s1;
            val_s2_d1   <= val_s2;
            val_s3_d1   <= val_s3;
            val_s4_d1   <= val_s4;
        end
    end


    // =========================================================
    // 2. Module Instantiations (The "Organs")
    // =========================================================

    // ---------------------------------------------------------
    // Stage 1: Index Processing Unit (IPU)
    // Calc IPU and extract brightness/RGB
    // ---------------------------------------------------------
    IPU #(
        .Q_FACTOR(Q_FACTOR)
    ) u_ipu (
        .clk(clk), .rst_n(rst_n), .valid_in(valid_in), 
        .pixel_data(pixel_data),
        
        // Outputs
        .valid_out(val_s1),
        .mndwi(w_mndwi), .ndvi(w_ndvi), .ndbi(w_ndbi), 
        .ndre(w_ndre), .bsi(w_bsi), .fdi(w_fdi),
        .brightness(w_bright_s1),
        .red_out(w_r_s1), .green_out(w_g_s1), .blue_out(w_b_s1)
    );

    // ---------------------------------------------------------
    // Stage 2: Feature Selector
    // Route 6 IPU + 6 thresholds -> 12 comparison values
    // ---------------------------------------------------------
    feature_selector #(
        .Q_FACTOR(Q_FACTOR)
    ) u_selector (
        .clk(clk), .rst_n(rst_n), .valid_in(val_s1),
        
        // Data Inputs from IPU
        .mndwi(w_mndwi), .ndvi(w_ndvi), .ndbi(w_ndbi), 
        .ndre(w_ndre), .bsi(w_bsi), .fdi(w_fdi),
        .brightness(w_bright_s1), 
        .red_in(w_r_s1), .green_in(w_g_s1), .blue_in(w_b_s1),
        
        // Config Inputs
        .thresholds_packed(thresholds_packed),
        .controllers_packed(selector_ctrl_packed),
        
        // Outputs
        .valid_out(val_s2),
        .mux_outputs_packed(w_mux_packed),
        .brightness_out(w_bright_s2),
        .red_out(w_r_s2), .green_out(w_g_s2), .blue_out(w_b_s2)
    );

    // ---------------------------------------------------------
    // Stage 3: Comparator Block
    // Compare the 12 selected values (Evens vs Odds)
    // ---------------------------------------------------------
    comparator_block u_comparator (
        .clk(clk), .rst_n(rst_n), .valid_in(val_s2),
        
        // Data Inputs
        .mux_outputs_packed(w_mux_packed),
        .brightness_in(w_bright_s2),
        .red_in(w_r_s2), .green_in(w_g_s2), .blue_in(w_b_s2),
        
        // Outputs
        .valid_out(val_s3),
        .comparison_flags(w_flags),
        .brightness_out(w_bright_s3),
        .red_out(w_r_s3), .green_out(w_g_s3), .blue_out(w_b_s3)
    );

    // ---------------------------------------------------------
    // Stage 4: Classifier Core
    // Apply programmable boolean rules to flags
    // ---------------------------------------------------------
    logical_expressions u_classifier (
        .clk(clk), .rst_n(rst_n), .valid_in(val_s3),
        
        // Data Inputs
        .comparison_flags(w_flags),
        .brightness_in(w_bright_s3),
        .red_in(w_r_s3), .green_in(w_g_s3), .blue_in(w_b_s3),
        
        // Config Inputs
        .classifier_rules_packed(classifier_rules_packed),
        
        // Outputs
        .valid_out(val_s4),
        .classification_vector(w_class_vector),
        .brightness_out(w_bright_s4),
        .red_out(w_r_s4), .green_out(w_g_s4), .blue_out(w_b_s4)
    );

    // ---------------------------------------------------------
    // Stage 5: Colorizer (Visualizer)
    // Apply RGB Library colors + Texture
    // ---------------------------------------------------------
    colorizer_pixel u_colorizer (
        .clk(clk), .rst_n(rst_n), .valid_in(val_s4),
        
        // Data Inputs
        .classification_vector(w_class_vector),
        .brightness_in(w_bright_s4),
        .red_in(w_r_s4), .green_in(w_g_s4), .blue_in(w_b_s4),
        
        // Config Inputs
        .rgb_library_packed(rgb_library_packed),
        
        // Final Outputs
        .valid_out(valid_out),
        .red_out(red_out),
        .green_out(green_out),
        .blue_out(blue_out)
    );

endmodule