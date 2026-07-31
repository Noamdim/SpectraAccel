`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:24:09 06/09/2026 
// Design Name: 
// Module Name:    MAC_SM 
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
module MAC_SM(
    input CLK,
    input RESET,
    input ack_n,
    input mw,
    input mr,
    output [1:0] mac_state,
    output stop_n
    );
	 
reg [1:0] current_state, prev_state;

parameter st_wait_4_req = 2'h0;
parameter st_wait_4_ack = 2'h1;
parameter st_next = 2'h2;

always @ (posedge CLK)
begin
	prev_state = current_state;
	
	if (RESET == 1)
		begin
			current_state = st_wait_4_req;
		end
	else
		case(current_state)
		st_wait_4_req:
			begin
			current_state = (mr ==1 || mw ==1) ? st_wait_4_ack : st_wait_4_req;
			end
		st_wait_4_ack:
			begin
			current_state = ack_n ? st_wait_4_ack : st_next;
			end
		st_next:
			begin
			current_state = st_wait_4_req;
			end
				
		default:
			begin
			current_state = st_wait_4_req;
			end
			endcase
	end

assign mac_state = current_state;
assign stop_n = ~((current_state == st_wait_4_ack) && (prev_state == st_wait_4_ack) && (ack_n == 1));


endmodule
