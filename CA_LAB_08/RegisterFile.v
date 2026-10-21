`timescale 1ns / 1ps

module RegisterFile (
    input  wire        clk,
    input  wire        rst,
    input  wire        WriteEnable,
    input  wire [4:0]  rs1,
    input  wire [4:0]  rs2,
    input  wire [4:0]  rd,
    input  wire [31:0] WriteData,
    output wire [31:0] ReadData1,
    output wire [31:0] readData2
);

    // 32 registers, each 32 bits wide
    reg [31:0] regs [31:0];
    integer i;

    // Asynchronous read logic (Register x0 always reads as 0)
    assign ReadData1 = (rs1 == 5'd0) ? 32'd0 : regs[rs1];
    assign readData2 = (rs2 == 5'd0) ? 32'd0 : regs[rs2];

    // Synchronous write and reset logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset behavior: clear all registers
            for (i = 0; i < 32; i = i + 1) begin
                regs[i] <= 32'd0;
            end
        end else if (WriteEnable) begin
            // Write to rd only if WriteEnable is high and rd is not x0
            if (rd != 5'd0) begin
                regs[rd] <= WriteData;
            end
        end
    end

endmodule