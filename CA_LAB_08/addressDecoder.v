`timescale 1ns / 1ps

module addressDecoderTop(
    input clk, rst,
    input [31:0] address,
    input readEnable, writeEnable,
    input [31:0] writeData,
    input [15:0] switches,

    output [31:0] readData,
    output [15:0] leds
);
    wire        memWrite;
    wire [31:0] memReadData;

    Address_Decoder u_dec (
        .clk(clk),
        .rst(rst),
        .address(address),
        .readEnable(readEnable),
        .writeEnable(writeEnable),
        .writeLed(writeEnable),
        .writeData(writeData),
        .switches(switches),
        .datamemory(memReadData),
        .memWrite(memWrite),
        .readData(readData),
        .leds(leds)
    );

    DataMemory u_mem (
        .clk(clk),
        .rst(rst),
        .MemWrite(memWrite),
        .address(address),
        .write_data(writeData),
        .read_data(memReadData)
    );
endmodule