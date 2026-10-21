`timescale 1ns / 1ps

module top_rf_alu (
    input  wire        clk,
    input  wire        pbin,
    input  wire [15:0] physical_sw,
    output wire [15:0] physical_leds
);
    wire        rst_clean;
    reg  [31:0] led_write_data = 32'd0;

    debouncer rst_db (.clk(clk), .pbin(pbin), .pbout(rst_clean));

    //LED output module 
    switches led_writer (
        .clk(clk), .rst(rst_clean), .writeData(led_write_data),
        .writeEnable(1'b1), .readEnable(1'b0), .memAddress(30'd0),
        .readData(), .leds(physical_leds)
    );

    wire [31:0] sw_read_data;

    leds u_sw (
        .clk(clk),
        .rst(rst_clean),
        .btns(16'd0),
        .writeData(32'd0),
        .writeEnable(1'b0),
        .readEnable(1'b1),
        .memAddress(30'd0),
        .switches(physical_sw),
        .readData(sw_read_data)
    );

    //Switch mapping
    wire [3:0] A_in     = sw_read_data[3:0];
    wire [3:0] B_in     = sw_read_data[7:4];
    wire [3:0] alu_ctrl = sw_read_data[15:12];

    wire        mem_rd_mode = sw_read_data[8];
    wire        mem_store   = sw_read_data[9];
    wire [31:0] mem_addr    = {30'd0, sw_read_data[11:10]};

    //Register file / ALU
    reg         rf_we;
    reg  [4:0]  rf_rd;
    reg  [31:0] rf_write_data;
    wire [31:0] rf_read_data1, rf_read_data2;
    wire [31:0] alu_result;
    wire        alu_zero;

    reg state;   

    RegisterFile u_rf (
        .clk(clk),
        .rst(rst_clean),
        .WriteEnable(rf_we),
        .rs1(5'd1),              // read x1
        .rs2(5'd2),              // read x2
        .rd(rf_rd),
        .WriteData(rf_write_data),
        .ReadData1(rf_read_data1),
        .readData2(rf_read_data2)
    );

    ALU_32bit u_alu (
        .A(rf_read_data1),
        .B(rf_read_data2),
        .ALUControl(alu_ctrl),
        .ALUResult(alu_result),
        .Zero(alu_zero)
    );

    wire [31:0] dec_read_data;

    addressDecoderTop u_adt (
        .clk(clk),
        .rst(rst_clean),
        .address(mem_addr),
        .readEnable(mem_rd_mode),
        .writeEnable(mem_store),
        .writeData(alu_result),
        .switches(sw_read_data[15:0]),
        .readData(dec_read_data),
        .leds()
    );

    always @(posedge clk or posedge rst_clean) begin
        if (rst_clean) begin
            state          <= 1'b0;
            rf_we          <= 1'b0;
            rf_rd          <= 5'd0;
            rf_write_data  <= 32'd0;
            led_write_data <= 32'd0;
        end else begin
            rf_we <= 1'b1;
            case (state)
                1'b0: begin
                    rf_rd         <= 5'd1;
                    rf_write_data <= {28'd0, A_in};
                    state         <= 1'b1;
                end
                1'b1: begin
                    rf_rd         <= 5'd2;
                    rf_write_data <= {28'd0, B_in};
                    state         <= 1'b0;
                end
            endcase
            if (mem_rd_mode)
                led_write_data <= {16'd0, dec_read_data[15:0]};
            else
                led_write_data <= {16'd0, alu_result[15:0]};
        end
    end
endmodule