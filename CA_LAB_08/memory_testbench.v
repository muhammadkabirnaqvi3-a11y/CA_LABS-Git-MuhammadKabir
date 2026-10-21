`timescale 1ns / 1ps

module memory_testbench;
    reg         clk = 0;
    reg         pbin = 0;
    reg  [15:0] physical_sw = 16'd0;
    wire [15:0] physical_leds;
    integer     i;

    top_rf_alu dut (
        .clk(clk), .pbin(pbin),
        .physical_sw(physical_sw), .physical_leds(physical_leds)
    );

    always #5 clk = ~clk;

    initial begin
        for (i = 0; i < 512; i = i + 1)
            dut.u_adt.u_mem.mem[i] = 32'd0;

        force dut.rst_clean = 1'b1;
        #100;
        force dut.rst_clean = 1'b0;
        #100;

        physical_sw = {4'b0010, 4'b0000, 4'd5, 4'd3};
        #200;

        physical_sw[11:10] = 2'b01;
        physical_sw[9]     = 1'b1;
        #200;

        physical_sw[9]   = 1'b0;
        physical_sw[3:0] = 4'd1;
        physical_sw[7:4] = 4'd1;
        #200;

        physical_sw[8] = 1'b1;
        #200;

        physical_sw[11:10] = 2'b10;
        #200;

        $finish;
    end
endmodule