`timescale 1ns / 1ps

module Top_Level_SIM(CLK_IN, 
                     RST_IN, 
                     STEP_IN);

    input CLK_IN;
    input RST_IN;
    input STEP_IN;

    wire fpgaClk_i = CLK_IN;
    wire IN_INIT;

   
   wire ACK_N;
   wire [9:0] AI;
   wire AS_N;
   wire Card_Sel;
   wire CLK;
   wire [4:0] DLX_STATE;
   wire [31:0] DO;
   wire [31:0] D_GPR;
   wire [31:0] LA_DATA_IN;
   wire [1:0] MAC_STATE;
   wire [31:0] MAO;
   wire [31:0] MDO;
   wire RACK_N;
   wire [4:0] REG_ADDR;
   wire RESET;
   wire Rsel;
   wire [31:0] R_DO;
   wire SACK_N;
   wire [31:0] SDO;
   wire STEP_EN;
   wire STOP_N;
   wire WR_IN_N;
   wire WR_OUT_N;
   wire [1:0] XLXN_31;
   wire XLXN_33;
   wire XLXN_34;
   wire XLXN_35;
   wire XLXN_36;
   wire XLXN_38;
   wire XLXN_39;
   wire [5:0] XLXN_40;
   wire XLXN_43;
   wire [2:0] XLXN_44;
   wire [1:0] XLXN_47;
   wire XLXN_49;
   wire XLXN_50;
   wire XLXN_51;
   wire XLXN_52;
   wire XLXN_53;
   wire XLXN_54;
   wire XLXN_55;
   wire XLXN_56;
   wire XLXN_57;
   wire XLXN_58;
   wire XLXN_59;
   wire XLXN_60;
   wire XLXN_61;
   wire XLXN_64;
   wire XLXN_65;
   wire [31:0] XLXN_66;
   
// =========================================================
// Accelerator Subsystem
// =========================================================

// --- Wires ---
wire        accel_active;
wire        sc_AS_N, sc_WR_OUT_N;
wire [31:0] sc_MAO, sc_MDO;
wire        sc_mr, sc_mw;
wire        sc_ack_n;
wire        start_proc_pulse, done_proc_flag;
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

// Slave interface wires
wire        SACK_N_ACCEL;
wire [31:0] SDO_ACCEL;

// Classify instruction sideband
wire        classify_pulse;

// --- accel_slave ---
accel_slave u_accel_slave (
    .clk(CLK), .reset(RESET),
    .AI(AI), .bus_data_in(MDO_muxed),        // DO from IO_LOGIC_U
    .CARD_SEL(Card_Sel), .WR_IN_N(WR_IN_N),
    .SACK_N(SACK_N_ACCEL), .SDO(SDO_ACCEL),
    .classify_pulse(classify_pulse),
    .cls_src(MDO),                    // DLX's MDO = Rs (source addr)
    .cls_dst(MAO),                    // DLX's MAO = Rs+imm (dest addr)
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
    .ack_n(sc_ack_n), .di(DO),       // Read data from bus
    // FIFO connections
    .rd_fifo_wr_en(rf_wr_en), .rd_fifo_din(rf_din),
    .rd_fifo_full(rf_full), .rd_fifo_empty(rf_empty),
    .rd_fifo_rd_en(rf_rd_en), .rd_fifo_dout(rf_dout),
    .wr_fifo_wr_en(wf_wr_en), .wr_fifo_din(wf_din),
    .wr_fifo_full(wf_full), .wr_fifo_almost_full(wf_almost_full),
    .wr_fifo_empty(wf_empty),
    .wr_fifo_rd_en(wf_rd_en), .wr_fifo_dout(wf_dout),
    // SpectraAccel connections
    .accel_valid_in(sa_valid_in), .accel_pixel_data(sa_pixel_data),
    .accel_valid_out(sa_valid_out),
    .accel_r(sa_r), .accel_g(sa_g), .accel_b(sa_b)
);

// --- MAC_SM for stream controller bus protocol ---
wire sc_busy = (sc_mr | sc_mw) & sc_ack_n;
reg  sc_busy_d1;
always @(posedge CLK) sc_busy_d1 <= sc_busy;
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
    .count()
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

// =========================================================
// BUS MUX (switches master between DLX and stream controller)
// =========================================================
wire AS_N_muxed     = accel_active ? sc_AS_N     : AS_N;
wire WR_OUT_N_muxed = accel_active ? sc_WR_OUT_N : WR_OUT_N;
wire [31:0] MAO_muxed = accel_active ? sc_MAO    : MAO;
wire [31:0] MDO_muxed = accel_active ? sc_MDO    : MDO;

// =========================================================
// Replicate IO_LOGIC_U address-decode signals for simulation
// (IO_SIM does not generate these; in real HW they come from IO_LOGIC_U)
// =========================================================
assign AI       = MAO_muxed[9:0];
assign Card_Sel = MAO_muxed[10];    // Bit 10 distinguishes slave I/O space from SRAM
assign WR_IN_N  = WR_OUT_N_muxed;

// =========================================================
// SACK_N / SDO MERGE (two slaves)
// =========================================================
wire accel_addr_match = AI[7] & ~AI[8] & ~AI[9];
wire SACK_N_final = SACK_N & SACK_N_ACCEL;
wire [31:0] SDO_final = accel_addr_match ? SDO_ACCEL : SDO;

// ACK_N routing (IO_SIM drives ACK_N directly)
wire combined_ACK_N = ACK_N & SACK_N_final;
wire dlx_ACK_N = accel_active ? 1'b1      : combined_ACK_N;
assign sc_ack_n = accel_active ? combined_ACK_N : 1'b1;

// Mux DO from slaves vs IO_SIM
wire [31:0] combined_DO = (SACK_N_final == 1'b0) ? SDO_final : DO;

   IO_SIM  XLXI_23 (.AS_N(AS_N_muxed), 
                       .CLK_IN(CLK_IN), 
                       .RST_IN(RST_IN),
                       .STEP_IN(STEP_IN),
                       .MAO(MAO_muxed), 
                       .MDO(MDO_muxed), 
                       .WR_N(WR_OUT_N_muxed), 
                       .CLK(CLK), 
                       .DO(DO[31:0]), 
                       .ACK_N(ACK_N), 
                       .RST(RESET), 
                       .STEP(STEP_EN));
   Monitor_lab4_MUSER_Top_Level  XLXI_29 (.AI(AI[9:0]), 
                                         .B(MAO[31:0]), 
                                         .C(D_GPR[31:0]), 
                                         .CARD_SEL(Card_Sel), 
                                         .CLK(CLK), 
                                         .IN_INIT(IN_INIT), 
                                         .LA_Data_in(LA_DATA_IN[31:0]), 
                                         .RESET(RESET), 
                                         .STEP_EN(STEP_EN), 
                                         .STOP_N(STOP_N), 
                                         .WR_IN_N(WR_IN_N), 
                                         .reg_address(REG_ADDR[4:0]), 
                                         .SACK_N(SACK_N), 
                                         .SDO(SDO[31:0]));
   DLX_MUSER_Top_Level  XLXI_30 (.ACK_N(dlx_ACK_N), 
                                .CLK(CLK), 
                                .DI(combined_DO[31:0]), 
                                .D_addr(REG_ADDR[4:0]), 
                                .RESET(RESET), 
                                .STEP_EN(STEP_EN), 
                                .Ace(XLXN_58), 
                                .add(XLXN_54), 
                                .AEQZ(XLXN_65), 
                                .ALUF(XLXN_44[2:0]), 
                                .Asel(XLXN_33), 
                                .AS_N(AS_N), 
                                .Bce(XLXN_57), 
                                .BUSY(XLXN_64), 
                                .Cce(XLXN_56), 
                                .ctrl_dlx_state(DLX_STATE[4:0]), 
                                .DINTsel(XLXN_52), 
                                .DO(MDO[31:0]), 
                                .D_MONITOR(D_GPR[31:0]), 
                                .GPR_WE(XLXN_49), 
                                .IN_INIT(IN_INIT), 
                                .IR(XLXN_66[31:0]), 
                                .IRce(XLXN_59), 
                                .Itype(XLXN_43), 
                                .Jlink(XLXN_34), 
                                .MAC_STATE(MAC_STATE[1:0]), 
                                .MAO(MAO[31:0]), 
                                .MARce(XLXN_36), 
                                .MDRce(XLXN_50), 
                                .MDRsel(XLXN_35), 
                                .MR(XLXN_60), 
                                .MW(XLXN_61), 
                                .opcode(XLXN_40[5:0]), 
                                .PCce(XLXN_55), 
                                .REQ(XLXN_38), 
                                .SHIFTce(XLXN_39), 
                                .SHIFTright(XLXN_51), 
                                .STOP_N(STOP_N), 
                                .S1sel(XLXN_47[1:0]), 
                                .S2sel(XLXN_31[1:0]), 
                                .Test(XLXN_53), 
                                .WR_OUT_N(WR_OUT_N),
                                .classify_pulse(classify_pulse));
   BUF  XLXI_31 (.I(STEP_EN), 
                .O(LA_DATA_IN[0]));
   BUF  XLXI_32 (.I(dlx_ACK_N), 
                .O(LA_DATA_IN[1]));
   BUF  XLXI_33 (.I(IN_INIT), 
                .O(LA_DATA_IN[2]));
   BUF  XLXI_34 (.I(AS_N), 
                .O(LA_DATA_IN[3]));
   BUF  XLXI_35 (.I(WR_OUT_N), 
                .O(LA_DATA_IN[4]));
   BUF  XLXI_36 (.I(DLX_STATE[0]), 
                .O(LA_DATA_IN[5]));
   BUF  XLXI_37 (.I(DLX_STATE[1]), 
                .O(LA_DATA_IN[6]));
   BUF  XLXI_38 (.I(DLX_STATE[2]), 
                .O(LA_DATA_IN[7]));
   BUF  XLXI_39 (.I(DLX_STATE[3]), 
                .O(LA_DATA_IN[8]));
   BUF  XLXI_40 (.I(DLX_STATE[4]), 
                .O(LA_DATA_IN[9]));
   BUF  XLXI_41 (.I(MAC_STATE[0]), 
                .O(LA_DATA_IN[10]));
   BUF  XLXI_42 (.I(MAC_STATE[1]), 
                .O(LA_DATA_IN[11]));
endmodule
