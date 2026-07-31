`timescale 1ns / 1ps

module Accelerator_Subsystem (
    input  wire        CLK,
    input  wire        RESET,
    
    // Slave Interface (from bus to accel_slave)
    input  wire [9:0]  AI,
    input  wire [31:0] MDO_muxed,
    input  wire        Card_Sel,
    input  wire        WR_IN_N,
    output wire        SACK_N_ACCEL,
    output wire [31:0] SDO_ACCEL,
    
    // Master Interface (from stream_controller to bus)
    output wire        sc_AS_N,
    output wire        sc_WR_OUT_N,
    output wire [31:0] sc_MAO,
    output wire [31:0] sc_MDO,
    input  wire        sc_ack_n,
    input  wire [31:0] DO,
    
    // Sideband & Control
    input  wire        classify_pulse,
    input  wire [31:0] MDO, // cls_src
    input  wire [31:0] MAO, // cls_dst
    
    output wire        accel_active,
    output wire [4:0]  wf_count,
    output wire [3:0]  debug_accel
);

// --- Internal Wires ---
wire        sc_mr, sc_mw;
wire        start_proc_pulse, done_proc_flag;
assign debug_accel = {accel_active, done_proc_flag, start_proc_pulse, classify_pulse};
wire [95:0]  w_thresholds;
wire [47:0]  w_selector_ctrl;
wire [95:0]  w_classifier_rules;
wire [191:0] w_rgb_library;
wire [31:0]  w_src_addr, w_dst_addr;
wire [15:0]  w_pixel_count;

// FIFO wires
wire        rf_wr_en, rf_rd_en, rf_full, rf_empty, rf_almost_full;
wire [63:0] rf_din, rf_dout;
wire        wf_wr_en, wf_rd_en, wf_full, wf_empty, wf_almost_full;
wire [31:0] wf_din, wf_dout;

// SpectraAccel wires
wire        sa_valid_in, sa_valid_out;
wire [63:0] sa_pixel_data;
wire [7:0]  sa_r, sa_g, sa_b;

// --- accel_slave ---
accel_slave u_accel_slave (
    .clk(CLK), .reset(RESET),
    .AI(AI), .bus_data_in(MDO_muxed),
    .CARD_SEL(Card_Sel), .WR_IN_N(WR_IN_N),
    .SACK_N(SACK_N_ACCEL), .SDO(SDO_ACCEL),
    .classify_pulse(classify_pulse),
    .cls_src(MDO),
    .cls_dst(MAO),
    .thresholds_packed(w_thresholds),
    .selector_ctrl_packed(w_selector_ctrl),
    .classifier_rules_packed(w_classifier_rules),
    .rgb_library_packed(w_rgb_library),
    .src_addr(w_src_addr), .dst_addr(w_dst_addr),
    .pixel_count(w_pixel_count),
    .start_proc(start_proc_pulse),
    .done_proc(done_proc_flag),
    .accel_active(accel_active)
);

// --- stream_controller ---
stream_controller u_stream_ctrl (
    .clk(CLK), .rst_n(~RESET),
    .start_proc(start_proc_pulse),
    .src_addr(w_src_addr), .dst_addr(w_dst_addr),
    .pixel_count(w_pixel_count),
    .done_proc(done_proc_flag),
    .mr(sc_mr), .mw(sc_mw),
    .mao(sc_MAO), .mdo(sc_MDO),
    .ack_n(sc_ack_n), .di(DO),
    .rd_fifo_wr_en(rf_wr_en), .rd_fifo_din(rf_din),
    .rd_fifo_full(rf_full), .rd_fifo_empty(rf_empty),
    .rd_fifo_rd_en(rf_rd_en), .rd_fifo_dout(rf_dout),
    .wr_fifo_wr_en(wf_wr_en), .wr_fifo_din(wf_din),
    .wr_fifo_full(wf_full), .wr_fifo_almost_full(wf_almost_full),
    .wr_fifo_empty(wf_empty),
    .wr_fifo_rd_en(wf_rd_en), .wr_fifo_dout(wf_dout),
    .accel_valid_in(sa_valid_in), .accel_pixel_data(sa_pixel_data),
    .accel_valid_out(sa_valid_out),
    .accel_r(sa_r), .accel_g(sa_g), .accel_b(sa_b)
);

// --- MAC_SM for stream controller bus protocol ---
wire sc_busy = (sc_mr | sc_mw) & sc_ack_n;
reg  sc_busy_d1;
always @(posedge CLK) begin
     if(RESET) sc_busy_d1 <= 1'b0;
	  else sc_busy_d1 <= sc_busy;
end
wire sc_busy_reg = sc_busy | sc_busy_d1;
assign sc_AS_N     = ~sc_busy_reg;
assign sc_WR_OUT_N = ~(sc_busy_reg & sc_mw);

// --- read_fifo ---
read_fifo u_rd_fifo (
    .clk(CLK), .rst_n(~RESET),
    .wr_en(rf_wr_en), .din(rf_din), .full(rf_full), .almost_full(rf_almost_full),
    .rd_en(rf_rd_en), .dout(rf_dout), .empty(rf_empty), .almost_empty(),
    .count()
);

// --- write_fifo ---
write_fifo u_wr_fifo (
    .clk(CLK), .rst_n(~RESET),
    .wr_en(wf_wr_en), .din(wf_din), .full(wf_full), .almost_full(wf_almost_full),
    .rd_en(wf_rd_en), .dout(wf_dout), .empty(wf_empty), .almost_empty(),
    .count(wf_count)
);

// --- SpectraAccel ---
SpectraAccel u_spectra (
    .clk(CLK), .rst_n(~RESET),
    .valid_in(sa_valid_in), .pixel_data(sa_pixel_data),
    .thresholds_packed(w_thresholds),
    .selector_ctrl_packed(w_selector_ctrl),
    .classifier_rules_packed(w_classifier_rules),
    .rgb_library_packed(w_rgb_library),
    .valid_out(sa_valid_out),
    .red_out(sa_r), .green_out(sa_g), .blue_out(sa_b)
);

endmodule
