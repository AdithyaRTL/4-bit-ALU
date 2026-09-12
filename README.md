# 4-bit-ALU

A 4-bit Arithmetic Logic Unit (ALU) designed and implemented using **Verilog HDL**. The ALU performs eight arithmetic and logical operations selected using a 3-bit operation select input.

The design was developed at the **behavioral level** using a single Verilog module and verified through simulation using **Icarus Verilog and GTKWave**. The RTL design was also synthesized using **Yosys**.

---

## Project Overview

The objective of this project is to design a compact and functional **4-bit ALU** capable of performing both logical and arithmetic operations on two 4-bit operands.

The ALU accepts:

- Two 4-bit operands: `A[3:0]` and `B[3:0]`
- A 3-bit operation select: `ALU_sel[2:0]`
- A carry input: `CIN`

Based on the selected operation, the corresponding result is generated at `ALU_Out[3:0]`.

The architecture uses separate logical and arithmetic operation blocks, followed by an **8-to-1 multiplexer** to select the final ALU output.


## Features

- 4-bit ALU architecture
- Two 4-bit operand inputs
- Eight logical and arithmetic operations
- 3-bit operation selection
- Separate 4-bit arithmetic blocks for addition and subtraction
- 8-to-1 multiplexer for operation selection
- Carry input (`CIN`)
- Carry output (`COUT`)
- Zero detection (`ZERO`)
- Behavioral-level Verilog implementation
- Single-module RTL design
- Complete verification of all eight operations
- RTL synthesis using Yosys
- Waveform verification using GTKWave

---

## Operation / Opcode Table

The ALU uses `ALU_sel[2:0]` as the operation select input.

| `ALU_sel[2:0]` | Operation | Description |
|:---:|---|---|
| `000` | AND | `A AND B` |
| `001` | OR | `A OR B` |
| `010` | NOT | `NOT A` |
| `011` | NAND | `A NAND B` |
| `100` | NOR | `A NOR B` |
| `101` | XOR | `A XOR B` |
| `110` | ADD | `A + B` |
| `111` | SUB | `A - B` |

---

## Input and Output Signals

| Signal | Direction | Width | Description |
|---|:---:|:---:|---|
| `A` | Input | 4-bit | First operand |
| `B` | Input | 4-bit | Second operand |
| `ALU_sel` | Input | 3-bit | Operation selection |
| `CIN` | Input | 1-bit | Carry input |
| `ALU_Out` | Output | 4-bit | ALU result |
| `COUT` | Output | 1-bit | Carry output |
| `ZERO` | Output | 1-bit | Indicates zero result |

---

## Design Architecture

The ALU is divided into two major categories of operations.

<img width="1536" height="1024" alt="Block diagram" src="https://github.com/user-attachments/assets/0821afb1-cdb7-4607-adc5-c1ff0626d460" />


### Logical Operations

The following 4-bit logic blocks are implemented:

```text
4-bit AND
4-bit OR
4-bit NOT
4-bit NAND
4-bit NOR
4-bit XOR
```

Each block operates on the 4-bit operands and generates a 4-bit intermediate result.

### Arithmetic Operations

The arithmetic section contains separate:

```text
4-bit Adder
4-bit Subtractor
```

The arithmetic operations use the `CIN` input and generate the corresponding arithmetic result and carry information.

### Operation Selection

The outputs from all eight operation blocks are connected to an **8-to-1, 4-bit-wide multiplexer**.

```text
             Operation Results
                   |
                   v
       +-----------------------+
       |       8-to-1 MUX      |
       |       4-bit wide      |
       +-----------------------+
                   |
                   v
             ALU_Out[3:0]
```

The `ALU_sel[2:0]` signal controls the multiplexer selection.

---

## Verilog Implementation

The ALU is implemented using **behavioral-level Verilog** in a single module.

The design uses the operation select signal to determine which operation is performed and which result is assigned to `ALU_Out`.

### Module Interface

