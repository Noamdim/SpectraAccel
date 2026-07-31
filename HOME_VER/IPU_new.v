// Index Processing Unit (IPU)
// Aligned to 21 clock cycles (Maximum Latency of 12-bit cores)
module IPU (
    input  wire        clk,
    input  wire        rst_n,      // Active low reset
    input  wire        valid_in,   // Data Ready from bus
    input  wire [63:0] pixel_data, // 64-bit aligned pixel
    
    output wire        valid_out,
    
    // Spectral Indices (Synchronized)
    output wire signed [15:0] mndwi, ndvi, ndbi, ndre, bsi, fdi,
    
    // Indicators & RGB Pass-through
    output wire [2:0]  brightness,
    output wire [7:0]  red_out, green_out, blue_out
);
    parameter Q_FACTOR = 8;
    localparam MAX_LATENCY = 23; // 1 (arith) + 12 (width) + 8 (shift) // FIXME

    // =========================================================
    // 1. Data Delay Line (RGB & Valid Synchronization)
    // =========================================================
    // Addresses FIXME: Delay updated to match current div_mod latency
    wire [7:0] raw_swir1 = pixel_data[63:56];
    wire [7:0] raw_swir2 = pixel_data[55:48];
    wire [7:0] raw_re2   = pixel_data[47:40];
    wire [7:0] raw_re1   = pixel_data[39:32];
    wire [7:0] raw_nir   = pixel_data[31:24];
    wire [7:0] raw_red   = pixel_data[23:16];
    wire [7:0] raw_green = pixel_data[15:8];
    wire [7:0] raw_blue  = pixel_data[7:0];

    reg [23:0] rgb_pipe [0:MAX_LATENCY-1];
    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Addresses FIXME: Synchronized reset
            for (i = 0; i < MAX_LATENCY; i = i + 1)
                rgb_pipe[i] <= 24'd0;
        end else begin
            if (valid_in)
                rgb_pipe[0] <= {raw_red, raw_green, raw_blue};
            else
                rgb_pipe[0] <= rgb_pipe[0]; // Keep last or zero depending on bus policy

            for (i = 1; i < MAX_LATENCY; i = i + 1)
                rgb_pipe[i] <= rgb_pipe[i-1];
        end
    end

    assign {red_out, green_out, blue_out} = rgb_pipe[MAX_LATENCY-1];

    // =========================================================
    // 2. Core Instantiations
    // =========================================================
    wire vld_19, vld_21;
    wire signed [15:0] raw_ndvi, raw_mndwi, raw_ndbi, raw_ndre;

    // --- 19-Cycle Latency Group (10-bit Input) ---
    NDVI  #(.Q_FACTOR(Q_FACTOR)) u_ndvi  (.clk(clk), .rst_n(rst_n), .valid_in(valid_in), .pixel_data(pixel_data), .valid_out(vld_19), .ndvi_out(raw_ndvi));
    MNDWI #(.Q_FACTOR(Q_FACTOR)) u_mndwi (.clk(clk), .rst_n(rst_n), .valid_in(valid_in), .pixel_data(pixel_data), .valid_out(),       .mndwi_out(raw_mndwi));
    NDBI  #(.Q_FACTOR(Q_FACTOR)) u_ndbi  (.clk(clk), .rst_n(rst_n), .valid_in(valid_in), .pixel_data(pixel_data), .valid_out(),       .ndbi_out(raw_ndbi));
    NDRE  #(.Q_FACTOR(Q_FACTOR)) u_ndre  (.clk(clk), .rst_n(rst_n), .valid_in(valid_in), .pixel_data(pixel_data), .valid_out(),       .ndre_out(raw_ndre));

    // --- 21-Cycle Latency Group (12-bit Input) ---
    // These cores drive the master valid_out
    BSI   #(.Q_FACTOR(Q_FACTOR)) u_bsi   (.clk(clk), .rst_n(rst_n), .valid_in(valid_in), .pixel_data(pixel_data), .valid_out(vld_21), .bsi_out(bsi));
    ndFDI #(.Q_FACTOR(Q_FACTOR)) u_fdi   (.clk(clk), .rst_n(rst_n), .valid_in(valid_in), .pixel_data(pixel_data), .valid_out(),       .fdi_out(fdi));

    // =========================================================
    // 3. Output Alignment (Compensating the 2-cycle gap)
    // =========================================================
    // raw_ndvi arrives 2 cycles before BSI's valid_out and rgb_pipe
    reg [63:0] align_reg_1;
    reg [63:0] align_reg_2;
    always @(posedge clk) begin
        align_reg_1 <= {raw_ndvi, raw_mndwi, raw_ndbi, raw_ndre};
        align_reg_2 <= align_reg_1;
    end

    assign {ndvi, mndwi, ndbi, ndre} = align_reg_2;
    
    // Addresses FIXME: valid_out logic synced to the slowest path
    assign valid_out = vld_21;

    // =========================================================
    // 4. Brightness Core + Alignment Delay
    // =========================================================
    // Brightness module has 2-cycle latency. We need 19 more cycles
    // of delay to align with the 21-cycle index path.
    localparam BRIGHT_DELAY = MAX_LATENCY - 2; // 21 - 2 = 19

    wire [2:0] brightness_raw;

    Brightness u_bright (
        .clk(clk), .rst_n(rst_n), .valid_in(valid_in),
        .pixel_data(pixel_data), .valid_out(),
        .brightness_out(brightness_raw)
    );

    // 19-stage shift register for brightness alignment
    reg [2:0] bright_pipe [0:BRIGHT_DELAY-1];
    integer j;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (j = 0; j < BRIGHT_DELAY; j = j + 1)
                bright_pipe[j] <= 3'd0;
        end else begin
            bright_pipe[0] <= brightness_raw;
            for (j = 1; j < BRIGHT_DELAY; j = j + 1)
                bright_pipe[j] <= bright_pipe[j-1];
        end
    end

    assign brightness = bright_pipe[BRIGHT_DELAY-1];

endmodule