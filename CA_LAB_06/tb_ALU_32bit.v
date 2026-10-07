`timescale 1ns / 1ps

module tb_ALU_32bit;
    reg [31:0] A;
    reg [31:0] B;
    reg [3:0]  ALUControl;

    wire [31:0] ALUResult;
    wire        Zero;

    ALU_32bit uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    initial begin
        // Use fixed 32-bit numbers as operands A and B
        A = 32'h10101010;
        B = 32'h01010101;
        
        ALUControl = 4'b0000; #10; // AND
        ALUControl = 4'b0001; #10; // OR
        ALUControl = 4'b0010; #10; // ADD
        ALUControl = 4'b0011; #10; // XOR
        ALUControl = 4'b0100; #10; // SLL
        ALUControl = 4'b0101; #10; // SRL
        ALUControl = 4'b0110; #10; // SUB

        A = 32'h10101010;
        B = 32'h10101010;
        ALUControl = 4'b0110; #10; // SUB -> Result should be 0x00000000, Zero should be 1
        $finish;
    end
endmodule
