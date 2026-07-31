`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:55:33 06/23/2026 
// Design Name: 
// Module Name:    shift_env 
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
module shift_env(
    input [31:0] S1,
    input SHIFTce,
    input SHIFTright,
    output reg [31:0] SHIFT_OUT
    );
	 
	 reg [31:0] SHIFT_CURRENT;
	 
	 always @(*) 
	 begin
		if (SHIFTce) begin
			if (SHIFTright) begin
				SHIFT_CURRENT = S1 >> 1;
			end else begin
				SHIFT_CURRENT = S1 << 1;
			end
		end else begin
			SHIFT_CURRENT = S1;
		end
	end
	
	always @(*) 
		begin
		SHIFT_OUT = SHIFT_CURRENT;
		end
endmodule
