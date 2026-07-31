// ============================================================================
// Module Name: stream_controller
// Description: Memory Streaming & DMA Controller for Spectral Accelerator.
// Orchestrates Memory Reads -> Read FIFO -> SpectraAccel -> Write FIFO -> Memory Writes.
// ============================================================================

`timescale 1ns / 1ps

module stream_controller (
    input  wire        clk,
    input  wire        rst_n,

    // --- DLX CPU Interface ---
    input  wire        start_proc,
    input  wire [31:0] src_addr,
    input  wire [31:0] dst_addr,
    input  wire [15:0] pixel_count,
    output reg         done_proc,

    // --- Memory Access Signals (To/From MAC_SM & RESA Bus) ---
    output reg         mr,          // Memory Read Request
    output reg         mw,          // Memory Write Request
    output reg  [31:0] mao,         // Master Address Out
    output reg  [31:0] mdo,         // Master Data Out
    input  wire        ack_n,       // Memory Active-Low Acknowledge
    input  wire [31:0] di,          // Data In from Memory

    // --- Read FIFO Interface (64-bit wide) ---
    output reg         rd_fifo_wr_en,
    output reg  [63:0] rd_fifo_din,
    input  wire        rd_fifo_full,
    input  wire        rd_fifo_empty,
    output wire        rd_fifo_rd_en,
    input  wire [63:0] rd_fifo_dout,

    // --- Write FIFO Interface (32-bit wide) ---
    output wire        wr_fifo_wr_en,
    output wire [31:0] wr_fifo_din,
    input  wire        wr_fifo_full,
    input  wire        wr_fifo_almost_full,
    input  wire        wr_fifo_empty,
    output reg         wr_fifo_rd_en,
    input  wire [31:0] wr_fifo_dout,

    // --- SpectraAccel Core Stream Interface ---
    output wire        accel_valid_in,
    output wire [63:0] accel_pixel_data,
    input  wire        accel_valid_out,
    input  wire [7:0]  accel_r,
    input  wire [7:0]  accel_g,
    input  wire [7:0]  accel_b
);

    // =========================================================
    // State Encoding
    // =========================================================
    localparam ST_IDLE       = 3'b000;
    localparam ST_READ_WORD0  = 3'b001;
    localparam ST_READ_WORD1  = 3'b010;
    localparam ST_PUSH_RD     = 3'b011;
    localparam ST_WRITE_WORD  = 3'b100;
    localparam ST_DONE       = 3'b101;

    reg [2:0] state, next_state;

    // Internal Tracking Counters & Registers
    reg [31:0] cur_read_addr;
    reg [31:0] cur_write_addr;
    reg [15:0] read_words_left;
    reg [15:0] written_pixels_count;

    reg [31:0] temp_word0; // Temporary storage for 1st 32-bit read word
    // =========================================================
    // Fresh-ACK falling-edge detector
    // Prevents accepting a stale ACK_N LOW left over from
    // the previous bus cycle (slave deasserts ACK_N only after
    // AS_N goes HIGH, which can lag by one or more clocks).
    // =========================================================
    reg ack_n_prev;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            ack_n_prev <= 1'b1;
        else
            ack_n_prev <= ack_n;
    end
	 
    wire ack_fall = ack_n_prev & ~ack_n; // TRUE only on HIGH?LOW transition
    // =========================================================
    // SpectraAccel Connections
    // =========================================================
    // Drive SpectraAccel when Read FIFO has data AND Write FIFO has room for
    // pipeline-depth results.  Using almost_full (thresh=12) leaves 4 slots,
    // which together with the drain interleaving prevents overflow from
    // the 5-stage pipeline tail.
    assign accel_valid_in   = !rd_fifo_empty && !wr_fifo_almost_full;
    assign accel_pixel_data = rd_fifo_dout;
    assign rd_fifo_rd_en    = accel_valid_in;

    // Capture SpectraAccel outputs directly into Write FIFO
    assign wr_fifo_wr_en = accel_valid_out;
    assign wr_fifo_din   = {8'h00, accel_r, accel_g, accel_b};

    // =========================================================
    // FSM State Register
    // =========================================================
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= ST_IDLE;
        else
            state <= next_state;
    end

    // =========================================================
    // FSM Next State Logic & Control
    // =========================================================
    always @(*) begin
        next_state = state;
        case (state)
            ST_IDLE: begin
                if (start_proc)
                    next_state = ST_READ_WORD0;
            end

            ST_READ_WORD0: begin
                // If Write FIFO needs flushing, prioritize writing
                if (wr_fifo_almost_full || (read_words_left == 0 && !wr_fifo_empty))
                    next_state = ST_WRITE_WORD;
                else if (ack_fall) // Memory Read Acked
                    next_state = ST_READ_WORD1;
            end

            ST_READ_WORD1: begin
                if (ack_fall)
                    next_state = ST_PUSH_RD;
            end

            ST_PUSH_RD: begin
                if (read_words_left == 0 && wr_fifo_empty && written_pixels_count >= pixel_count)
                    next_state = ST_DONE;
                else if (wr_fifo_almost_full || !wr_fifo_empty && read_words_left == 0)
                    next_state = ST_WRITE_WORD;
                else if (!rd_fifo_full && read_words_left > 0)
                    next_state = ST_READ_WORD0;
                else if (!wr_fifo_empty)
                    next_state = ST_WRITE_WORD;
                else if (read_words_left == 0 && written_pixels_count < pixel_count)
                    next_state = ST_WRITE_WORD; // Wait for pipeline to flush
            end

            ST_WRITE_WORD: begin
                if (ack_fall) begin
                    if (wr_fifo_empty && read_words_left == 0)
                        next_state = ST_DONE;
                    else if (wr_fifo_empty && read_words_left > 0)
                        next_state = ST_READ_WORD0;
                    else
                        next_state = ST_WRITE_WORD;
                end else if (wr_fifo_empty && read_words_left == 0 && written_pixels_count >= pixel_count) begin
                    // All pixels written to memory, safe to finish
                    next_state = ST_DONE;
                end else if (wr_fifo_empty && read_words_left > 0) begin
                    next_state = ST_READ_WORD0;
                end
            end

            ST_DONE: begin
                next_state = ST_IDLE;
            end

            default: next_state = ST_IDLE;
        endcase
    end

    // =========================================================
    // Datapath & Memory Bus Output Drivers
    // =========================================================
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mr                   <= 0;
            mw                   <= 0;
            mao                  <= 0;
            mdo                  <= 0;
            done_proc            <= 0;
            rd_fifo_wr_en        <= 0;
            rd_fifo_din          <= 0;
            wr_fifo_rd_en        <= 0;
            cur_read_addr        <= 0;
            cur_write_addr       <= 0;
            read_words_left      <= 0;
            written_pixels_count <= 0;
            temp_word0           <= 0;
        end else begin
            // Default pulse signals
            rd_fifo_wr_en <= 0;
            wr_fifo_rd_en <= 0;

            case (state)
                ST_IDLE: begin
                    mr <= 0;
                    mw <= 0;
                    if (start_proc) begin
                        cur_read_addr        <= src_addr;
                        cur_write_addr       <= dst_addr;
                        read_words_left      <= pixel_count * 2; // 2x 32-bit words per 64-bit pixel
                        written_pixels_count <= 0;
                        done_proc            <= 0;
                    end
                end

                ST_READ_WORD0: begin
                    if (next_state == ST_WRITE_WORD) begin
                        mr <= 0;
                    end else begin
                        mr  <= 1;
                        mw  <= 0;
                        mao <= {8'b0, cur_read_addr[23:0]};
                        if (ack_fall) begin
                            temp_word0    <= di;
                            cur_read_addr <= cur_read_addr + 1'b1;
                            mr            <= 0;
                        end
                    end
                end

                ST_READ_WORD1: begin
                    mr  <= 1;
                    mw  <= 0;
                    mao <= {8'b0, cur_read_addr[23:0]};
                    if (ack_fall) begin
                        rd_fifo_din   <= {temp_word0, di}; // Combine into 64-bit
                        rd_fifo_wr_en <= 1;
                        cur_read_addr <= cur_read_addr + 1'b1;
                        read_words_left <= (read_words_left >= 2) ? read_words_left - 2 : 0;
                        mr            <= 0;
                    end
                end

                ST_PUSH_RD: begin
                    mr <= 0;
                    mw <= 0;
                end

                ST_WRITE_WORD: begin
                    if (!wr_fifo_empty) begin
                        mw  <= 1;
                        mr  <= 0;
                        mao <= {8'b0, cur_write_addr[23:0]};
                        mdo <= wr_fifo_dout;
                        if (ack_fall) begin
                            wr_fifo_rd_en  <= 1;
                            cur_write_addr <= cur_write_addr + 1'b1;
                            written_pixels_count <= written_pixels_count + 1'b1;
                            mw             <= 0;
                        end
                    end else begin
                        mw <= 0;
                    end
                end

                ST_DONE: begin
                    mr        <= 0;
                    mw        <= 0;
                    done_proc <= 1;
                end
            endcase
        end
    end

endmodule
