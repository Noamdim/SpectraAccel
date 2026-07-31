module ndFDI (
    input  wire        clk,
    input  wire        rst_n,      // Active low reset
    input  wire        valid_in,   // "Data Ready" signal from the bus
    input  wire [63:0] pixel_data, // The aligned 64-bit pixel
    
    output wire        valid_out,  // High when result is ready
    output wire signed [15:0] fdi_out
);
    // Q1.8 format: 1 sign bit, 7 integer bits (unused here), 8 fractional bits
    parameter Q_FACTOR = 8;

    // --- 1. Bit Slicing (Sentinel-2 Aligned) ---
    // NIR   = bits [31:24]
    // RE2   = bits [47:40]
    // SWIR1 = bits [63:56]
    wire [7:0] b_nir   = pixel_data[31:24];
    wire [7:0] b_re2   = pixel_data[47:40];
    wire [7:0] b_swir1 = pixel_data[63:56];

    // --- 2. Internal Signals ---
    // Width increased to 12 bits to safely store (2 * 255)
    reg signed [11:0] numerator;   
    reg signed [11:0] denominator; 
    reg               stage1_valid; 

    // Output from the divider (12-bit integer + 8-bit fraction = 20 bits)
    wire signed [19:0] q_res; 

    // --- 3. STAGE 1: Arithmetic & Alignment (1 Cycle Latency) ---
    // Formula: (2*NIR - (RE2 + SWIR1)) / (2*NIR + (RE2 + SWIR1))
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stage1_valid <= 1'b0;
            numerator    <= 12'sd0;
            denominator  <= 12'sd1;
        end else begin
            stage1_valid <= valid_in;
            
            if (valid_in) begin
                // Safe sign extension and bit-shifting for NIR multiplication
                // (NIR << 1) is a zero-cost wire shift in hardware
                numerator   <= ($signed({1'b0, b_nir}) <<< 1) - 
                               ($signed({1'b0, b_re2}) + $signed({1'b0, b_swir1}));
                               
                denominator <= ($signed({1'b0, b_nir}) <<< 1) + 
                               ($signed({1'b0, b_re2}) + $signed({1'b0, b_swir1}));
            end
        end
    end

    // --- 4. STAGE 2: Pipelined Division (20 Cycles Latency) ---
    // Instantiating the custom divider with 12-bit input width
    // Total Latency = 1 (Arithmetic) + 20 (Divider) = 21 Cycles
    div_mod #(
        .IN_WIDTH(12),
        .SHIFT(Q_FACTOR)
    ) fdi_div_inst (
        .clk(clk),
        .reset_n(rst_n),
        .s_numerator(numerator),
        .s_denominator(denominator),
        .s_valid(stage1_valid),
        .m_quotient(q_res),
        .m_valid(valid_out)
    );

    // --- 5. Output Assignment ---
    // Truncating to 16-bit Q1.8. 
    // Normalized indices are always between -1.0 and 1.0.
    assign fdi_out = q_res[15:0];

endmodule