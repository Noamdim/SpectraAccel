`timescale 1ns / 1ps

module accel_slave (
    input  wire        clk,
    input  wire        reset,          // Active HIGH (matches existing system)

    // --- RESA Bus Slave Interface (directly from IO_LOGIC_U) ---
    input  wire [9:0]  AI,             // Address bus from IO_LOGIC_U
    input  wire [31:0] bus_data_in,    // Data from master (IO_LOGIC_U's DO output)
    input  wire        CARD_SEL,       // Slave card select (Ssel_o from IO_LOGIC_U)
    input  wire        WR_IN_N,        // Write strobe (active low = write cycle)
    output wire        SACK_N,         // Slave acknowledge (active low)
    output reg  [31:0] SDO,            // Slave data out (read data to master)

    // --- Classify Instruction Interface (sideband from DLX) ---
    input  wire        classify_pulse, // One-clock pulse from DLX classify instruction
    input  wire [31:0] cls_src,        // Source address (Rs) from DLX MDO
    input  wire [31:0] cls_dst,        // Destination address (Rs+imm) from DLX MAO

    // --- Configuration Outputs (to SpectraAccel) ---
    output reg  [95:0]  thresholds_packed,
    output reg  [47:0]  selector_ctrl_packed,
    output reg  [95:0]  classifier_rules_packed,
    output reg  [191:0] rgb_library_packed,

    // --- DMA Control Outputs (to stream_controller) ---
    output reg  [31:0] src_addr,
    output reg  [31:0] dst_addr,
    output reg  [15:0] pixel_count,
    output reg         start_proc,     // Pulse: triggers DMA start

    // --- Status Inputs (from stream_controller) ---
    input  wire        done_proc,      // DMA complete flag

    // --- Bus Ownership Signal ---
    output reg         accel_active    // HIGH = stream ctrl owns bus, DLX stalled
);

    // Monitor uses: AI[7] & AI[8] & ~AI[9]  ?  AI[9:7] = 3'b011
    // Accel uses:   AI[7] & ~AI[8] & ~AI[9]  ?  AI[9:7] = 3'b001
    wire accel_sel = WR_IN_N & CARD_SEL & AI[7] & ~AI[8] & ~AI[9];

    reg sel_d1, sel_d2, sel_d3;
    always @(posedge clk) begin
        if (reset) begin
            sel_d1 <= 0; sel_d2 <= 0; sel_d3 <= 0;
        end else begin
            sel_d1 <= accel_sel;
            sel_d2 <= sel_d1;
            sel_d3 <= sel_d2;
        end
    end

    assign SACK_N = ~(~sel_d3 & sel_d2);  // Same timing as slave_mux

    wire wr_strobe = ~WR_IN_N & CARD_SEL & AI[7] & ~AI[8] & ~AI[9];
    wire [4:0] reg_addr = AI[4:0];

    always @(posedge clk) begin
        if (reset) begin
            thresholds_packed       <= 0;
            selector_ctrl_packed    <= 0;
            classifier_rules_packed <= 0;
            rgb_library_packed      <= 0;
            src_addr                <= 0;
            dst_addr                <= 0;
            pixel_count             <= 0;
            start_proc              <= 0;
            accel_active            <= 0;
        end else begin
            start_proc <= 0;  // Self-clearing pulse

            if (done_proc)
                accel_active <= 0;  // Stream ctrl finished ? release bus

            // --- Classify instruction (sideband): captures src/dst and starts ---
            if (classify_pulse) begin
                src_addr     <= cls_src;
                dst_addr     <= cls_dst;
                start_proc   <= 1;
                accel_active <= 1;
            end

            if (wr_strobe) begin
                case (reg_addr)
                    // Thresholds (96 bits = 3 × 32-bit writes)
                    5'h00: thresholds_packed[31:0]   <= bus_data_in;
                    5'h01: thresholds_packed[63:32]  <= bus_data_in;
                    5'h02: thresholds_packed[95:64]  <= bus_data_in;

                    // Feature Selector Controls (48 bits = 2 × 32-bit writes)
                    5'h03: selector_ctrl_packed[31:0]  <= bus_data_in;
                    5'h04: selector_ctrl_packed[47:32] <= bus_data_in[15:0];

                    // Classifier Rules (96 bits = 3 × 32-bit writes)
                    5'h05: classifier_rules_packed[31:0]   <= bus_data_in;
                    5'h06: classifier_rules_packed[63:32]  <= bus_data_in;
                    5'h07: classifier_rules_packed[95:64]  <= bus_data_in;

                    // RGB Library (192 bits = 6 × 32-bit writes)
                    5'h08: rgb_library_packed[31:0]    <= bus_data_in;
                    5'h09: rgb_library_packed[63:32]   <= bus_data_in;
                    5'h0A: rgb_library_packed[95:64]   <= bus_data_in;
                    5'h0B: rgb_library_packed[127:96]  <= bus_data_in;
                    5'h0C: rgb_library_packed[159:128] <= bus_data_in;
                    5'h0D: rgb_library_packed[191:160] <= bus_data_in;

                    // DMA Parameters
                    5'h0E: dst_addr    <= bus_data_in;
                    5'h0F: pixel_count <= bus_data_in[15:0];

                    // Start: write src_addr AND trigger classification
                    5'h10: begin
                        src_addr     <= bus_data_in;
                        start_proc   <= 1;     // Pulse to stream controller
                        accel_active <= 1;     // Take over bus
                    end
                endcase
            end
        end
    end

    always @(*) begin
        case (reg_addr)
            5'h11:   SDO = {31'b0, done_proc};
            default: SDO = 32'h0;
        endcase
    end

endmodule
