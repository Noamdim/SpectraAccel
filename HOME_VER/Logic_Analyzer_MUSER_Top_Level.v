`timescale 1ns / 1ps

module Logic_Analyzer_MUSER_Top_Level(AI, 
                                      CLK, 
                                      IN_INIT, 
                                      LA_Data_in, 
                                      STEP_EN, 
                                      STOP_N, 
                                      D_out, 
                                      STATUS);

    input [4:0] AI;
    input CLK;
    input IN_INIT;
    input [31:0] LA_Data_in;
    input STEP_EN;
    input STOP_N;
   output [31:0] D_out;
   output [7:0] STATUS;
   
   wire [7:0] counter_addr;
   wire IN_INIT_PULSE;
   wire [4:0] LA_Addr;
   wire LA_RUN;
   wire LA_WE;
   wire STS_CE;
   wire XLXN_12;
   wire XLXN_19;
   wire XLXN_20;
   wire XLXN_21;
   wire XLXN_30;
   
   MUX5bit  XLXI_1 (.A(AI[4:0]), 
                   .B(counter_addr[4:0]), 
                   .sel(LA_RUN), 
                   .O(LA_Addr[4:0]));
   CNT5  XLXI_2 (.CE(LA_WE), 
                .CLK(CLK), 
                .RST(STS_CE), 
                .CNT(counter_addr[4:0]));
   RAM32x32  XLXI_3 (.ADDR(LA_Addr[4:0]), 
                    .CLK(CLK), 
                    .DI(LA_Data_in[31:0]), 
                    .WE(LA_WE), 
                    .DO(D_out[31:0]));
   (* HU_SET = "XLXI_4_0" *) 
   FD8RE_HXILINX_Top_Level  XLXI_4 (.C(CLK), 
                                   .CE(STS_CE), 
                                   .D(counter_addr[7:0]), 
                                   .R(XLXN_12), 
                                   .Q(STATUS[7:0]));
   FD #( .INIT(1'b0) ) XLXI_5 (.C(CLK), 
              .D(IN_INIT), 
              .Q(XLXN_21));
   FD #( .INIT(1'b0) ) XLXI_6 (.C(CLK), 
              .D(IN_INIT_PULSE), 
              .Q(STS_CE));
   OR2  XLXI_7 (.I0(STEP_EN), 
               .I1(XLXN_19), 
               .O(XLXN_20));
   OR2  XLXI_8 (.I0(IN_INIT_PULSE), 
               .I1(XLXN_20), 
               .O(LA_RUN));
   INV  XLXI_9 (.I(IN_INIT), 
               .O(XLXN_19));
   INV  XLXI_10 (.I(XLXN_21), 
                .O(XLXN_30));
   AND2  XLXI_11 (.I0(STOP_N), 
                 .I1(LA_RUN), 
                 .O(LA_WE));
   AND2  XLXI_12 (.I0(IN_INIT), 
                 .I1(XLXN_30), 
                 .O(IN_INIT_PULSE));
   GND  XLXI_13 (.G(XLXN_12));
   GND  XLXI_14 (.G(counter_addr[7]));
   GND  XLXI_29 (.G(counter_addr[6]));
   GND  XLXI_30 (.G(counter_addr[5]));
endmodule
