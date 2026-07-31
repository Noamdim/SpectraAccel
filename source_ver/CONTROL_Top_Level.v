module CONTROL_Top_Level(ACK_N, 
                                   AEQZ, 
                                   CLK, 
                                   IR, 
                                   RESET, 
                                   STEP_EN, 
                                   Ace, 
                                   add, 
                                   Asel, 
                                   AS_N, 
                                   Bce, 
                                   BUSY, 
                                   Cce, 
                                   ctrl_dlx_state, 
                                   DINTsel, 
                                   GPR_WE, 
                                   IN_INIT, 
                                   IRce, 
                                   Itype, 
                                   Jlink, 
                                   MAC_STATE, 
                                   MARce, 
                                   MDRce, 
                                   MDRsel, 
                                   MR, 
                                   MW, 
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
    input AEQZ;
    input CLK;
    input [31:0] IR;
    input RESET;
    input STEP_EN;
   output Ace;
   output add;
   output Asel;
   output AS_N;
   output Bce;
   output BUSY;
   output Cce;
   output [4:0] ctrl_dlx_state;
   output DINTsel;
   output GPR_WE;
   output IN_INIT;
   output IRce;
   output Itype;
   output Jlink;
   output [1:0] MAC_STATE;
   output MARce;
   output MDRce;
   output MDRsel;
   output MR;
   output MW;
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
   
   wire BUSY_REG;
   wire XLXN_43;
   wire REQ_DUMMY;
   wire BUSY_DUMMY;
   wire MR_DUMMY;
   wire MW_DUMMY;
   
   assign BUSY = BUSY_DUMMY;
   assign MR = MR_DUMMY;
   assign MW = MW_DUMMY;
   assign REQ = REQ_DUMMY;
   MAC_SM  XLXI_2 (.ack_n(ACK_N), 
                  .CLK(CLK), 
                  .mr(MR_DUMMY), 
                  .mw(MW_DUMMY), 
                  .RESET(RESET), 
                  .mac_state(MAC_STATE[1:0]), 
                  .stop_n(STOP_N));
   FD #( .INIT(1'b0) ) XLXI_3 (.C(CLK), 
              .D(BUSY_DUMMY), 
              .Q(XLXN_43));
   OR2  XLXI_4 (.I0(XLXN_43), 
               .I1(BUSY_DUMMY), 
               .O(BUSY_REG));
   OR2  XLXI_5 (.I0(MW_DUMMY), 
               .I1(MR_DUMMY), 
               .O(REQ_DUMMY));
   AND2  XLXI_6 (.I0(REQ_DUMMY), 
                .I1(ACK_N), 
                .O(BUSY_DUMMY));
   NAND2  XLXI_7 (.I0(BUSY_REG), 
                 .I1(MW_DUMMY), 
                 .O(WR_OUT_N));
   INV  XLXI_8 (.I(BUSY_REG), 
               .O(AS_N));
   DLX_CTRL_STM  XLXI_9 (.aeqz(AEQZ), 
                        .BUSY(BUSY_DUMMY), 
                        .CLK(CLK), 
                        .ir(IR[31:0]), 
                        .RESET(RESET), 
                        .STEP_EN(STEP_EN), 
                        .Ace(Ace), 
                        .add(add), 
                        .Asel(Asel), 
                        .Bce(Bce), 
                        .Cce(Cce), 
                        .ctrl_dlx_state(ctrl_dlx_state[4:0]), 
                        .DINTsel(DINTsel), 
                        .GPR_WE(GPR_WE), 
                        .IN_INIT(IN_INIT), 
                        .IRce(IRce), 
                        .Itype(Itype), 
                        .Jlink(Jlink), 
                        .MARce(MARce), 
                        .MDRce(MDRce), 
                        .MDRsel(MDRsel), 
                        .MR(MR_DUMMY), 
                        .MW(MW_DUMMY), 
                        .PCce(PCce), 
                        .SHIFTce(SHIFTce), 
                        .SHIFTright(SHIFTright),
                        .S1sel(S1sel[1:0]),
                        .S2sel(S2sel[1:0]),
                        .Test(Test),
                        .classify_pulse(classify_pulse));
endmodule
