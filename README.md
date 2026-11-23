# CORDIC-Based Arcsine and Arccosine Hardware Calculator

A pipelined hardware implementation of **Arcsine (asin)** and **Arccosine (acos)** using the Coordinate Rotation Digital Computer (CORDIC) algorithm and Verilog HDL.

## Overview

This project presents the design and implementation of a CORDIC-based inverse trigonometric calculator using Verilog HDL.

The architecture uses a pipelined approach to compute arcsine and arccosine values for input values within the range [-1, 1].

The design uses fixed-point arithmetic and multiple CORDIC stages to perform the required computations efficiently in digital hardware.

## Key Features

- CORDIC-based arcsine and arccosine computation
- Verilog HDL implementation
- 24-bit fixed-point datapath
- 20 fractional bits
- 15 pipelined CORDIC stages
- 17-cycle output latency
- Separate arcsine and arccosine outputs
- Functional verification using a dedicated testbench
- FPGA synthesis using Xilinx Vivado

## Architecture

The design consists of the following modules:

1. **Top Module (`cordic_asin_acos.v`):** Handles input processing and generates arcsine and arccosine outputs.
2. **CORDIC Stage (`cordic_stage.v`):** Performs the iterative coordinate and angle calculations.
3. **Pipeline Architecture:** Connects the CORDIC stages to support pipelined computation.
4. **Testbench:** Verifies the calculated outputs against reference mathematical functions.

### Hardware Block Diagram

Input → Input Processing → CORDIC Pipeline → Arcsine and Arccosine Outputs

## Repository Structure

```text
CORDIC-Based-Arcsine-Arccosine-Hardware-Calculator/
│
├── rtl/
│   ├── cordic_asin_acos.v
│   └── cordic_stage.v
│
├── testbench/
│   └── tb_cordic_asin_acos.v
│
├── docs/
│   └── CORDIC_Arcsine_Arccosine_Project_Report.pdf
│
├── results/
│   ├── results.md
│   ├── rtl_schematic.png
│   ├── simulation_output.png
│   ├── simulation_waveform.png
│   └── utilization_report.png
│
├── references/
│   └── references.md
│
├── .gitignore
├── LICENSE
└── README.md
```

## Simulation and Verification

Functional simulation was performed using Xilinx Vivado 2023.2.

The testbench evaluates 2001 input samples across the range [-1, 1] and compares the calculated outputs against Verilog `$asin` and `$acos` reference functions.

### Example Simulation Result

For an input value of x = 0.6:

| Parameter | Design Output | Reference Output |
|---|---:|---:|
| Arcsine | 0.643518 | 0.643501 |
| Arccosine | 0.927278 | 0.927295 |

The approximate absolute error for both outputs is 1.7 × 10⁻⁵ radians for this sample.

## FPGA Synthesis Results

The design was synthesized for the Xilinx Artix-7 FPGA (`xc7a100tcsg324-1`).

| Resource | Used | Utilization |
|---|---:|---:|
| Slice LUTs | 1,584 | 2.50% |
| Slice Registers | 1,371 | 1.08% |
| DSP Blocks | 0 | 0% |
| Block RAM | 0 | 0% |

The implementation uses LUT-based logic and flip-flops without dedicated DSP blocks or block RAM.

## Results and Documentation

Detailed implementation results, including RTL schematic, simulation waveform, simulation output and FPGA resource utilization, are available here:

**[View Results and Performance Analysis](results/results.md)**

## Tools and Technologies

- Verilog HDL
- Xilinx Vivado 2023.2
- FPGA Synthesis
- RTL Simulation
- CORDIC Algorithm
- Fixed-Point Arithmetic

## Future Improvements

- FPGA board-level implementation and testing
- Numerical accuracy optimization
- Exploration of different datapath widths
- Hardware resource optimization
- Timing and performance optimization

## Research Reference

Paz and Garrido, *CORDIC-Based Computation of Arcsine and Arccosine Functions on FPGA*, 2023.

[Research Paper – IEEE DOI](https://doi.org/10.1109/TCSII.2023.3262353)

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
