`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2026 01:14:28 PM
// Design Name: 
// Module Name: Address_Decoder
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


module Address_Decoder(
input clk,
input rst,
input [31:0] address,
input readEnable, writeEnable, writeLed,
input [31:0] writeData,
input [15:0] switches,
input [31:0] datamemory,

output memWrite,
output reg [31:0] readData,
output reg [15:0] leds
);

wire [1:0] selector;

assign selector = address[9:8];
assign memWrite = (selector == 2'b00) && (writeEnable == 1'b1);

always @(posedge clk or posedge rst) begin
    if (rst)
        leds <= 16'b0;
    else if ((selector == 2'b01) && (writeLed == 1'b1))
        leds <= writeData[15:0];
end

//reading mux
always @(*) begin
    readData = 32'b0;
    if (readEnable) begin
        case (selector)
            2'b00:   readData = datamemory;
            2'b10:   readData = {16'b0, switches};
            default: readData = 32'b0;
        endcase
    end
end
    
endmodule

