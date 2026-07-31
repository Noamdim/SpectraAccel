`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:31:04 06/23/2026 
// Design Name: 
// Module Name:    IR_ENV_DLX 
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
module IR_ENV_DLX(
    input CLK,
    input IRce,
    input Itype,
    input Jlink,
    input [31:0] Din,
    output reg [5:0] opcode,
    output reg [4:0] rs1,
    output reg [4:0] rs2,
    output reg [4:0] rd,
    output reg [31:0] imm,
    output reg [2:0] aluf,
    output reg [31:0] ir
    );

always @(posedge CLK)
begin
	if (IRce == 1) 
	begin
		ir <= Din;
		rs2 <= Din[20:16];
		rs1 <= Din[25:21];
		opcode <= Din[31:26];
	
	if(opcode == 6'b010111)
		rd <= 5'b11111;
	else
		rd <= (Din[31:26] == 6'b000000) ? Din[15:11] : Din[20:16];
		
	aluf <= (Din[31:26] == 6'b000000) ? Din[2:0] : Din[28:26];
	
	if(Din[31:26] == 6'b000000)
		imm <= 32'b0;
	else begin
		imm[15:0] <= Din[15:0];
		imm[31:16] <= Din[15] ? 16'hFFFF : 16'h0000;
	end
	end	
end

endmodule
