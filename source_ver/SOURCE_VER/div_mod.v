`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2026 01:44:49 PM
// Design Name: 
// Module Name: div_mod
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module div_mod #(
    parameter IN_WIDTH = 10,
    parameter SHIFT    = 8,
    parameter PIPE_RES = IN_WIDTH + SHIFT // Total pipeline stages
)(
    input  wire                   clk,
    input  wire                   reset_n,
    input  wire signed [IN_WIDTH-1:0] s_numerator,
    input  wire signed [IN_WIDTH-1:0] s_denominator,
    input  wire                   s_valid,
    
    output reg  signed [PIPE_RES-1:0] m_quotient,
    output reg                    m_valid
);

    // Pipeline registers for data and control signals
    reg [PIPE_RES-1:0] abs_num [0:PIPE_RES];
    reg [IN_WIDTH-1:0] abs_den [0:PIPE_RES];
    reg [PIPE_RES:0]   sign_pipe;
    reg [PIPE_RES:0]   valid_pipe;
    reg [PIPE_RES-1:0] quot_pipe [0:PIPE_RES];
    reg [PIPE_RES:0]   rem_pipe  [0:PIPE_RES];

    integer i;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            valid_pipe <= 0;
            m_valid    <= 0;
            m_quotient <= 0;
        end else begin
            // --- STAGE 0: Input Pre-processing & Zero-Division Protection ---
            valid_pipe[0] <= s_valid;
            
            // Use MUX-based protection for zero denominator
            if (s_denominator == {IN_WIDTH{1'b0}}) begin
                sign_pipe[0] <= 1'b0;
                abs_num[0]   <= {PIPE_RES{1'b0}};
                abs_den[0]   <= {{ (IN_WIDTH-1){1'b0} }, 1'b1}; // Force Denominator to 1
            end else begin
                sign_pipe[0] <= s_numerator[IN_WIDTH-1] ^ s_denominator[IN_WIDTH-1];
                abs_num[0]   <= (s_numerator < 0) ? -s_numerator << SHIFT : s_numerator << SHIFT;
                abs_den[0]   <= (s_denominator < 0) ? -s_denominator : s_denominator;
            end
            
            quot_pipe[0] <= 0;
            rem_pipe[0]  <= 0;

            // --- STAGES 1 to PIPE_RES: Pipelined Restoring Division Logic ---
            for (i = 0; i < PIPE_RES; i = i + 1) begin
                valid_pipe[i+1] <= valid_pipe[i];
                sign_pipe[i+1]  <= sign_pipe[i];
                abs_den[i+1]    <= abs_den[i];

                // Check if current remainder is larger than denominator
                if ({rem_pipe[i][PIPE_RES-2:0], abs_num[i][PIPE_RES-1-i]} >= abs_den[i]) begin
                    rem_pipe[i+1]   <= {rem_pipe[i][PIPE_RES-2:0], abs_num[i][PIPE_RES-1-i]} - abs_den[i];
                    quot_pipe[i+1]  <= {quot_pipe[i][PIPE_RES-2:0], 1'b1};
                end else begin
                    rem_pipe[i+1]   <= {rem_pipe[i][PIPE_RES-2:0], abs_num[i][PIPE_RES-1-i]};
                    quot_pipe[i+1]  <= {quot_pipe[i][PIPE_RES-2:0], 1'b0};
                end
                abs_num[i+1] <= abs_num[i]; 
            end

            // --- FINAL STAGE: Sign Correction & Output Assignment ---
            m_valid <= valid_pipe[PIPE_RES];
            if (sign_pipe[PIPE_RES])
                m_quotient <= -quot_pipe[PIPE_RES];
            else
                m_quotient <= quot_pipe[PIPE_RES];
        end
    end
endmodule
