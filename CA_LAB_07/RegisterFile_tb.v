`timescale 1ns / 1ps

module RegisterFile_tb;

    reg         clk;
    reg         rst;
    reg         WriteEnable;
    reg  [4:0]  rs1;
    reg  [4:0]  rs2;
    reg  [4:0]  rd;
    reg  [31:0] WriteData;

    wire [31:0] ReadData1;
    wire [31:0] readData2;

    RegisterFile rfile (
        .clk(clk),
        .rst(rst),
        .WriteEnable(WriteEnable),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .readData2(readData2)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0; rst = 1; WriteEnable = 0;
        rs1 = 0; rs2 = 0; rd = 0; WriteData = 0;

        #15 rst = 0;

        // Test i: Write a value to a register and check on next clock
        WriteEnable = 1; rd = 5'd5; WriteData = 32'hDEADBEEF;
        #10;
        WriteEnable = 0; rs1 = 5'd5; 
        #10;
        if (ReadData1 == 32'hDEADBEEF) $display("Test i Passed: Write/Read x5");

        // Test ii: Attempt to write to x0 and verify it remains zero
        WriteEnable = 1; rd = 5'd0; WriteData = 32'hFFFFFFFF;
        #10;
        WriteEnable = 0; rs1 = 5'd0;
        #10;
        if (ReadData1 == 32'd0) $display("Test ii Passed: x0 remains zero");

        // Test iii: Simultaneous two read ports
        WriteEnable = 1; rd = 5'd6; WriteData = 32'h12345678; #10;
        WriteEnable = 0; rs1 = 5'd5; rs2 = 5'd6; #10;
        if (ReadData1 == 32'hDEADBEEF && readData2 == 32'h12345678) 
            $display("Test iii Passed: Simultaneous dual reads");

        // Test iv: Overwrite a register
        WriteEnable = 1; rd = 5'd5; WriteData = 32'hCAFEBA5E; #10;
        WriteEnable = 0; rs1 = 5'd5; #10;
        if (ReadData1 == 32'hCAFEBA5E) $display("Test iv Passed: Overwrite x5");

        // Test v: Reset behavior
        rst = 1; #10;
        rst = 0; rs1 = 5'd5; rs2 = 5'd6; #10;
        if (ReadData1 == 32'd0 && readData2 == 32'd0) 
            $display("Test v Passed: Reset clears registers");

        $finish;
    end

endmodule