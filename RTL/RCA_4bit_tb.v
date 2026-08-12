timescale 1ns / 1ps

module rca_4bit_tb;

    // Inputs (driven by testbench)
    reg [3:0] A;
    reg [3:0] B;
    reg Cin;

    // Outputs (monitored from design)
    wire [3:0] Sum;
    wire Cout;

    // Instantiate Unit Under Test (UUT)
    rca_4bit uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        // Configure VCD file output for GTKWave
        $dumpfile("rca_4bit.vcd");
        $dumpvars(0, rca_4bit_tb);

        // Display results in terminal window during execution
        $monitor("Time=%0t ns | A=%d (%b) | B=%d (%b) | Cin=%b -> Sum=%d (%b) | Cout=%b", 
                 $time, A, A, B, B, Cin, Sum, Sum, Cout);

        // Test Case 1: Minimum input boundary (0 + 0 = 0)
        A = 4'd0; B = 4'd0; Cin = 1'b0; #10;

        // Test Case 2: Standard addition without carry out (5 + 3 = 8)
        A = 4'd5; B = 4'd3; Cin = 1'b0; #10;

        // Test Case 3: Carry generation with Cin (10 + 5 + 1 = 16 -> Sum=0, Cout=1)
        A = 4'd10; B = 4'd5; Cin = 1'b1; #10;

        // Test Case 4: Full ripple propagation path across all bits (15 + 0 + 1 = 16)
        A = 4'd15; B = 4'd0; Cin = 1'b1; #10;

        // Test Case 5: Maximum boundary limits (15 + 15 + 1 = 31 -> Sum=15, Cout=1)
        A = 4'd15; B = 4'd15; Cin = 1'b1; #10;

        $finish;
    end

endmodule
