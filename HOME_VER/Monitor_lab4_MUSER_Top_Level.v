`timescale 1ns / 1ps

module Monitor_lab4_MUSER_Top_Level(AI, 
                                    B, 
                                    C, 
                                    CARD_SEL, 
                                    CLK, 
                                    IN_INIT, 
                                    LA_Data_in, 
                                    RESET, 
                                    STEP_EN, 
                                    STOP_N, 
                                    WR_IN_N, 
                                    reg_address, 
                                    SACK_N, 
                                    SDO);

    input [9:0] AI;
    input [31:0] B;
    input [31:0] C;
    input CARD_SEL;
    input CLK;
    input IN_INIT;
    input [31:0] LA_Data_in;
    input RESET;
    input STEP_EN;
    input STOP_N;
    input WR_IN_N;
   output [4:0] reg_address;
   output SACK_N;
   output [31:0] SDO;
   
   wire [31:0] D_out;
   wire [7:0] ID_NAME;
   wire [7:0] STATUS;
   wire [31:0] Status_id;
   
   Logic_Analyzer_MUSER_Top_Level  XLXI_1 (.AI(AI[4:0]), 
                                          .CLK(CLK), 
                                          .IN_INIT(IN_INIT), 
                                          .LA_Data_in(LA_Data_in[31:0]), 
                                          .STEP_EN(STEP_EN), 
                                          .STOP_N(STOP_N), 
                                          .D_out(D_out[31:0]), 
                                          .STATUS(STATUS[7:0]));
   slave_mux  XLXI_3 (.a(D_out[31:0]), 
                     .AI(AI[9:0]), 
                     .b(B[31:0]), 
                     .c(C[31:0]), 
                     .CARD_SEL(CARD_SEL), 
                     .clk(CLK), 
                     .d(Status_id[31:0]), 
                     .reset(RESET), 
                     .WR_IN_N(WR_IN_N), 
                     .reg_address(reg_address[4:0]), 
                     .SACK_N(SACK_N), 
                     .SDO(SDO[31:0]));
   ID_name_1  XLXI_4 (.ID_name_1(ID_NAME[7:0]));
   concat_8_bit  XLXI_10 (.in_1(STATUS[7:0]), 
                         .in_2(ID_NAME[7:0]), 
                         .concat_out1(Status_id[31:0]));
endmodule
