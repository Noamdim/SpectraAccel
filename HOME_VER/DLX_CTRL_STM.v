`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:51:34 06/23/2026 
// Design Name: 
// Module Name:    DLX_CTRL_STM 
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
module DLX_CTRL_STM(
    input CLK,
    input RESET,
    input STEP_EN,
    input BUSY,
    input aeqz,
    input [31:0] ir,
    output [4:0] ctrl_dlx_state,
    output MW,
    output MR,
    output IRce,
    output Ace,
    output Bce,
    output [1:0] S2sel,
    output [1:0] S1sel,
    output PCce,
    output add,
    output Cce,
    output Test,
    output Itype,
    output DINTsel,
    output SHIFTce,
    output MARce,
    output MDRce,
    output MDRsel,
    output GPR_WE,
    output Jlink,
    output IN_INIT,
    output SHIFTright,
    output Asel,
    output classify_pulse
    );

reg [4:0] current_state;

parameter st_init = 0;
parameter st_fetch = 1;
parameter st_decode = 2;
parameter st_branch = 3;
parameter st_btaken = 4;
parameter st_savepc = 5;
parameter st_jalr = 6;
parameter st_jr = 7;
parameter st_addresscmp = 8;
parameter st_copygpr2mdr = 9;
parameter st_store = 10;
parameter st_load = 11;
parameter st_copymdr2c = 12;
parameter st_testi = 13;
parameter st_alui = 14;
parameter st_wbi = 15;
parameter st_shift = 16;
parameter st_alu = 17;
parameter st_wbr = 18;
parameter st_halt = 19;
parameter st_cls_dst = 20;
parameter st_cls_src = 21;
parameter st_cls_trigger = 22;

always @ (posedge CLK)

begin
	if (RESET == 1)
		begin
		current_state = st_init;
		end
	else
		case(current_state)
		
	st_init:
		begin
		current_state = (STEP_EN == 1) ? st_fetch : st_init;
		end
	
	st_fetch:
		begin
		current_state = (BUSY == 1) ? st_fetch : st_decode;
		end
		
	st_decode:
		if (ir[31:28] == 4'b0001)
			begin
			current_state = st_branch;
			end
		else if (ir[31:26] == 6'b010111)
			begin
			current_state = st_savepc;
			end
		else if (ir[31:26] == 6'b010110)
			begin
			current_state = st_jr;
			end
		else if (ir[31:30] == 2'b10)
			begin
			current_state = st_addresscmp;
			end 
		else if (ir[31:29] == 3'b011)
			begin
			current_state = st_testi;
			end
		else if (ir[31:29] == 3'b001)
			begin
			current_state = st_alui;
			end  
		else if ((ir[31:28] == 4'b0000) && (ir[5] == 0))
			begin
			current_state = st_shift;
			end
		else if ((ir[31:28] == 4'b0000) && (ir[5] == 1))
			begin
			current_state = st_alu;
			end	
		else if (ir[31:26] == 6'b010000)
			begin
			current_state = st_cls_dst;
			end
	else if (ir[31:29] == 3'b111)
			begin
			current_state = st_halt;
			end
		else
			begin
			current_state = (STEP_EN == 1) ? st_fetch : st_init;
			end
			
	st_branch:
		if ((aeqz ^ ir[26]) == 1)
			begin
			current_state = st_btaken;
			end
		else
			begin
			current_state = (STEP_EN == 1) ? st_fetch : st_init;
			end
	
	st_btaken:
			begin
			current_state = (STEP_EN == 1) ? st_fetch : st_init;
			end
			
	st_savepc:
		begin
		current_state = st_jalr;
		end
	
	st_jalr:
			begin
			current_state = (STEP_EN == 1) ? st_fetch : st_init;
			end

	st_jr:
			begin
			current_state = (STEP_EN == 1) ? st_fetch : st_init;
			end

	st_addresscmp:
			begin
			current_state = (ir[29] == 1) ? st_copygpr2mdr : st_load;
			end
			
	st_copygpr2mdr:
		begin
		current_state = st_store;
		end		
	
	st_store:
		if (BUSY == 1)
			begin
			current_state = st_store;
			end
		else
			begin
			current_state = (STEP_EN == 1) ? st_fetch : st_init;
			end	
			
	st_load:
		begin
		current_state = (BUSY == 1) ? st_load : st_copymdr2c;
		end		
	
	st_copymdr2c:
		begin
		current_state = st_wbi;
		end
		
	st_testi:
		begin
		current_state = st_wbi;
		end		
		
	st_alui:
		begin
		current_state = st_wbi;
		end	

	st_wbi:
		begin
		current_state = (STEP_EN == 1) ? st_fetch : st_init;
		end

	st_shift:
		begin
		current_state = st_wbr;
		end
		
	st_alu:
		begin
		current_state = st_wbr;
		end

	st_wbr:
		begin
		current_state = (STEP_EN == 1) ? st_fetch : st_init;
		end

	st_cls_dst:
		begin
		current_state = st_cls_src;
		end

	st_cls_src:
		begin
		current_state = st_cls_trigger;
		end

	st_cls_trigger:
		begin
		current_state = (STEP_EN == 1) ? st_fetch : st_init;
		end

	st_halt:
		begin
		current_state = (RESET == 1) ? st_init : st_halt;
		end

	default:
		begin
		current_state = st_init;
		end
	endcase
end

assign ctrl_dlx_state = current_state;
assign MW = (current_state == st_store) ? 1 : 0;
assign MR = ((current_state == st_load) || (current_state == st_fetch)) ? 1 : 0;
assign IRce = (current_state == st_fetch) ? 1 : 0;
assign Ace = (current_state == st_decode) ? 1 : 0;
assign Bce = (current_state == st_decode) ? 1 : 0;

assign S2sel[0] = ((current_state == st_decode) || (current_state == st_testi) || (current_state == st_alui) ||
                  (current_state == st_addresscmp) || (current_state == st_btaken) || (current_state == st_cls_dst)) ? 1 : 0;

assign S2sel[1] = ((current_state == st_decode) || (current_state == st_copymdr2c) || (current_state == st_copygpr2mdr) ||
                  (current_state == st_jr)||(current_state == st_savepc)||(current_state == st_jalr)||
                  (current_state == st_cls_src)) ? 1 : 0;

assign S1sel[0] = ((current_state == st_alu) || (current_state == st_testi) || (current_state == st_alui) ||
                  (current_state == st_shift) || (current_state == st_copymdr2c) ||
                  (current_state == st_addresscmp) || (current_state == st_jalr)||(current_state == st_jr)||
                  (current_state == st_cls_dst)||(current_state == st_cls_src))? 1 : 0;

assign S1sel[1] =    ((current_state == st_copymdr2c) || (current_state == st_copygpr2mdr)) ? 1 : 0;

assign PCce =((current_state == st_decode) || (current_state == st_btaken) || (current_state == st_jr) ||
             (current_state == st_jalr)) ? 1 : 0;

assign add = ((current_state == st_decode) || (current_state == st_alui) || (current_state == st_addresscmp) ||
             (current_state == st_btaken) || (current_state == st_jr) ||
             (current_state == st_savepc) || (current_state == st_jalr)||
             (current_state == st_cls_dst))? 1 : 0;

assign Cce = ((current_state == st_alu) || (current_state == st_alui) || (current_state == st_shift) ||
             (current_state == st_testi) || (current_state == st_copymdr2c) ||
             (current_state == st_savepc))? 1 : 0;

assign Test = (current_state == st_testi) ? 1 : 0;

assign Itype = ((current_state == st_testi) || (current_state == st_alui) || (current_state == st_wbi)) ? 1 : 0;

assign DINTsel = ((current_state == st_shift) || (current_state == st_copymdr2c) || (current_state == st_copygpr2mdr) ||
                 (current_state == st_cls_src)) ? 1 : 0;

assign SHIFTce = (current_state == st_shift) ? 1 : 0;

assign MARce = ((current_state == st_addresscmp) || (current_state == st_cls_dst)) ? 1 : 0;

assign MDRce = ((current_state == st_load) || (current_state == st_copygpr2mdr) || (current_state == st_cls_src)) ? 1 : 0;

assign MDRsel = (current_state == st_load) ? 1 : 0;

assign GPR_WE = ((current_state == st_jalr) || (current_state == st_wbr) || (current_state == st_wbi)) ? 1 : 0;

assign Jlink = (current_state == st_jalr) ? 1 : 0;

assign IN_INIT = ((current_state == st_init) || (current_state == st_halt)) ? 1 : 0;

assign SHIFTright = ((current_state == st_shift) && (ir[1] == 1)) ? 1 : 0;

assign Asel = ((current_state == st_load) || (current_state == st_store) || (current_state == st_cls_trigger)) ? 1 : 0;

assign classify_pulse = (current_state == st_cls_trigger) ? 1 : 0;


endmodule
