module NDRE (
    input  wire        clk,
    input  wire        rst_n,      // Active low reset
    input  wire        valid_in,   // "Data Ready" signal from the bus
    input  wire [63:0] pixel_data, // The aligned 64-bit pixel
    
    output wire        valid_out,  // High when result is ready
    output wire signed [15:0] ndre_out
);
    // Q1.8 format: 1 sign bit, 7 integer bits, 8 fractional bits
    parameter Q_FACTOR = 8;

    // --- 1. Bit Slicing (Sentinel-2 Aligned) ---
    // NIR: Band 8 [31:24]
    // RE1: Band 5 [39:32]
    wire [7:0] b_nir = pixel_data[31:24];
    wire [7:0] b_re1 = pixel_data[39:32];

    // --- 2. Internal Signals ---
    reg signed [9:0] numerator;   
    reg signed [9:0] denominator;
    reg              vld_reg; // Synchronizes valid signal with Stage 1 delay

    // Output from the 18-stage divider (10-bit integer + 8-bit fraction)
    wire signed [17:0] q_res; 

    // --- 3. STAGE 1: Arithmetic Preparation (1 Cycle Latency) ---
    // Formula: NDRE = (NIR - RE1) / (NIR + RE1)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            numerator   <= 10'sd0;
            denominator <= 10'sd1;
            vld_reg     <= 1'b0;
        end else begin
            vld_reg <= valid_in;
            if (valid_in) begin
                // Safe sign extension for unsigned 8-bit pixels
                numerator   <= $signed({1'b0, b_nir}) - $signed({1'b0, b_re1});
                denominator <= $signed({1'b0, b_nir}) + $signed({1'b0, b_re1});
            end
        end
    end

    // --- 4. STAGE 2: Pipelined Division (18 Cycles Latency) ---
    // Zero-division protection is handled internally by the div_mod module.
    // Total System Latency = 1 (Arithmetic) + 18 (Divider) = 19 Cycles.
    div_mod #(
        .IN_WIDTH(10),
        .SHIFT(Q_FACTOR)
    ) ndre_div_inst (
        .clk(clk),
        .reset_n(rst_n),
        .s_numerator(numerator),
        .s_denominator(denominator),
        .s_valid(vld_reg),
        .m_quotient(q_res),
        .m_valid(valid_out)
    );

    // Final result truncation to 16-bit Q1.8 format.
    // Normalized indices are strictly within the [-1.0, 1.0] range.
    assign ndre_out = q_res[15:0];

endmodule