module tt_um_sujith_alu4 (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        ena,
    input  wire [7:0]  ui_in,     // [7:4]=A, [3:0]=B
    output reg  [7:0]  uo_out,    // [7:4]=Result, [0]=Carry
    input  wire [7:0]  uio_in,    // [2:0]=Opcode
    output reg  [7:0]  uio_out,
    output reg  [7:0]  uio_oe
);

    wire [3:0] A = ui_in[7:4];
    wire [3:0] B = ui_in[3:0];
    wire [2:0] opcode = uio_in[2:0];

    reg [4:0] result;

    always @(*) begin
        if (!ena) begin
            result  = 5'b0;
            uo_out  = 8'b0;
        end else begin
            case (opcode)
                3'b000: result = A + B;      // ADD
                3'b001: result = A - B;      // SUB
                3'b010: result = A & B;      // AND
                3'b011: result = A | B;      // OR
                3'b100: result = A ^ B;      // XOR
                3'b101: result = ~A;         // NOT A
                3'b110: result = B;          // PASS B
                default: result = 5'b0;
            endcase
            uo_out = {result[3:0], 3'b000, result[4]};
        end

        uio_out = 8'b0;
        uio_oe  = 8'b0;
    end
endmodule
