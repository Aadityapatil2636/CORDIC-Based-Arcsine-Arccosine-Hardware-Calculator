# CORDIC-Based Arcsine and Arccosine Hardware Calculator

A pipelined hardware implementation of the inverse trigonometric functions **arcsine (asin)** and **arccosine (acos)** using the **Coordinate Rotation Digital Computer (CORDIC)** algorithm and Verilog HDL.

## Overview

This project implements a fixed-point CORDIC architecture to calculate arcsine and arccosine functions in digital hardware.

The design uses a pipelined architecture to improve throughput and supports both positive and negative input values within the valid input range of [-1, 1].

## Features

- CORDIC-based arcsine and arccosine computation
- Verilog HDL implementation
- 24-bit fixed-point datapath
- 15 pipelined CORDIC stages
- 17-cycle output latency
- Dedicated testbench for functional verification
- Comparison against Verilog mathematical reference functions

## Architecture

The design consists of:

1. **Top Module:** Handles input processing and produces arcsine and arccosine outputs.
2. **CORDIC Stage Module:** Performs the iterative CORDIC computation.
3. **Pipeline:** Connects the CORDIC stages to support continuous data processing.
4. **Testbench:** Verifies the outputs against reference values.

## Repository Structure

```text
├── rtl/
│   ├── cordic_asin_acos.v
│   └── cordic_stage.v
├── testbench/
│   └── tb_cordic_asin_acos.v
├── docs/
│   └── CORDIC_Arcsine_Arccosine_Project_Report.pdf
├── references/
│   └── references.md
├── results/
├── .gitignore
├── LICENSE
└── README.md
```

## Verification

The testbench evaluates 2001 input samples across the range [-1, 1] and compares the hardware outputs against the Verilog `$asin` and `$acos` reference functions.

## Implementation Tools

- Verilog HDL
- Xilinx Vivado
- FPGA synthesis and simulation tools

## Future Improvements

- FPGA board-level implementation
- Optimization of numerical accuracy
- Exploration of different datapath widths
- Further optimization of hardware resources

## Reference

Paz and Garrido, "CORDIC-Based Computation of Arcsine and Arccosine Functions on FPGA," 2023.

[Research Paper DOI](https://doi.org/10.1109/TCSII.2023.3262353)

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
