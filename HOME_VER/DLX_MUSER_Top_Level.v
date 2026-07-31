`timescale 1ns / 1ps

module DLX_MUSER_Top_Level(ACK_N, 
                           CLK, 
                           DI, 
                           D_addr, 
                           RESET, 
                           STEP_EN, 
                           Ace, 
                           add, 
                           AEQZ, 
                           ALUF, 
                           Asel, 
                           AS_N, 
                           Bce, 
                           BUSY, 
                           Cce, 
                           ctrl_dlx_state, 
                           DINTsel, 
                           DO, 
                           D_MONITOR, 
                           GPR_WE, 
                           IN_INIT, 
                           IR, 
                           IRce, 
                           Itype, 
                           Jlink, 
                           MAC_STATE, 
                           MAO, 
                           MARce, 
                           MDRce, 
                           MDRsel, 
                           MR, 
                           MW, 
                           opcode, 
                           PCce, 
                           REQ, 
                           SHIFTce, 
                           SHIFTright, 
                           STOP_N, 
                           S1sel, 
                           S2sel, 
                           Test, 
                           WR_OUT_N,
                           classify_pulse);

    input ACK_N;
    input CLK;
    input [31:0] DI;
    input [4:0] D_addr;
    input RESET;
    input STEP_EN;
   output Ace;
   output add;
   output AEQZ;
   output [2:0] ALUF;
   output Asel;
   output AS_N;
   output Bce;
   output BUSY;
   output Cce;
   output [4:0] ctrl_dlx_state;
   output DINTsel;
   output [31:0] DO;
   output [31:0] D_MONITOR;
   output GPR_WE;
   output IN_INIT;
   output [31:0] IR;
   output IRce;
   output Itype;
   output Jlink;
   output [1:0] MAC_STATE;
   output [31:0] MAO;
   output MARce;
   output MDRce;
   output MDRsel;
   output MR;
   output MW;
   output [5:0] opcode;
   output PCce;
   output REQ;
   output SHIFTce;
   output SHIFTright;
   output STOP_N;
   output [1:0] S1sel;
   output [1:0] S2sel;
   output Test;
   output WR_OUT_N;
   output classify_pulse;
   
   wire MARce_DUMMY;
   wire [31:0] IR_DUMMY;
   wire Test_DUMMY;
   wire Bce_DUMMY;
   wire add_DUMMY;
   wire [1:0] S1sel_DUMMY;
   wire Jlink_DUMMY;
   wire MDRsel_DUMMY;
   wire DINTsel_DUMMY;
   wire Ace_DUMMY;
   wire [1:0] S2sel_DUMMY;
   wire MDRce_DUMMY;
   wire GPR_WE_DUMMY;
   wire PCce_DUMMY;
   wire SHIFTright_DUMMY;
   wire AEQZ_DUMMY;
   wire Cce_DUMMY;
   wire Asel_DUMMY;
   wire Itype_DUMMY;
   wire IRce_DUMMY;
   wire SHIFTce_DUMMY;
   
   assign Ace = Ace_DUMMY;
   assign add = add_DUMMY;
   assign AEQZ = AEQZ_DUMMY;
   assign Asel = Asel_DUMMY;
   assign Bce = Bce_DUMMY;
   assign Cce = Cce_DUMMY;
   assign DINTsel = DINTsel_DUMMY;
   assign GPR_WE = GPR_WE_DUMMY;
   assign IR[31:0] = IR_DUMMY[31:0];
   assign IRce = IRce_DUMMY;
   assign Itype = Itype_DUMMY;
   assign Jlink = Jlink_DUMMY;
   assign MARce = MARce_DUMMY;
   assign MDRce = MDRce_DUMMY;
   assign MDRsel = MDRsel_DUMMY;
   assign PCce = PCce_DUMMY;
   assign SHIFTce = SHIFTce_DUMMY;
   assign SHIFTright = SHIFTright_DUMMY;
   assign S1sel[1:0] = S1sel_DUMMY[1:0];
   assign S2sel[1:0] = S2sel_DUMMY[1:0];
   assign Test = Test_DUMMY;
   CONTROL_sch_MUSER_Top_Level  XLXI_1 (.ACK_N(ACK_N), 
                                       .AEQZ(AEQZ_DUMMY), 
                                       .CLK(CLK), 
                                       .IR(IR_DUMMY[31:0]), 
                                       .RESET(RESET), 
                                       .STEP_EN(STEP_EN), 
                                       .Ace(Ace_DUMMY), 
                                       .add(add_DUMMY), 
                                       .Asel(Asel_DUMMY), 
                                       .AS_N(AS_N), 
                                       .Bce(Bce_DUMMY), 
                                       .BUSY(BUSY), 
                                       .Cce(Cce_DUMMY), 
                                       .ctrl_dlx_state(ctrl_dlx_state[4:0]), 
                                       .DINTsel(DINTsel_DUMMY), 
                                       .GPR_WE(GPR_WE_DUMMY), 
                                       .IN_INIT(IN_INIT), 
                                       .IRce(IRce_DUMMY), 
                                       .Itype(Itype_DUMMY), 
                                       .Jlink(Jlink_DUMMY), 
                                       .MAC_STATE(MAC_STATE[1:0]), 
                                       .MARce(MARce_DUMMY), 
                                       .MDRce(MDRce_DUMMY), 
                                       .MDRsel(MDRsel_DUMMY), 
                                       .MR(MR), 
                                       .MW(MW), 
                                       .PCce(PCce_DUMMY), 
                                       .REQ(REQ), 
                                       .SHIFTce(SHIFTce_DUMMY), 
                                       .SHIFTright(SHIFTright_DUMMY), 
                                       .STOP_N(STOP_N), 
                                       .S1sel(S1sel_DUMMY[1:0]), 
                                       .S2sel(S2sel_DUMMY[1:0]), 
                                       .Test(Test_DUMMY), 
                                       .WR_OUT_N(WR_OUT_N),
                                       .classify_pulse(classify_pulse));
   DATAPATH_MUSER_Top_Level  XLXI_2 (.Ace(Ace_DUMMY), 
                                    .add(add_DUMMY), 
                                    .Asel(Asel_DUMMY), 
                                    .Bce(Bce_DUMMY), 
                                    .Cce(Cce_DUMMY), 
                                    .CLK(CLK), 
                                    .DI(DI[31:0]), 
                                    .DINTsel(DINTsel_DUMMY), 
                                    .D_addr(D_addr[4:0]), 
                                    .GPR_WE(GPR_WE_DUMMY), 
                                    .IRce(IRce_DUMMY), 
                                    .Itype(Itype_DUMMY), 
                                    .Jlink(Jlink_DUMMY), 
                                    .MARce(MARce_DUMMY), 
                                    .MDRce(MDRce_DUMMY), 
                                    .MDRsel(MDRsel_DUMMY), 
                                    .PCce(PCce_DUMMY), 
                                    .RESET(RESET), 
                                    .SHIFTce(SHIFTce_DUMMY), 
                                    .SHIFTright(SHIFTright_DUMMY), 
                                    .S1sel(S1sel_DUMMY[1:0]), 
                                    .S2sel(S2sel_DUMMY[1:0]), 
                                    .Test(Test_DUMMY), 
                                    .AEQZ(AEQZ_DUMMY), 
                                    .ALUF(ALUF[2:0]), 
                                    .DO(DO[31:0]), 
                                    .D_MONITOR(D_MONITOR[31:0]), 
                                    .IR(IR_DUMMY[31:0]), 
                                    .MAO(MAO[31:0]), 
                                    .opcode(opcode[5:0]));
endmodule
