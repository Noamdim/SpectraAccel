`timescale 1ns / 1ps

module GPR_env_sch_MUSER_Top_Level(A_adr, 
                                   B_adr, 
                                   C, 
                                   CLK, 
                                   C_adr, 
                                   D_adr, 
                                   GPR_we, 
                                   A, 
                                   AEQZ_O, 
                                   B, 
                                   D);

    input [4:0] A_adr;
    input [4:0] B_adr;
    input [31:0] C;
    input CLK;
    input [4:0] C_adr;
    input [4:0] D_adr;
    input GPR_we;
   output [31:0] A;
   output AEQZ_O;
   output [31:0] B;
   output [31:0] D;
   
   wire GPR_WE_RAM;
   wire [4:0] MUX_A_C;
   wire [4:0] MUX_B_C;
   wire [4:0] MUX_D_C;
   wire XLXN_47;
   wire XLXN_48;
   wire [31:0] A_DUMMY;
   
   assign A[31:0] = A_DUMMY[31:0];
   RAM32x32  XLXI_1 (.ADDR(MUX_A_C[4:0]), 
                    .CLK(CLK), 
                    .DI(C[31:0]), 
                    .WE(GPR_WE_RAM), 
                    .DO(A_DUMMY[31:0]));
   RAM32x32  XLXI_2 (.ADDR(MUX_B_C[4:0]), 
                    .CLK(CLK), 
                    .DI(C[31:0]), 
                    .WE(GPR_WE_RAM), 
                    .DO(B[31:0]));
   RAM32x32  XLXI_3 (.ADDR(MUX_D_C[4:0]), 
                    .CLK(CLK), 
                    .DI(C[31:0]), 
                    .WE(GPR_WE_RAM), 
                    .DO(D[31:0]));
   MUX5bit  XLXI_4 (.A(A_adr[4:0]), 
                   .B(C_adr[4:0]), 
                   .sel(GPR_we), 
                   .O(MUX_A_C[4:0]));
   MUX5bit  XLXI_5 (.A(B_adr[4:0]), 
                   .B(C_adr[4:0]), 
                   .sel(GPR_we), 
                   .O(MUX_B_C[4:0]));
   MUX5bit  XLXI_6 (.A(D_adr[4:0]), 
                   .B(C_adr[4:0]), 
                   .sel(GPR_we), 
                   .O(MUX_D_C[4:0]));
   AEQZ  XLXI_7 (.DI(A_DUMMY[31:0]), 
                .A_eqz(AEQZ_O));
   OR3  XLXI_8 (.I0(C_adr[0]), 
               .I1(C_adr[1]), 
               .I2(C_adr[2]), 
               .O(XLXN_47));
   OR3  XLXI_9 (.I0(XLXN_47), 
               .I1(C_adr[3]), 
               .I2(C_adr[4]), 
               .O(XLXN_48));
   AND2  XLXI_10 (.I0(XLXN_48), 
                 .I1(GPR_we), 
                 .O(GPR_WE_RAM));
endmodule
