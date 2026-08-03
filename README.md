# SpectraAccel - Final Project

**Hardware Acceleration for Multispectral Satellite Image Classification**

SpectraAccel is a custom FPGA-based hardware accelerator integrated within a DLX processor architecture, designed to classify Sentinel-2 multispectral satellite images in real-time.
Traditional satellite systems capture and transmit massive amounts of raw data to ground stations for software processing, creating severe bandwidth bottlenecks. 
SpectraAccel moves this classification directly into the hardware. By processing pixels on the fly and storing only the final classified image, it drastically reduces data payloads and enables real-time analysis at the edge.

## Key Features

*   **Custom DLX processor Instruction Set Architecture (ISA):** Introduces a dedicated `classify` assembly instruction that halts the main processor and transfers bus control to the accelerator, acting as a DMA for direct pixel processing.
*   **5 Stage Processing Pipeline:** Data flows through an Index Processing Unit (IPU), Feature Selector, Compare Unit, Logical Rules Builder, and finally a Colorizer.
*   **Fixed-Point Arithmetic (Q1.8):** Replaces resource heavy floating-point math with a highly efficient integer based format, retaining 99.97% accuracy with significantly lower latency and hardware utilization.
*   **Software Reference Model:** A Python-based Dash web application serves as a tuning interface for threshold research and a golden reference for hardware verification.
*   **Massive Speedup:** Achieves up to a 125x processing speedup compared to standard scalar execution, reaching throughputs of ~86 frames per second.

## Repository Structure

*   `HOME_VER/`: Core Verilog design files for the processor and Spectral Accelerator. Configured for standalone I/O SIM waveform verification of the internal pipeline.
*   `SOURCE_VER/`: System integration files for physical FPGA deployment. Interfaces the core design with external SRAM and the RESA hardware monitor.
*   `hardwareSIM/`: The Python based software reference model and Dash GUI used to simulate the pipeline and define class thresholds.
*   `comparing floating to fixed/`: Python scripts validating the Q1.8 fixed point quantization noise against standard floating point calculations.
*   `counter_ver/` & `working_bit/`: Compiled `.cod` assembly files, labels, and generated `.bit` bitstreams for FPGA execution.
*   `Presentation_project.pdf` & `project_book_SpectralAccel.docx`: Comprehensive project documentation, block diagrams and theoretical background.

## System Architecture

The accelerator sits on the RESA Bus alongside the DLX Master and External RAM. When the `classify` instruction (Opcode `010 000`) is fetched:

1.  The processor calculates the source and destination addresses.
2.  A `classify_pulse` triggers the accelerator's FSM (`ST_IDLE` → `ST_READ`).
3.  Raw 64-bit pixels (incorporating Visible, NIR, and SWIR bands) are pulled from RAM into a Read FIFO.
4.  The IPU calculates indices (NDVI, MNDWI, NDRE, BSI, ndFDI, Brightness).
5.  Pixels are evaluated against loaded threshold controllers.
6.  The Colorizer outputs 32 bit RGB classified pixels to a Write FIFO, which pushes them back to memory, halving the data footprint.

##  Performance Metrics

*   **Accuracy:** 99.9784% match (Mean Absolute Error of 0.0216%) compared to the software floating point model.
*   **Speed:** ~0.128 seconds to process a 420x400 image on the FPGA (vs. 64.39 seconds on a standard scalar CPU).
*   **Throughput:** 86.89 FPS.
*   **Hardware Utilization:** Highly efficient, utilizing 5,712 LUTs (equivalent to only 11-28 DSP slices).

## 👥 Authors
*   Yoav Halevi
*   Noam Dim

*Developed at the computer laboratory of Faculty of Engineering, Tel Aviv University.*
