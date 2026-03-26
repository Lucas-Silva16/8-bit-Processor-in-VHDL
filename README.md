# Digital ATM in Verilog

![Verilog](https://img.shields.io/badge/Language-Verilog-blue)
![Tools](https://img.shields.io/badge/Tools-Xilinx_ISE-orange)
![Domain](https://img.shields.io/badge/Domain-Digital_Logic-lightgrey)

## Introduction
This project details the development and implementation of a digital **Automated Teller Machine (ATM)** system using **Verilog** hardware description language. It combines sequential logic and schematic design to accurately simulate the core functionalities of a banking terminal.

The project covers the creation of fundamental logic blocks, their integration, and full system validation using the **Xilinx ISE** design suite.

---

## Objectives
* **Authentication:** Implement robust card insertion detection and PIN verification logic.
* **Transaction Processing:** Enable balance deduction based on user-inputted values using 2's complement arithmetic.
* **Security:** Generate parity signals based on predefined identification numbers to ensure data integrity.
* **Integration:** Combine isolated Verilog modules into a cohesive top-level digital system.

---

## System Architecture

### 1. Authentication Module
* **Card Insertion (EN):** Acts as the primary enable signal. The system remains strictly inactive (`EN = 1`) until a card is physically detected (`EN = 0`).
* **PIN Verification:** Compares a 4-bit user input (`PIN`) against a hardcoded 5-bit authentication code (`COD`) stored in Excess-3 BCD format.

### 2. Transaction Module
* **Balance Management:** Stores and maintains the current account balance (`SALDO`).
* **Arithmetic Operations:** Processes the requested transaction value (`VAL`, 4 bits) using 2's complement subtraction. It safely updates the internal balance and outputs the resulting value to the display (`ECRA`).

### 3. Security Module
* **Parity Generator:** Calculates a parity bit (`PAR`) based on specific student ID numbers, acting as a hardware-level validation layer.

---

## Results and Validation
System validation was performed by simulating the following core scenarios:

| Scenario | Description | Expected Result |
| :--- | :--- | :--- |
| **No Card** | `EN` signal set to 1. | System remains completely inactive; all operations blocked. |
| **Invalid PIN** | `EN = 0`, but an incorrect 4-bit PIN is entered. | `ECRA = 0`, `PAR = 1`. Transaction is immediately denied. |
| **Valid Transaction** | Correct PIN entered, followed by a valid withdrawal amount (`VAL`). | Deduction authorized, `SALDO` updated in memory, and the new balance is displayed on `ECRA`. |

> **Note:** Full simulation waveforms validating these states can be found in the project documentation.

---

## Technologies Used
* **Language:** Verilog
* **Development Environment:** Xilinx ISE Design Suite
* **Core Concepts:** Excess-3 BCD, 2's Complement, Synchronous Sequential Logic

---

## File Structure
* `/src`: Verilog source files and schematic modules.
* `/sim`: Simulation waveforms and test configurations.
* `/docs`: Project documentation and digital logic diagrams.

---

## Conclusion
This project bridges theoretical digital logic concepts with practical hardware simulation. By modularizing authentication, arithmetic, and security components, it demonstrates a scalable approach to designing finite state machines and secure digital systems operating strictly at the hardware level.
