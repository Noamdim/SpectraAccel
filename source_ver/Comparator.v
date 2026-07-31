`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:59:12 12/30/2024 
// Design Name: 
// Module Name:    Comparator 
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
module Comparator(
    input neg,
    input [31:0] S,
    input [2:0] F,
    output COMP_OUT
    );
	 
	 wire zero;
	 assign zero= (S==0);//zero(32) of S
	 
	 wire last_or_0 , last_or_1;
	 assign last_or_0 = ( F[1]&zero ) | ( F[2]&neg ); // calculating the right leg of the last or gate
	 assign last_or_1 = ~zero & (~neg & F[0]);// calculating the left leg of the last or gate
	 assign COMP_OUT = last_or_0 | last_or_1; // the final or gate
	 
	 


endmodule
