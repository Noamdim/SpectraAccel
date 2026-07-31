`timescale 100 ps / 10 ps

module FD8RE_HXILINX_Top_Level(Q, C, CE, D, R);

   
   output [7:0]       Q;

   input 	      C;	
   input 	      CE;	
   input  [7:0]       D;
   input 	      R;	
   
   reg    [7:0]       Q;
   
   always @(posedge C)
     begin
	if (R)
	  Q <= 8'b0000_0000;
	else if (CE)
          Q <= D;
     end
   
   
endmodule
