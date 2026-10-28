`timescale 1ns / 1ps
module top_level_control(
    input wire clk,
    input wire rst_btn,       
    input wire [15:0] sw,     
    output wire [15:0] led_out 
);
    wire rst;
    wire [31:0] switch_data, led_write_data;
    wire RegWrite, MemRead, MemWrite, ALUSrc, MemtoReg, Branch;
    wire [1:0] ALUOp;
    wire [3:0] ALUControl_out;
    
    debouncer db_rst (.clk(clk), .pbin(rst_btn), .pbout(rst));
    
    leds switch_reader (
        .clk(clk), .rst(rst), .btns(16'd0), .writeData(32'd0),       
        .writeEnable(1'b0), .readEnable(1'b1), .memAddress(30'd0),
        .switches(sw), .readData(switch_data)   
    );
    
    switches led_driver (
        .clk(clk), .rst(rst), .writeData(led_write_data),
        .writeEnable(1'b1),
        .readEnable(1'b0), .memAddress(30'd0),
        .readData(), .leds(led_out)           
    );
    
    // Decode main control signals from opcode (sw[6:0])
    MainControl mc (
        .opcode(switch_data[6:0]),
        .RegWrite(RegWrite), .ALUOp(ALUOp), .MemRead(MemRead),
        .MemWrite(MemWrite), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .Branch(Branch)
    );

    // Decode ALU control using ALUOp, funct3 (sw[9:7]), and funct7[5] (sw[10])
    ALUControl ac (
        .ALUOp(ALUOp),
        .funct3(switch_data[9:7]),
        .funct7({1'b0, switch_data[10], 5'b00000}), 
        .ALUControl(ALUControl_out)
    );
    
    // FSM State Variables
    reg state, next_state;
    localparam STATE_READ = 1'b0, STATE_DISPLAY = 1'b1;

    // FSM State Register
    always @(posedge clk or posedge rst) begin
        if (rst) state <= STATE_READ;
        else begin
            case(state)
                STATE_READ: next_state = STATE_DISPLAY;    // Automatically move to display state
                STATE_DISPLAY: next_state = STATE_DISPLAY; // Hold same state until reset
                default: next_state = STATE_READ;
            endcase
        end 
    end

    // Pack control signals for LEDs
    assign led_write_data = {
        20'd0, ALUControl_out[3:0], ALUOp[1:0], 
        Branch, MemtoReg, MemWrite, MemRead, ALUSrc, RegWrite
    };
endmodule