`timescale 1ns / 1ps

module bus_master_mux (
    input  wire        accel_active,
    
    // DLX Master Signals
    input  wire        dlx_AS_N,
    input  wire        dlx_WR_OUT_N,
    input  wire [31:0] dlx_MAO,
    input  wire [31:0] dlx_MDO,
    output wire        dlx_ACK_N,
    
    // Stream Controller Master Signals
    input  wire        sc_AS_N,
    input  wire        sc_WR_OUT_N,
    input  wire [31:0] sc_MAO,
    input  wire [31:0] sc_MDO,
    output wire        sc_ack_n,
    
    // Muxed outputs to IO_LOGIC_U / Bus
    output wire        AS_N_muxed,
    output wire        WR_OUT_N_muxed,
    output wire [31:0] MAO_muxed,
    output wire [31:0] MDO_muxed,
    input  wire        ACK_N_raw,
    
    // Slave Merge Inputs
    input  wire [9:0]  AI,
    input  wire [31:0] SDO_MON,
    input  wire [31:0] SDO_ACCEL,
    
    // Slave Merge Outputs
    output wire [31:0] SDO_final
);

    assign AS_N_muxed     = accel_active ? sc_AS_N     : dlx_AS_N;
    assign WR_OUT_N_muxed = accel_active ? sc_WR_OUT_N : dlx_WR_OUT_N;
    assign MAO_muxed      = accel_active ? sc_MAO      : dlx_MAO;
    assign MDO_muxed      = accel_active ? sc_MDO      : dlx_MDO;

    assign dlx_ACK_N      = accel_active ? 1'b1        : ACK_N_raw;
    assign sc_ack_n       = accel_active ? ACK_N_raw   : 1'b1;

    wire accel_addr_match = AI[7] & ~AI[8] & ~AI[9];
    assign SDO_final      = accel_addr_match ? SDO_ACCEL : SDO_MON;

endmodule
