module BSI (
    input  wire        clk,
    input  wire        rst_n,      // Active low reset
    input  wire        valid_in,   // "Data Ready" signal from the bus
    input  wire [63:0] pixel_data, // The aligned 64-bit pixel
    
    output wire        valid_out,  // High when result is ready
    output wire signed [15:0] bsi_out
);
    // Fixed Point Precision (Q1.8)
    parameter Q_FACTOR = 8;

    // --- 1. Bit Slicing (Sentinel-2 Aligned) ---
    // Blue:  Band 2  [7:0]
    // Red:   Band 4  [23:16]
    // NIR:   Band 8  [31:24]
    // SWIR1: Band 11 [63:56]
    wire [7:0] b_blue  = pixel_data[7:0];
    wire [7:0] b_red   = pixel_data[23:16];
    wire [7:0] b_nir   = pixel_data[31:24];
    wire [7:0] b_swir1 = pixel_data[63:56];

    // --- 2. Internal Signals ---
    // Registers are 12-bit signed to prevent overflow during sums
    // (Max sum of 4 unsigned 8-bit values is 1020)
    reg signed [11:0] numerator;   
    reg signed [11:0] denominator; 
    reg               vld_reg; 

    // Output from the divider (12-bit integer + 8-bit fraction = 20 bits)
    wire signed [19:0] q_res; 

    // --- 3. STAGE 1: Arithmetic Tree (1 Cycle Latency) ---
    // Formula: ((SWIR1 + Red) - (NIR + Blue)) / ((SWIR1 + Red) + (NIR + Blue))
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            vld_reg     <= 1'b0;
            numerator   <= 12'sd0;
            denominator <= 12'sd1;
        end else begin
            vld_reg <= valid_in;
            
            if (valid_in) begin
                // Calculating sub-sums with safe sign extension
                numerator   <= ($signed({1'b0, b_swir1}) + $signed({1'b0, b_red})) - 
                               ($signed({1'b0, b_nir})   + $signed({1'b0, b_blue}));
                               
                denominator <= ($signed({1'b0, b_swir1}) + $signed({1'b0, b_red})) + 
                               ($signed({1'b0, b_nir})   + $signed({1'b0, b_blue}));
            end
        end
    end

    // --- 4. STAGE 2: Pipelined Division (20 Cycles Latency) ---
    // Instantiating the 12-bit hardware divider.
    // Zero-division protection is handled internally by div_mod.
    // Total System Latency = 1 (Arithmetic) + 20 (Divider) = 21 Cycles.
    div_mod #(
        .IN_WIDTH(12),
        .SHIFT(Q_FACTOR)
    ) bsi_div_inst (
        .clk(clk),
        .reset_n(rst_n),
        .s_numerator(numerator),
        .s_denominator(denominator),
        .s_valid(vld_reg),
        .m_quotient(q_res),
        .m_valid(valid_out)
    );

    // --- 5. Output Assignment ---
    // Truncating to 16-bit Q1.8.
    // Normalized indices are strictly within the [-1.0, 1.0] range.
    assign bsi_out = q_res[15:0];

endmodule