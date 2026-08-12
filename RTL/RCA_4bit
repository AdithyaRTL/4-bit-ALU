module rca_4bit (
    input wire [3:0] A,
    input wire [3:0] B,
    input wire Cin,
    output wire [3:0] Sum,
    output wire Cout
);
    wire c1, c2, c3;

    // Bit 0
    assign Sum[0] = A[0] ^ B[0] ^ Cin;
    assign c1     = (A[0] & B[0]) | (B[0] & Cin) | (A[0] & Cin);

    // Bit 1
    assign Sum[1] = A[1] ^ B[1] ^ c1;
    assign c2     = (A[1] & B[1]) | (B[1] & c1) | (A[1] & c1);

    // Bit 2
    assign Sum[2] = A[2] ^ B[2] ^ c2;
    assign c3     = (A[2] & B[2]) | (B[2] & c2) | (A[2] & c2);

    // Bit 3
    assign Sum[3] = A[3] ^ B[3] ^ c3;
    assign Cout   = (A[3] & B[3]) | (B[3] & c3) | (A[3] & c3);

endmodule
