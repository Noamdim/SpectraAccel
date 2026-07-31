`timescale 1ns / 1ps

module DATAPATH_MUSER_Top_Level(Ace, 
                                add, 
                                Asel, 
                                Bce, 
                                Cce, 
                                CLK, 
                                DI, 
                                DINTsel, 
                                D_addr, 
                                GPR_WE, 
                                IRce, 
                                Itype, 
                                Jlink, 
                                MARce, 
                                MDRce, 
                                MDRsel, 
                                PCce, 
                                RESET, 
                                SHIFTce, 
                                SHIFTright, 
                                S1sel, 
                                S2sel, 
                                Test, 
                                AEQZ, 
                                ALUF, 
                                DO, 
                                D_MONITOR, 
                                IR, 
                                MAO, 
                                opcode);

    input Ace;
    input add;
    input Asel;
    input Bce;
    input Cce;
    input CLK;
    input [31:0] DI;
    input DINTsel;
    input [4:0] D_addr;
    input GPR_WE;
    input IRce;
    input Itype;
    input Jlink;
    input MARce;
    input MDRce;
    input MDRsel;
    input PCce;
    input RESET;
    input SHIFTce;
    input SHIFTright;
    input [1:0] S1sel;
    input [1:0] S2sel;
    input Test;
   output AEQZ;
   output [2:0] ALUF;
   output [31:0] DO;
   output [31:0] D_MONITOR;
   output [31:0] IR;
   output [31:0] MAO;
   output [5:0] opcode;
   
   wire [31:0] A;
   wire [31:0] A_OUT;
   wire [31:0] B;
   wire [31:0] B_OUT;
   wire [31:0] DINT;
   wire [31:0] imm;
   wire [31:0] MAR;
   wire [31:0] PC;
   wire [4:0] RD;
   wire [4:0] RS1;
   wire [4:0] RS2;
   wire [31:0] S1;
   wire [31:0] S2;
   wire [31:0] XLXN_34;
   wire [31:0] XLXN_38;
   wire [31:0] XLXN_39;
   wire [31:0] XLXN_40;
   wire [31:0] XLXN_58;
   wire [31:0] XLXN_60;
   wire [31:0] XLXN_71;
   wire [31:0] DO_DUMMY;
   wire [2:0] ALUF_DUMMY;
   
   assign XLXN_58 = 32'h00000000;
   assign XLXN_60 = 32'h00000001;
   assign ALUF[2:0] = ALUF_DUMMY[2:0];
   assign DO[31:0] = DO_DUMMY[31:0];
   IR_ENV_DLX  XLXI_1 (.CLK(CLK), 
                      .Din(DI[31:0]), 
                      .IRce(IRce), 
                      .Itype(Itype), 
                      .Jlink(Jlink), 
                      .aluf(ALUF_DUMMY[2:0]), 
                      .imm(imm[31:0]), 
                      .ir(IR[31:0]), 
                      .opcode(opcode[5:0]), 
                      .rd(RD[4:0]), 
                      .rs1(RS1[4:0]), 
                      .rs2(RS2[4:0]));
   ALU_env  XLXI_2 (.A(S1[31:0]), 
                   .add(add), 
                   .ALUf(ALUF_DUMMY[2:0]), 
                   .B(S2[31:0]), 
                   .test(Test), 
                   .ALU_OUT(XLXN_38[31:0]));
   shift_env  XLXI_3 (.SHIFTce(SHIFTce), 
                     .SHIFTright(SHIFTright), 
                     .S1(S1[31:0]), 
                     .SHIFT_OUT(XLXN_39[31:0]));
   GPR_env_sch_MUSER_Top_Level  XLXI_4 (.A_adr(RS1[4:0]), 
                                       .B_adr(RS2[4:0]), 
                                       .C(XLXN_34[31:0]), 
                                       .CLK(CLK), 
                                       .C_adr(RD[4:0]), 
                                       .D_adr(D_addr[4:0]), 
                                       .GPR_we(GPR_WE), 
                                       .A(A[31:0]), 
                                       .AEQZ_O(AEQZ), 
                                       .B(B[31:0]), 
                                       .D(D_MONITOR[31:0]));
   MUX32bit  XLXI_5 (.A(PC[31:0]), 
                    .B(MAR[31:0]), 
                    .sel(Asel), 
                    .O(XLXN_40[31:0]));
   MUX32bit  XLXI_6 (.A(XLXN_38[31:0]), 
                    .B(XLXN_39[31:0]), 
                    .sel(DINTsel), 
                    .O(DINT[31:0]));
   MUX32bit  XLXI_7 (.A(DINT[31:0]), 
                    .B(DI[31:0]), 
                    .sel(MDRsel), 
                    .O(XLXN_71[31:0]));
   MMU  XLXI_8 (.Din(XLXN_40[31:0]), 
               .Dout(MAO[31:0]));
   MUX4_32bit  XLXI_9 (.A(B_OUT[31:0]), 
                      .B(imm[31:0]), 
                      .C(XLXN_58[31:0]), 
                      .D(XLXN_60[31:0]), 
                      .sel(S2sel[1:0]), 
                      .O(S2[31:0]));
   MUX4_32bit  XLXI_10 (.A(PC[31:0]), 
                       .B(A_OUT[31:0]), 
                       .C(B_OUT[31:0]), 
                       .D(DO_DUMMY[31:0]), 
                       .sel(S1sel[1:0]), 
                       .O(S1[31:0]));
   REG32CE  XLXI_11 (.CE(Cce), 
                    .CLK(CLK), 
                    .DI(DINT[31:0]), 
                    .DO(XLXN_34[31:0]));
   REG32CE  XLXI_12 (.CE(MDRce), 
                    .CLK(CLK), 
                    .DI(XLXN_71[31:0]), 
                    .DO(DO_DUMMY[31:0]));
   REG32CE  XLXI_13 (.CE(Bce), 
                    .CLK(CLK), 
                    .DI(B[31:0]), 
                    .DO(B_OUT[31:0]));
   REG32CE  XLXI_14 (.CE(Ace), 
                    .CLK(CLK), 
                    .DI(A[31:0]), 
                    .DO(A_OUT[31:0]));
   REG32CE  XLXI_16 (.CE(MARce), 
                    .CLK(CLK), 
                    .DI(DINT[31:0]), 
                    .DO(MAR[31:0]));
   REG32RST  XLXI_17 (.CE(PCce), 
                     .CLK(CLK), 
                     .DI(DINT[31:0]), 
                     .RST(RESET), 
                     .DO(PC[31:0]));
endmodule
