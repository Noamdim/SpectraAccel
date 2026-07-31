module feature_selector (
    clk, rst_n, valid_in, 
    mndwi, ndvi, ndbi, ndre, bsi, fdi, brightness, red_in, green_in, blue_in,
    thresholds_packed, controllers_packed,
    valid_out, mux_outputs_packed, 
    brightness_out, red_out, green_out, blue_out
);
    
    parameter Q_FACTOR = 8;     // Fixed Point Precision

    // --- System Inputs ---
    input  wire        clk;
    input  wire        rst_n;       // Active low reset
    input  wire        valid_in;    // "Data Ready" from IPU

    // --- Inputs from IPU (Indices) ---
    input  wire signed [15:0] mndwi;
    input  wire signed [15:0] ndvi;
    input  wire signed [15:0] ndbi;
    input  wire signed [15:0] ndre;
    input  wire signed [15:0] bsi;
    input  wire signed [15:0] fdi;

    // --- Inputs from IPU (Pass-Throughs) ---
    input  wire [2:0]  brightness;
    input  wire [7:0]  red_in;
    input  wire [7:0]  green_in;
    input  wire [7:0]  blue_in;

    // --- Configuration Inputs ---
    // 6 Thresholds (16-bit each) packed: {Th5, Th4, Th3, Th2, Th1, Th0}
    input  wire [95:0] thresholds_packed; 
    // 12 Controllers (4-bit each) packed: {C11, C10, ... C0}
    input  wire [47:0] controllers_packed;

    // --- Outputs ---
    output reg         valid_out;
    
    // 12 Selected Values (16-bit each) packed: {Val11, ... Val0}
    output reg [191:0] mux_outputs_packed;

    // --- Pass-Through Outputs (Synchronized) ---
    output reg [2:0]   brightness_out;
    output reg [7:0]   red_out;
    output reg [7:0]   green_out;
    output reg [7:0]   blue_out;


    // =========================================================
    // 1. Unpack Configuration
    // =========================================================
    // Unpacking thresholds for easier indexing
    wire signed [15:0] th [0:5];
    assign th[0] = thresholds_packed[15:0];
    assign th[1] = thresholds_packed[31:16];
    assign th[2] = thresholds_packed[47:32];
    assign th[3] = thresholds_packed[63:48];
    assign th[4] = thresholds_packed[79:64];
    assign th[5] = thresholds_packed[95:80];

    // Unpacking controllers (selectors)
    wire [3:0] sel [0:11];
    genvar k;
    generate
        for (k=0; k<12; k=k+1) begin : unpack_ctrl
            assign sel[k] = controllers_packed[(k*4)+3 : (k*4)];
        end
    endgenerate

    // =========================================================
    // 2. Define the MUX Input Pool (The 14 Entries)
    // =========================================================
    // We create an array of wires to act as the "Menu" for the MUXs.
    wire signed [15:0] mux_pool [0:13];

    // Constants definition (Q1.8)
    localparam signed [15:0] CONST_ZERO = 16'd0;
    localparam signed [15:0] CONST_ONE  = 16'd256; // 1.0 in Q8

    // Mapping inputs to the pool
    assign mux_pool[0]  = mndwi;
    assign mux_pool[1]  = ndvi;
    assign mux_pool[2]  = ndbi;
    assign mux_pool[3]  = ndre;
    assign mux_pool[4]  = bsi;
    assign mux_pool[5]  = fdi;
    
    assign mux_pool[6]  = th[0];
    assign mux_pool[7]  = th[1];
    assign mux_pool[8]  = th[2];
    assign mux_pool[9]  = th[3];
    assign mux_pool[10] = th[4];
    assign mux_pool[11] = th[5];
    
    assign mux_pool[12] = CONST_ZERO;
    assign mux_pool[13] = CONST_ONE;

    // =========================================================
    // 3. MUX Logic & Output Registration
    // =========================================================
    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_out          <= 0;
            mux_outputs_packed <= 0;
            red_out            <= 0;
            green_out          <= 0;
            blue_out           <= 0;
            brightness_out     <= 0;
        end else begin
            // Pass-through pipeline logic
            if (valid_in) begin
                valid_out      <= 1;
                
                // Pass RGB/Brightness through directly
                red_out        <= red_in;
                green_out      <= green_in;
                blue_out       <= blue_in;
                brightness_out <= brightness;

                // The 12 MUXs Logic
                for (i = 0; i < 12; i = i + 1) begin
                    // If selector > 13 (invalid), default to 0
                    if (sel[i] > 13)
                        mux_outputs_packed[(i*16)+15 -: 16] <= CONST_ZERO;
                    else
                        mux_outputs_packed[(i*16)+15 -: 16] <= mux_pool[sel[i]];
                end
                
            end else begin
                valid_out <= 0;
            end
        end
    end

endmodule