```verilog
module alu_4bit (
    input  [3:0] A,
    input  [3:0] B,
    input  [2:0] ALU_sel,
    input        CIN,
    output [3:0] ALU_Out,
    output       COUT,
    output       ZERO
);
```

---

## Simulation

The design was verified using:

- **Icarus Verilog** — RTL simulation
- **GTKWave** — waveform analysis

A testbench was used to verify all eight ALU operations by applying different combinations of:

- `A`
- `B`
- `ALU_sel`
- `CIN`

The resulting `ALU_Out`, `COUT`, and `ZERO` signals were observed through the generated waveform.

### Verification Coverage

| Operation | Opcode | Tested |
|---|:---:|:---:|
| AND | `000` | ✓ |
| OR | `001` | ✓ |
| NOT | `010` | ✓ |
| NAND | `011` | ✓ |
| NOR | `100` | ✓ |
| XOR | `101` | ✓ |
| Addition | `110` | ✓ |
| Subtraction | `111` | ✓ |

---

## Simulation Results

All eight operations were tested successfully in simulation.

<img width="1145" height="172" alt="4bit alu waveform" src="https://github.com/user-attachments/assets/181b624d-c240-4e08-9f54-82615c696e20" />


The GTKWave waveform was used to verify the relationship between the operation select signal and the corresponding ALU output.

The simulation verifies that changing `ALU_sel` selects the expected operation and produces the corresponding `ALU_Out`.


```markdown
![GTKWave Simulation](images/gtkwave_simulation.png)
```

---

## Synthesis

The Verilog RTL was synthesized using **Yosys**.

The synthesis step was used to verify that the behavioral Verilog description can be converted into a synthesizable hardware representation.

Basic synthesis flow:

```text
Verilog RTL
     |
     v
   Yosys
     |
     v
Synthesized Netlist
```

---

## Tools Used

| Tool | Purpose |
|---|---|
| Verilog HDL | RTL design |
| Icarus Verilog | Simulation |
| GTKWave | Waveform analysis |
| Yosys | RTL synthesis |
| GitHub | Version control and project hosting |

---

## Project Structure

A recommended repository structure is:

```text
4-bit-ALU/
│
├── rtl/
│   └── alu_4bit.v
│
├── testbench/
│   └── alu_4bit_tb.v
│
├── simulation/
│   └── 4bit_alu.png
│
├── docs/
│   └── alu_architecture.png
│
└── README.md
```

---

## How to Run the Simulation

### 1. Compile the Verilog design

```bash
iverilog -o alu_4bit_sim rtl/alu_4bit.v testbench/alu_4bit_tb.v
```

### 2. Run the simulation

```bash
vvp alu_4bit_sim
```

This generates the waveform file if `$dumpfile` and `$dumpvars` are included in the testbench.

### 3. Open the waveform in GTKWave

```bash
gtkwave alu_4bit.vcd
```

The waveform can then be used to inspect the inputs, operation selection, ALU output, carry output, and zero flag.

---

## Key Learning Outcomes

This project provided practical understanding of:

- Verilog behavioral modeling
- ALU architecture
- Combinational logic design
- 4-bit arithmetic circuits
- Logic operations in hardware
- Multiplexer-based operation selection
- Carry propagation
- Testbench development
- RTL simulation
- Waveform debugging
- RTL synthesis using Yosys

---

## Future Improvements

Possible extensions to the design include:

- Parameterized ALU width
- Additional arithmetic operations
- Shift and rotate operations
- Comparison operations
- Additional status flags
- Gate-level synthesis and netlist analysis
- FPGA implementation
- Physical design flow using open-source VLSI tools

---

## Conclusion

This project demonstrates the design and verification of a **4-bit ALU using Verilog HDL**. The ALU integrates eight logical and arithmetic operations and uses an 8-to-1 multiplexer to select the required operation based on a 3-bit control signal.

The design was simulated using **Icarus Verilog**, verified using **GTKWave**, and synthesized using **Yosys**, providing a complete introductory RTL-to-synthesis digital design workflow.

