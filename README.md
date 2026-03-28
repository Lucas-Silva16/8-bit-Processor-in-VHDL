# 8-Bit Processor in VHDL

![VHDL](https://img.shields.io/badge/Language-VHDL-orange)
![Tools](https://img.shields.io/badge/Tools-Vivado_ML_Edition-blue)
![Hardware](https://img.shields.io/badge/Hardware-Artix--7_NEXYS_A7-red)

## Introduction

This project describes the development and implementation of a basic **8-bit processor** using the **VHDL** hardware description language. The work was carried out as part of the **Computer Architecture** course at the University of Madeira.

The project covers everything from the creation of fundamental logic blocks to their final integration and physical configuration on an **Artix-7 (NEXYS A7/4 DDR)** FPGA, using the **Vivado ML Edition** design suite.

---

## Objectives

* **Design:** Create a processor capable of executing a specific instruction set.
* **Modeling:** Design internal modules such as the ALU, Registers, Program Counter (PC), and Decoder.
* **Integration:** Develop the *Top-Level* structure (Motherboard) interconnecting the Processor, ROM (Instructions), and RAM (Data).
* **Validation:** Test the architecture through simulations (*Testbench*) and physical peripheral mapping (PIN/POUT).

---

## System Architecture

### 1. The Processor (Core)

The core of the system is composed of the following essential modules:

* **Arithmetic Logic Unit (ALU):** Processes 8-bit operands in 2's complement. Executes arithmetic (addition, subtraction), logical (AND, OR, XOR), and shift (SHR, SHL) operations.
* **Registers:** Includes two general-purpose registers (A and B) and a Flags register for conditional flow control.
* **Flow Control:** The Program Counter (PC) manages ROM addresses, allowing sequential increments or jumps (`JMP`, `JZ`, `JL`).
* **Decoder:** The "brain" that interprets 5-bit opcodes and activates the necessary control signals.
* **Peripheral Manager:** Manages input (PIN) and output (POUT) communication.

### 2. Motherboard (Structural Integration)

At the top level, the processor is instantiated with:

* **ROM:** Instruction memory with 14-bit words.
* **RAM:** Data memory for persistence and temporary variables.

---

## Results and Discussion

Validation was performed through three main routines in the Testbench:

| Routine | Description | Expected Result |
| :--- | :--- | :--- |
| **Arithmetic and Loops** | Input of value "5" and execution of successive additions. | Output (POUT) correctly stopped at 50 via `JL` jumps. |
| **Logic and Negatives** | Test with value "-16" and `XOR` operations. | Validation of 2's complement logic and absolute value calculation. |
| **RAM Access and Shifts** | Counting "1" bits in a value (e.g., 60 -> `00111100`). | Use of `ST`/`LD` in RAM and `SHR`. Exact output of 4. |

> **Note:** Simulation waveforms validating these operations can be viewed in the report in Annex A.

---

## FPGA Hardware Tests

Physical validation of the processor running on the Artix-7 NEXYS A7 board.

<div align="center">

| Test | Photo |
|------|-------|
| **All outputs OFF** — counter running up to 50, LEDs unlit | <img src="https://media.discordapp.net/attachments/1418963199499309056/1483068491916509245/IMG_0637.jpg?ex=69c7bf2a&is=69c66daa&hm=9dfb88ee4df7671c78e1916e4e8710e9d7efa85d57764a103c505613be3ade8d&=&format=webp&width=642&height=856" width="220"/> |
| **2's complement test** — input `11111111` (-1 in 2's complement) | <img src="https://cdn.discordapp.com/attachments/1418963199499309056/1483068492495192116/IMG_0639.jpg?ex=69c7bf2a&is=69c66daa&hm=0a8895254e2fedd5384658c208b4e1df427cc2143bce18a5d463328d15a371a8&" width="220"/> |
| **Value > 50** — 5 output bits lit, corresponding to 5 active signals on POUT | <img src="https://cdn.discordapp.com/attachments/1418963199499309056/1483068493040718065/IMG_0641.jpg?ex=69c7bf2a&is=69c66daa&hm=d02a2e69265a8eefa6c2b4a40ec77fc7bf68e02c40f3da4ec7f2665809205c8e&" width="220"/> |

</div>

---

## Technologies Used

* **Language:** VHDL
* **Development Environment:** Xilinx Vivado ML Edition
* **Hardware:** FPGA Artix-7 (Nexys A7-100T or A7-50T)

---

## File Structure

* `/src`: VHDL source files
* `/sim`: Testbenches and simulation configuration files
* `/docs`: Additional documentation and structural diagrams

---

## Conclusion

This project consolidated modular and hierarchical hardware design concepts. The abstraction of blocks allowed for a focus on data routing, resulting in a fully functional system capable of manipulating RAM and executing complex arithmetic operations within the constraints of an FPGA.
