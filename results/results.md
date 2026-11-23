# Results and Performance Analysis

## 1. RTL Schematic

The RTL schematic illustrates the hardware architecture of the CORDIC-based arcsine and arccosine calculator, consisting of a top-level module connected to pipelined CORDIC stages.



## 2. Functional Simulation

Functional simulation was performed using Xilinx Vivado 2023.2.

The design calculates arcsine and arccosine values and compares them against reference mathematical functions.



## 3. Numerical Verification

For an input value of x = 0.6, the following results were observed:

| Parameter | Design Output | Reference Output |
| --------- | ------------: | ---------------: |
| Arcsine   |      0.643518 |         0.643501 |
| Arccosine |      0.927278 |         0.927295 |

The approximate absolute error for both outputs is 1.7 × 10⁻⁵ radians for this test sample.



## 4. FPGA Resource Utilization

Synthesis was performed for the Xilinx Artix-7 FPGA device (xc7a100tcsg324-1).

| Resource        |  Used | Utilization |
| --------------- | ----: | ----------: |
| Slice LUTs      | 1,584 |       2.50% |
| Slice Registers | 1,371 |       1.08% |
| DSP Blocks      |     0 |          0% |
| Block RAM       |     0 |          0% |
| Bonded IOBs     |    74 |      35.24% |

The implementation uses LUT-based logic and flip-flops without requiring dedicated DSP blocks or block RAM.



## 5. Timing Analysis

Timing performance will be documented using the Vivado timing summary.

- Clock period: 10 ns (testbench clock)



## 6. Conclusion

The simulation demonstrates the functional operation of the pipelined CORDIC-based arcsine and arccosine calculator.

The synthesis results show that the design can be implemented using the logic resources of an Artix-7 FPGA, without dedicated DSP or block RAM resources.

Further timing analysis and FPGA board-level testing can be used to evaluate the implementation under actual hardware conditions.
