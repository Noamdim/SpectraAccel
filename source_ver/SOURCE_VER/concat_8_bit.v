`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:33:27 05/19/2026 
// Design Name: 
// Module Name:    concat_8_bit 
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
module concat_8_bit(
    input [7:0] in_1,
    input [7:0] in_2,
    output [31:0] concat_out1
    );

	assign concat_out1 = {16'b0, in_2, in_1};

endmodule
