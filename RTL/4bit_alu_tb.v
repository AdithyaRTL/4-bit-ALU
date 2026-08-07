`timescale 1ns/1ps

module alu_4bit_tb;

    reg  [3:0] A, B;
    reg  [2:0] ALU_Sel;
    wire [3:0] ALU_Out;
    wire       CarryOut, Zero;

    // Instantiate the 4-bit ALU
    alu_4bit uut (
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .ALU_Out(ALU_Out),
        .CarryOut(CarryOut),
        .Zero(Zero)
    );

    initial begin
        // Setup GTKWave dump file
        $dumpfile("alu_4bit.vcd");
        $dumpvars(0, alu_4bit_tb);

        // Define test input values: A = 12 (1100), B = 5 (0101)
        A = 4'b1100; 
        B = 4'b0101;

        // 000: AND Operation
        ALU_Sel = 3'b000; #10;

        // 001: OR Operation
        ALU_Sel = 3'b001; #10;

        // 010: NOT A Operation
        ALU_Sel = 3'b010; #10;

        // 011: NAND Operation
        ALU_Sel = 3'b011; #10;

        // 100: NOR Operation
        ALU_Sel = 3'b100; #10;

        // 101: XOR Operation
        ALU_Sel = 3'b101; #10;

        // 110: ADD (12 + 5 = 17 -> Out = 1, CarryOut = 1)
        ALU_Sel = 3'b110; #10;

        // 111: SUB (12 - 5 = 7 -> Out = 7, CarryOut = 1)
        ALU_Sel = 3'b111; #10;

        // Verify Zero Flag: SUB (5 - 5 = 0 -> Out = 0, Zero = 1)
        A = 4'b0101; 
        B = 4'b0101; 
        ALU_Sel = 3'b111; #10;

        $finish;
    end

endmodule
