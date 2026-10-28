`timescale 1ns / 1ps

module Control_tb;
    reg [6:0] opcode;
    reg [2:0] funct3;
    reg [6:0] funct7;

    wire RegWrite, MemRead, MemWrite, ALUSrc, MemtoReg, Branch;
    wire [1:0] ALUOp;
    
    wire [3:0] ALUControl_out;

    MainControl mc (
        .opcode(opcode),
        .RegWrite(RegWrite),
        .ALUOp(ALUOp),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .Branch(Branch)
    );

    ALUControl ac (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .ALUControl(ALUControl_out)
    );

    initial begin
        $display("Testing RISC-V Control Path...");
        $monitor("Time=%0t | Opcode=%b | F3=%b F7[5]=%b | ALUOp=%b ALUControl=%b | RegW=%b MemR=%b MemW=%b Mem2R=%b ALUSrc=%b Br=%b", 
                 $time, opcode, funct3, funct7[5], ALUOp, ALUControl_out, RegWrite, MemRead, MemWrite, MemtoReg, ALUSrc, Branch);

        // ADD (R-type)
        opcode = 7'b0110011; funct3 = 3'b000; funct7 = 7'b0000000; #10;
        
        // SUB (R-type)
        opcode = 7'b0110011; funct3 = 3'b000; funct7 = 7'b0100000; #10;

        // AND (R-type)
        opcode = 7'b0110011; funct3 = 3'b111; funct7 = 7'b0000000; #10;

        // ADDI (I-type)
        opcode = 7'b0010011; funct3 = 3'b000; funct7 = 7'b0000000; #10;

        // LW (Load)
        opcode = 7'b0000011; funct3 = 3'b010; funct7 = 7'b0000000; #10;

        // SW (Store)
        opcode = 7'b0100011; funct3 = 3'b010; funct7 = 7'b0000000; #10;

        // BEQ (Branch)
        opcode = 7'b1100011; funct3 = 3'b000; funct7 = 7'b0000000; #10;

        $finish;
    end
endmodule