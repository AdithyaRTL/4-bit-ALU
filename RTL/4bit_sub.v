`timescale 1ns / 1ps

module sub_4bit (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire       bin,
    output wire [3:0] diff,
    output wire       bout
);

    wire b1, b2, b3;

    // Bit 0 Stage
    assign diff[0] = a[0] ^ b[0] ^ bin;
    assign b1      = (~a[0] & b[0]) | (b[0] & bin) | (~a[0] & bin);

    // Bit 1 Stage
    assign diff[1] = a[1] ^ b[1] ^ b1;
    assign b2      = (~a[1] & b[1]) | (b[1] & b1) | (~a[1] & b1);

    // Bit 2 Stage
    assign diff[2] = a[2] ^ b[2] ^ b2;
    assign b3      = (~a[2] & b[2]) | (b[2] & b2) | (~a[2] & b2);

    // Bit 3 Stage
    assign diff[3] = a[3] ^ b[3] ^ b3;
    assign bout    = (~a[3] & b[3]) | (b[3] & b3) | (~a[3] & b3);

endmodule
