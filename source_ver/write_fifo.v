// ============================================================================
// Module Name: write_fifo
// Description: Self-Contained 32-bit Write FIFO for buffering output RGB pixels.
// Compatible with Xilinx ISE / XST Verilog-2001 parser.
// ============================================================================

`timescale 1ns / 1ps

module write_fifo #(
    parameter DEPTH               = 16,
    parameter ALMOST_FULL_THRESH  = 10,
    parameter ALMOST_EMPTY_THRESH = 4
)(
    input  wire        clk,
    input  wire        rst_n,
    
    // Write Interface (from SpectraAccel)
    input  wire        wr_en,
    input  wire [31:0] din,
    output wire        full,
    output wire        almost_full,
    
    // Read Interface (to Memory Stream Controller)
    input  wire        rd_en,
    output wire [31:0] dout,
    output wire        empty,
    output wire        almost_empty,
    
    // Status
    output reg  [4:0] count
);

    localparam ADDR_WIDTH = 4; // 2^4 = 16 depth

    // 32-bit Memory Array
    reg [31:0] mem [0:DEPTH-1];
    
    // Read and Write Pointers
    reg [ADDR_WIDTH-1:0] wr_ptr;
    reg [ADDR_WIDTH-1:0] rd_ptr;

    // First Word Fall Through Combinational Output
    assign dout = mem[rd_ptr];

    // Status Flags
    assign full         = (count == DEPTH);
    assign empty        = (count == 0);
    assign almost_full  = (count >= ALMOST_FULL_THRESH);
    assign almost_empty = (count <= ALMOST_EMPTY_THRESH);

    // Counter and Pointer Management
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            count  <= 0;
        end else begin
            case ({wr_en && !full, rd_en && !empty})
                2'b10: begin // Write only
                    mem[wr_ptr] <= din;
                    wr_ptr      <= wr_ptr + 1'b1;
                    count       <= count + 1'b1;
                end
                2'b01: begin // Read only
                    rd_ptr <= rd_ptr + 1'b1;
                    count  <= count - 1'b1;
                end
                2'b11: begin // Simultaneous Read & Write
                    mem[wr_ptr] <= din;
                    wr_ptr      <= wr_ptr + 1'b1;
                    rd_ptr      <= rd_ptr + 1'b1;
                    // count remains unchanged
                end
                default: ;
            endcase
        end
    end

endmodule
