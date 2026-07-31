`timescale 1ns / 1ps

module DLX_Wrapper (
    // Core Clock & Reset
    input  wire        CLK,
    input  wire        RESET,
    
    // Bus Interface
    input  wire        ACK_N,
    input  wire [31:0] DI,
    output wire        AS_N,
    output wire        WR_OUT_N,
    output wire [31:0] MAO,
    output wire [31:0] DO,
    
    // Sideband & Control
    output wire        classify_pulse,
    
    // Debug & Monitor Interface
    input  wire        STEP_EN,
    input  wire [4:0]  D_addr,
    output wire [4:0]  ctrl_dlx_state,
    output wire [1:0]  MAC_STATE,
    output wire        STOP_N,
    output wire [31:0] D_MONITOR,
    output wire        IN_INIT,
	 // External Debug Signals
    input  wire [4:0]  wf_count,
    input  wire [3:0]  debug_accel,

    // Logic Analyzer Data
    output wire [31:0] LA_DATA_IN
);

    // Instantiate the original DLX module, leaving unused ports disconnected
	 
	 wire raw_IN_INIT;
    wire accel_active_w = debug_accel[3];
    assign IN_INIT = raw_IN_INIT & ~accel_active_w;

	 
    DLX_Top_Level u_dlx_core (
        .ACK_N(ACK_N),
        .CLK(CLK),
        .DI(DI),
        .D_addr(D_addr),
        .RESET(RESET),
        .STEP_EN(STEP_EN),
        
        .AS_N(AS_N),
        .WR_OUT_N(WR_OUT_N),
        .MAO(MAO),
        .DO(DO),
        .ctrl_dlx_state(ctrl_dlx_state),
        .MAC_STATE(MAC_STATE),
        .STOP_N(STOP_N),
        .D_MONITOR(D_MONITOR),
        .IN_INIT(raw_IN_INIT), //IN_INIT
        .classify_pulse(classify_pulse),
        
        // Unused Ports (left floating)
        .Ace(),
        .add(),
        .AEQZ(),
        .ALUF(),
        .Asel(),
        .Bce(),
        .BUSY(),
        .Cce(),
        .DINTsel(),
        .GPR_WE(),
        .IR(),
        .IRce(),
        .Itype(),
        .Jlink(),
        .MARce(),
        .MDRce(),
        .MDRsel(),
        .MR(),
        .MW(),
        .opcode(),
        .PCce(),
        .REQ(),
        .SHIFTce(),
        .SHIFTright(),
        .S1sel(),
        .S2sel(),
        .Test()
    );

    // 12 Buffers for Logic Analyzer data
    BUF  buf_la0  (.I(STEP_EN),           .O(LA_DATA_IN[0]));
    BUF  buf_la1  (.I(ACK_N),             .O(LA_DATA_IN[1]));
    BUF  buf_la2  (.I(IN_INIT),           .O(LA_DATA_IN[2]));
    BUF  buf_la3  (.I(AS_N),              .O(LA_DATA_IN[3]));
    BUF  buf_la4  (.I(WR_OUT_N),          .O(LA_DATA_IN[4]));
    BUF  buf_la5  (.I(ctrl_dlx_state[0]), .O(LA_DATA_IN[5]));
    BUF  buf_la6  (.I(ctrl_dlx_state[1]), .O(LA_DATA_IN[6]));
    BUF  buf_la7  (.I(ctrl_dlx_state[2]), .O(LA_DATA_IN[7]));
    BUF  buf_la8  (.I(ctrl_dlx_state[3]), .O(LA_DATA_IN[8]));
    BUF  buf_la9  (.I(ctrl_dlx_state[4]), .O(LA_DATA_IN[9]));
    BUF  buf_la10 (.I(MAC_STATE[0]),      .O(LA_DATA_IN[10]));
    BUF  buf_la11 (.I(MAC_STATE[1]),      .O(LA_DATA_IN[11]));
    // Inject the write_fifo count into bits 16:12
    assign LA_DATA_IN[16:12] = wf_count;
    
    // Inject the Accelerator signals into bits 20:17
    assign LA_DATA_IN[20:17] = debug_accel;
	 
	 // Fill the remaining bits with zeros
    assign LA_DATA_IN[31:21] = 11'b0;


endmodule
