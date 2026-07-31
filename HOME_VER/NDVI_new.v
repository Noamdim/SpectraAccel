module NDVI (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        valid_in,
    input  wire [63:0] pixel_data, // Aligned pixel data from sensor/memory
    
    output wire        valid_out,  // High when result is ready
    output wire signed [15:0] ndvi_out
);
    // Fixed Point Precision (Q1.8)
    parameter Q_FACTOR = 8;

    // --- 1. Bit Slicing (Sentinel-2 Spectral Bands) ---
    // NIR: Band 8 [31:24], Red: Band 4 [23:16]
    wire [7:0] b_nir = pixel_data[31:24];
    wire [7:0] b_red = pixel_data[23:16];

    // --- 2. Pipeline Stage 1: Arithmetic Calculation ---
    // Formula: NDVI = (NIR - Red) / (NIR + Red)
    reg signed [9:0] numerator;   
    reg signed [9:0] denominator;
    reg              vld_reg;

    wire signed [17:0] q_res;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            numerator   <= 10'sd0;
            denominator <= 10'sd1;
            vld_reg     <= 1'b0;
        end else begin
            vld_reg <= valid_in;
            if (valid_in) begin
                // Safe sign extension for unsigned pixel values
                numerator   <= $signed({1'b0, b_nir}) - $signed({1'b0, b_red});
                denominator <= $signed({1'b0, b_nir}) + $signed({1'b0, b_red});
            end
        end
    end

    // --- 3. Pipeline Stage 2: Pipelined Division (18 Cycles) ---
    div_mod #(
        .IN_WIDTH(10),
        .SHIFT(Q_FACTOR)
    ) ndvi_div_inst (
        .clk(clk),
        .reset_n(rst_n),
        .s_numerator(numerator),
        .s_denominator(denominator),
        .s_valid(vld_reg),
        .m_quotient(q_res),
        .m_valid(valid_out)
    );

    // Final result truncation to 16-bit Q1.8 format
    assign ndvi_out = q_res[15:0];

endmodule