`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:19:16 08/02/2020 
// Design Name: 
// Module Name:    REG_sram 
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
module REG_sram #(parameter ADDR_WIDTH = 8)
   (
    input wire i_clk,
    input wire [ADDR_WIDTH-1:0] i_addr, 
    input wire i_write,
    input wire [31:0] i_data,
    output wire [31:0] o_data 
    );

    reg [31:0] memory_array [0:2**ADDR_WIDTH-1]; 
    
    initial begin
        $readmemh("sram1.data", memory_array);
        $display("==================================================");
        $display("SRAM LOAD STATUS:");
        if (memory_array[0] === 32'hxxxxxxxx || memory_array[0] === 32'hz) begin
            $display("ERROR: sram1.data was NOT loaded correctly! Memory is X.");
        end else begin
            $display("SUCCESS: sram1.data loaded! First instruction is: %h", memory_array[0]);
        end
        $display("==================================================");
    end

    always @ (posedge i_clk)
    begin
        if(i_write) begin
            memory_array[i_addr] <= i_data;
        end
       
    end
	 
	 assign o_data = memory_array[i_addr];
endmodule


