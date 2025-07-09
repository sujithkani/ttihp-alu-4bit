import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start test")

    # 100 KHz clock (10 us period)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 2)

    # Example: ADD 4 + 3 = 7
    opcode = 0b0000          # ADD
    operand_a = 0b0100       # 4
    operand_b = 0b0011       # 3

    dut.ui_in.value = (opcode << 4) | operand_a
    dut.uio_in.value = operand_b

    await ClockCycles(dut.clk, 2)

    result = dut.uo_out.value.integer & 0xF
    dut._log.info(f"Result: {result}")
    assert result == 7, f"Expected 7, got {result}"

    # Add more tests for SUB, AND, OR, etc.
