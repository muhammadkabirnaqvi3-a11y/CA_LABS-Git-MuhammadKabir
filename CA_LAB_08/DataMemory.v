`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2026 12:50:59 PM
// Design Name: 
// Module Name: DataMemory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DataMemory(
     input clk, 
     input rst,
     input MemWrite, 
     input [31:0] address, 
     input [31:0] write_data,
     output reg [31:0] read_data
    );
    
    reg [31:0] mem[0:511]; 
    
    always @(posedge clk or posedge rst) begin 
        if(rst) begin
            read_data <= 32'b0;
        end
        else if(MemWrite == 1'b1) begin
            mem[address[8:0]] <= write_data;
        end
        else begin
            read_data <= mem[address[8:0]];
        end  
    end

endmodule

