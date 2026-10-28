`timescale 1ns / 1ps

module MainControl(
    input [6:0] opcode,
    output reg RegWrite,
    output reg [1:0] ALUOp,
    output reg MemRead,
    output reg MemWrite,
    output reg ALUSrc,
    output reg MemtoReg,
    output reg Branch
);

    always @(*) begin
        RegWrite = 0; ALUOp = 2'b00; MemRead = 0; MemWrite = 0; 
        ALUSrc = 0; MemtoReg = 0; Branch = 0;
        
        case(opcode)
            7'b0110011: begin // R-type
                RegWrite = 1; ALUOp = 2'b10;
            end
            7'b0010011: begin // I-type (ADDI)
                RegWrite = 1; ALUOp = 2'b11; ALUSrc = 1;
            end
            7'b0000011: begin // Load (LW, LH, LB)
                RegWrite = 1; ALUOp = 2'b00; MemRead = 1; 
                MemtoReg = 1; ALUSrc = 1;
            end
            7'b0100011: begin // Store (SW, SH, SB)
                ALUOp = 2'b00; MemWrite = 1; ALUSrc = 1;
            end
            7'b1100011: begin // Branch (BEQ)
                ALUOp = 2'b01; Branch = 1;
            end
            default: ;
        endcase
    end
endmodule