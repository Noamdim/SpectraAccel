module comparator_block (
    clk, rst_n, valid_in, 
    mux_outputs_packed, 
    brightness_in, red_in, green_in, blue_in,
    
    valid_out, 
    comparison_flags,
    brightness_out, red_out, green_out, blue_out
);

    // --- System Inputs ---
    input  wire        clk;
    input  wire        rst_n;
    input  wire        valid_in;

    // --- Data Inputs ---
    // 12 x 16-bit values = 192 bits
    input  wire [191:0] mux_outputs_packed; 
    
    // --- Pass-Through Inputs ---
    input  wire [2:0]  brightness_in;
    input  wire [7:0]  red_in;
    input  wire [7:0]  green_in;
    input  wire [7:0]  blue_in;

    // --- Outputs ---
    output reg         valid_out;
    
    // 6 Boolean Flags (1 bit each)
    // flag[0] = (Val0 > Val1)
    // ...
    // flag[5] = (Val10 > Val11)
    output reg [5:0]   comparison_flags;

    // --- Pass-Through Outputs ---
    output reg [2:0]   brightness_out;
    output reg [7:0]   red_out;
    output reg [7:0]   green_out;
    output reg [7:0]   blue_out;

    // =========================================================
    // 1. Unpacking the 192-bit Bus
    // =========================================================
    wire signed [15:0] val [0:11];
    
    genvar k;
    generate
        for (k=0; k<12; k=k+1) begin : unpack_vals
            // Extract 16-bit chunks
            assign val[k] = mux_outputs_packed[(k*16)+15 : (k*16)];
        end
    endgenerate

    // =========================================================
    // 2. Comparison Logic (Registered)
    // =========================================================
    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_out        <= 0;
            comparison_flags <= 0;
            red_out          <= 0;
            green_out        <= 0;
            blue_out         <= 0;
            brightness_out   <= 0;
        end else begin
            if (valid_in) begin
                valid_out <= 1;

                // Pass-Throughs
                red_out        <= red_in;
                green_out      <= green_in;
                blue_out       <= blue_in;
                brightness_out <= brightness_in;

                // Comparisons (Pairwise)
                // We assume a "Greater Than" logic: A > B
                // Since inputs are signed, this handles negative indices correctly.
                
                comparison_flags[0] <= (val[0]  > val[1]);
                comparison_flags[1] <= (val[2]  > val[3]);
                comparison_flags[2] <= (val[4]  > val[5]);
                comparison_flags[3] <= (val[6]  > val[7]);
                comparison_flags[4] <= (val[8]  > val[9]);
                comparison_flags[5] <= (val[10] > val[11]);

            end else begin
                valid_out <= 0;
            end
        end
    end

endmodule