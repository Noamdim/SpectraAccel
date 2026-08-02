`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:29:26 07/31/2026
// Design Name:   Top_Level_SIM
// Module Name:   E:/adlx/C1/proj_sim/HOME_VER/scalar.v
// Project Name:  HOME_VER
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top_Level_SIM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module scalar;

	// Inputs
	reg CLK_IN;
	reg RST_IN;
	reg STEP_IN;

	// Instantiate the Top_Level_SIM 
    Top_Level_SIM UUT (
        .CLK_IN(CLK_IN), 
        .RST_IN(RST_IN), 
        .STEP_IN(STEP_IN)
    );

    // Clock generation
    initial CLK_IN = 0;
    always #10 CLK_IN = ~CLK_IN;

    // Simulation sequence variables
    integer i;
    integer j; // Added a separate integer for the memory print loop

    // Main Test Stimulus Sequence
    initial begin
        // Initialize Inputs
        RST_IN = 0;
        STEP_IN = 0;

        // Apply Reset
        #40;
        RST_IN = 1;
        #60;
        RST_IN = 0;
        #100;
        
        $display("[INFO] Starting scalar instruction pulses...");

        // The DLX needs STEP_IN to be pulsed for each instruction
        // The scalar code requires tens of thousands of instructions!
        for (i = 0; i < 150000; i = i + 1) begin
            STEP_IN = 1;
            #20;
            STEP_IN = 0;
            #300;
        end

        $display("Reached 150,000 max instruction pulses (Timeout).");
        $stop;
    end

    // Monitor for SACK_N collisions
    always @(negedge UUT.CLK) begin
        if (UUT.SACK_N == 0 && UUT.SACK_N_ACCEL == 0) begin
            $display("[%0t] ERROR: SACK_N collision! Both slaves acknowledged.", $time);
        end
    end

    // =========================================================
    // Classification Monitoring
    // =========================================================

    // Monitor classify instruction execution
    always @(posedge UUT.CLK) begin
        if (UUT.classify_pulse)
            $display("[%0t] CLASSIFY issued: src_addr=0x%h, dst_addr=0x%h, pixel_count=%0d",
                     $time,
                     UUT.MDO,   // Rs = source address
                     UUT.MAO,   // Rs+imm = destination address
                     UUT.u_accel_slave.pixel_count);
    end

    // Monitor accel_active transitions
    always @(posedge UUT.CLK) begin
        if (UUT.u_accel_slave.accel_active && !UUT.u_accel_slave.done_proc)
            ; // active, processing
        if (UUT.u_accel_slave.done_proc && UUT.accel_active)
            $display("[%0t] CLASSIFICATION COMPLETE. All pixels processed.", $time);
    end

    // Monitor each pixel written to memory
    always @(posedge UUT.CLK) begin
        if (UUT.u_stream_ctrl.state == 3'b100 &&   // ST_WRITE_WORD
            !UUT.u_stream_ctrl.ack_n) begin
            $display("[%0t] OUTPUT Pixel %0d -> SRAM[0x%h] = 0x%h  (R=0x%h, G=0x%h, B=0x%h)",
                     $time,
                     UUT.u_stream_ctrl.written_pixels_count,
                     UUT.u_stream_ctrl.cur_write_addr,
                     UUT.u_stream_ctrl.wr_fifo_dout,
                     UUT.u_stream_ctrl.wr_fifo_dout[23:16],
                     UUT.u_stream_ctrl.wr_fifo_dout[15:8],
                     UUT.u_stream_ctrl.wr_fifo_dout[7:0]);
        end
    end

    // Monitor each pixel entering SpectraAccel
    always @(posedge UUT.CLK) begin
        if (UUT.u_stream_ctrl.accel_valid_in)
            $display("[%0t] INPUT  Pixel -> SpectraAccel: data=0x%h",
                     $time, UUT.u_stream_ctrl.accel_pixel_data);
    end

    // Monitor SpectraAccel classification results
    always @(posedge UUT.CLK) begin
        if (UUT.u_spectra.valid_out)
            $display("[%0t] CLASSIFIED -> R=0x%h G=0x%h B=0x%h | class_vector=0x%h",
                     $time,
                     UUT.u_spectra.red_out,
                     UUT.u_spectra.green_out,
                     UUT.u_spectra.blue_out,
                     UUT.u_spectra.w_class_vector);
    end

    // Monitor DLX halt
    always @(posedge UUT.CLK) begin
        if (UUT.DLX_STATE == 5'd19)
            $display("[%0t] DLX reached HALT state.", $time);
    end

    // Final summary at end of simulation
    initial begin
        @(posedge (UUT.DLX_STATE == 5'd19)); // Wait for the HALT state!
        #100;
        $display("");
        $display("========== FINAL SRAM OUTPUT (addresses 0x51-0x60) ==========");
        for (j = 81; j <= 96; j = j + 1) begin // Changed 'i' to 'j'
            $display("  SRAM[0x%h] = 0x%h", j[9:0], UUT.XLXI_23.EXTERNAL_RAM.memory_array[j]);
        end
        $display("=============================================================");
        $display("Total instructions executed: %0d", i);
        $stop; // Simulation instantly ends here as soon as the code finishes!
    end

endmodule

