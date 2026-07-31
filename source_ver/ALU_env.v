`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:19:08 12/30/2024 
// Design Name: 
// Module Name:    ALU_env 
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
module ALU_env(
    input [2:0] ALUf,
    input [31:0] A,
    input [31:0] B,
    input add,
    input test,
    output [31:0] ALU_OUT
    );
	 //wire definitions
	 wire [31:0] A_B_OR , A_B_XOR , A_B_AND ; // wires to hold the bitwise calculations , will feed the muxes
	 wire [2:0] F;
	 wire [31:0] or_xor_mux_out , add_sub_mux2_mux_out;
	 wire [31:0] and_mux1_mux_out , add_sub_result ,comp_out_extended;
	 wire sub;
	 wire neg;
	 wire comp_out;
	 assign comp_out_extended = {31'b0,comp_out} ;// padding with 31 zeros the comp_out signal

	 
	 assign F= add ? 3'b011 : ALUf; //the mux(3bit) - if (add) then F=011 else F=ALUf
	 assign A_B_OR = A|B; //bitwise OR of A and B
	 assign A_B_XOR = A^B;//bitwise XOR of A and B
	 assign A_B_AND = A&B;//bitwise AND of A and B
	 assign sub = ~F[0] | test ;
	 
	 MUX32bit or_xor_mux ( // MUX32 with F[0] selector - MUX1
        .A(A_B_XOR),          // if sel 0 get the bitwise xor 
        .B(A_B_OR),           // if sel 1 get the bitwise or
        .sel(F[0]),      		// F[0] is the selector
        .O(or_xor_mux_out)    
    );
	 
	 	 MUX32bit and_mux1_mux ( // MUX32 with F[1] selector - MUX2
        .A(or_xor_mux_out),    // if sel 0 get MUX1 out 
        .B(A_B_AND),           // if sel 1 get the bitwise and
        .sel(F[1]),      		// F[1] is the selector
        .O(and_mux1_mux_out)    
    );
	 
	 ADD_SUB add_sub_unit( // the add sub unit was created in schematic, but instanced here in verilog
	 .A(A),
	 .B(B),
	 .sub(sub),
	 .neg(neg),
	 .ovf(), // unconnected
	 .result(add_sub_result)
	 );
	 
	 Comparator comparator( //The Comparator
	 .neg(neg),
	 .S(add_sub_result),
	 .F(F),
	 .COMP_OUT(comp_out)
	 );
	 
	 
	 MUX32bit add_sub_mux2_mux ( // MUX32 with F[2] selector - MUX3
     .A(add_sub_result),    // if sel 0 get add_sub_result  
     .B(and_mux1_mux_out),  // if sel 1 get the output of MUX2
     .sel(F[2]),      		// F[2] is the selector
     .O(add_sub_mux2_mux_out)    
    );
	 
	 
	 MUX32bit out_mux ( // MUX32 with test selector - MUX4
     .A(add_sub_mux2_mux_out),    // if sel 0 get result from mux 3  
     .B(comp_out_extended),  // if sel 1 get the zero padded comp_out
     .sel(test),      		// test is the selector
     .O(ALU_OUT)    
    );
	 


endmodule
