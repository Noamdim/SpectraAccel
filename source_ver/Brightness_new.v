module Brightness (clk, rst_n, valid_in, pixel_data, valid_out, brightness_out);
    input  wire        clk;
    input  wire        rst_n;      // Active low reset
    input  wire        valid_in;   // "Data Ready" signal from the bus
    input  wire [63:0] pixel_data; // The aligned 64-bit pixel
    
    output reg         valid_out;  // "Result Ready" signal
    output reg [2:0]   brightness_out; // 3-bit indicator (0=Dark, 7=Bright)


    // ---------------------------------------------------------
    // 1. Bit Slicing
    // ---------------------------------------------------------
    // Extracting the 4 visible/NIR bands
    wire [7:0] b_blue  = pixel_data[7:0];
    wire [7:0] b_green = pixel_data[15:8];
    wire [7:0] b_red   = pixel_data[23:16];
    wire [7:0] b_nir   = pixel_data[31:24];

    // ---------------------------------------------------------
    // 2. Pipeline Registers
    // ---------------------------------------------------------
    // Max sum is 255 * 4 = 1020. This fits perfectly in 10 bits.
    reg [9:0] pixel_sum;
    
    // We add a "dummy" valid register for Stage 1 to match the latency 
    // of the divider modules (MNDWI, etc.)
    reg stage1_valid;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_out      <= 0;
            stage1_valid   <= 0;
            brightness_out <= 0;
            pixel_sum      <= 0;
        end else begin
            // -------------------------------------------------
            // STAGE 1: Summation
            // -------------------------------------------------
            if (valid_in) begin
                // Sum all 4 bands. Synthesis tools will build a 
                // balanced adder tree here automatically.
                pixel_sum <= {2'b0, b_blue} + {2'b0, b_green} + 
                             {2'b0, b_red}  + {2'b0, b_nir};
                             
                stage1_valid <= 1;
            end else begin
                stage1_valid <= 0;
            end

            // -------------------------------------------------
            // STAGE 2: Quantization (Output Mapping)
            // -------------------------------------------------
            // Why Stage 2? To maintain 2-cycle latency parity 
            // with the other "division-heavy" modules.
            if (stage1_valid) begin
                // Take the top 3 bits [9:7]
                brightness_out <= pixel_sum[9:7];
                valid_out      <= 1;
            end else begin
                valid_out      <= 0;
            end
        end
    end

endmodule