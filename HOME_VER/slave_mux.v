`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:44:33 05/12/2026 
// Design Name: 
// Module Name:    slave_mux 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module slave_mux(
    input WR_IN_N,
    input CARD_SEL,
    input clk,
	 input reset,
    input [9:0] AI,
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    input [31:0] d,
    output SACK_N,
    output [31:0] SDO,
    output [4:0] reg_address
    );

		
assign SDO = (AI[6]) ? (AI[5] ? d:c):(AI[5] ? b:a);
	
wire D;
assign D = WR_IN_N & CARD_SEL & AI[7] & AI[8] & ~AI[9];

reg Dn, Dnn, Dnnn;
// first ff	
always @(posedge clk)
    if (reset ==1)
	     Dn <=   1'b0;	  
	 else 
	     Dn <=  D;
			
// 2nd ff	
always @(posedge clk)
    if (reset ==1)
	     Dnn <=   1'b0;	  
	 else 
	     Dnn <=  Dn;
			
// 3rd ff
always @(posedge clk)
    if (reset ==1)
	     Dnnn <=   1'b0;	  
	 else 
	     Dnnn <=  Dnn;
				
	
assign  SACK_N = ~(~Dnnn & Dnn);
BUF5 buf5(AI[4:0], reg_address); 

	
endmodule
