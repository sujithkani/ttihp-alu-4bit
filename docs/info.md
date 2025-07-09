<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project implements a 4-bit Arithmetic Logic Unit (ALU) supporting seven basic operations:

- **Addition** (A + B)
- **Subtraction** (A - B)
- **Bitwise AND** (A & B)
- **Bitwise OR** (A | B)
- **Bitwise XOR** (A ^ B)
- **Bitwise NOT** (~A)
- **Pass-through B**

Inputs `A` and `B` are each 4-bit operands, supplied via the `ui_in` input bus. The operation to be performed is selected by a 3-bit `opcode`, provided via the lower bits of the bidirectional `uio_in` bus.
The result is output via the `uo_out` bus:
- `uo[7:4]` = 4-bit result
- `uo[0]` = Carry-out (for addition or subtraction)
Unused output bits (`uo[3:1]`) are reserved and not driven.

## How to test

To test the 4-bit ALU, follow these steps:
1. **Provide operands:**
   - Assign the 4-bit operand `A` to `ui[7:4]`
   - Assign the 4-bit operand `B` to `ui[3:0]`

2. **Select operation using `uio[2:0]`:**
   | Opcode | Operation     |
   |--------|---------------|
   | `000`  | A + B         |
   | `001`  | A - B         |
   | `010`  | A & B         |
   | `011`  | A \| B        |
   | `100`  | A ^ B         |
   | `101`  | ~A            |
   | `110`  | B (pass-through) |
   | `111`  | Reserved      |

3. **Observe outputs:**
   - `uo[7:4]` shows the result
   - `uo[0]` gives the carry-out
   - `uo[3:1]` are unused

**Example:**
To compute `A = 0b1010`, `B = 0b0011`, and perform addition (`opcode = 000`):
- Set `ui = 0b10100011`
- Set `uio[2:0] = 3'b000`
- Result = `0b1101` → appears on `uo[7:4]`
- If carry-out = 0, `uo[0] = 0`

## External hardware
This project does not require any external hardware.
Inputs and outputs are entirely digital and accessible via the standard TinyTapeout I/O pads.
