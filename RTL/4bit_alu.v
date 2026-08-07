module alu_4bit (
    input  wire [3:0] A,        // 4-bit Input A
    input  wire [3:0] B,        // 4-bit Input B
    input  wire [2:0] ALU_Sel,  // 3-bit Operation Select line
    output reg  [3:0] ALU_Out,  // 4-bit ALU Output
    output reg        CarryOut, // Carry/Borrow Flag (active for ADD/SUB)
    output wire       Zero      // Zero Flag (1 when ALU_Out is 4'b0000)
);

    reg [4:0] tmp; // 5-bit temporary register to capture carry output

    // Zero flag output: Active high whenever ALU_Out is 0
    assign Zero = (ALU_Out == 4'b0000) ? 1'b1 : 1'b0;

    always @(*) begin
        CarryOut = 1'b0; // Default carry assignment to prevent latch creation
        case (ALU_Sel)
            3'b000: begin // AND
                ALU_Out = A & B;
            end

            3'b001: begin // OR
                ALU_Out = A | B;
            end

            3'b010: begin // NOT A
                ALU_Out = ~A;
            end

            3'b011: begin // NAND
                ALU_Out = ~(A & B);
            end

            3'b100: begin // NOR
                ALU_Out = ~(A | B);
            end

            3'b101: begin // XOR
                ALU_Out = A ^ B;
            end

            3'b110: begin // ADD
                tmp      = A + B;
                ALU_Out  = tmp[3:0];
                CarryOut = tmp[4]; // 5th bit holds the carry bit
            end

            3'b111: begin // SUB
                tmp      = A - B;
                ALU_Out  = tmp[3:0];
                CarryOut = tmp[4]; // 5th bit holds the borrow/carry bit
            end

            default: begin
                ALU_Out  = 4'b0000;
                CarryOut = 1'b0;
            end
        endcase
    end

endmodule
