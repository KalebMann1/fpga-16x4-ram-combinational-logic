# 16×4 RAM-Based Combinational Logic (Verilog, Vivado, Basys 3)

This project implements a **16-word by 4-bit RAM** in Verilog and uses it as
a building block for combinational logic. The design was developed and tested
in Xilinx Vivado and targeted to a Basys-class FPGA board.

The idea is to show how small on-chip memories (RAM and ROM) can replace large
networks of discrete logic gates, while remaining easy to modify and reuse.

---

## Project Goals

- Implement a synthesizable **16×4 single-port RAM**.
- Demonstrate how RAM/ROM can realize combinational functions.
- Verify the design with a **behavioral simulation testbench**.
- Map the design to an FPGA and interact with it via switches and LEDs.

---

## Design Overview

### 16×4 RAM (`ram16x4.v`)

Key characteristics:

- 16 addresses (`Addr[3:0]`), each storing a 4-bit word.
- Single data port:
  - `DataIn[3:0]`, `DataOut[3:0]`
- Control signals:
  - `WE` (write enable)
  - `CLK` (optional for a clocked write implementation)

Typical behavior:

- When `WE = 1`, the RAM writes `DataIn` into the location selected by `Addr`.
- When `WE = 0`, the RAM outputs the word stored at `Addr` on `DataOut`.

This models a small memory block that can be repurposed for different
truth tables just by changing its contents.

### Optional ROM Function (`rom16x4_func.v`)

To emphasize the connection to combinational logic, the project can also include
a simple 16×4 ROM whose contents implement a fixed function:

- Inputs: `Addr[3:0]`
- Outputs: `F[3:0]` = some Boolean function of the inputs
- Contents are initialized with a constant table (e.g., parity, 7-segment codes,
  or any custom mapping).

---

## Simulation (`tb_ram16x4.v`)

The testbench exercises the RAM interface by:

- Writing known 4-bit patterns to all 16 addresses.
- Reading each address back and checking that:
  - `DataOut` matches the stored word.
- Optionally sweeping through all ROM addresses to show the output function.

This is run as a **behavioral simulation** in Vivado to validate correctness
before programming the FPGA.

---

## FPGA Implementation (Basys 3 Example)

A simple top-level wrapper can be used to connect the memory to the board:

- Map:
  - `Addr[3:0]` to board switches
  - `DataIn[3:0]` to another bank of switches
  - `DataOut[3:0]` to LEDs
  - `WE` to a pushbutton or switch
- Generate a **bitstream** and program the Basys board.
- Flip switches to:
  - Load values into different addresses when `WE = 1`
  - Read back stored values when `WE = 0`

This demonstrates how a small RAM block can emulate many different
combinational circuits without changing the HDL.

---

## Concepts Highlighted

- Using **RAM and ROM to implement combinational logic**.
- Tradeoffs between:
  - Traditional gate-level implementations vs table-driven designs.
- Practical FPGA workflow:
  - Write RTL → Synthesize → Implement → Generate bitstream → Program board.
- Verification with a structured testbench and behavioral simulation.

---

## Skills Demonstrated

- Verilog RTL design for memory blocks.
- Vivado project setup, synthesis, implementation, and simulation.
- FPGA bring-up on a Basys-class development board.
- Understanding of how memory devices can replace complex combinational logic.
