`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Muddassir Ali

// Module Name: top_fsm_system
// Project Name: ALU
// Target Devices: Baasys 3
// 
//////////////////////////////////////////////////////////////////////////////////

module top_fsm_system (
    input wire clk,
    input wire pbin,
    input wire [15:0] physical_sw,
    output wire [15:0] physical_leds
);

    // DEBOUNCER (Cleans up the physical reset button signal)
    wire rst_clean;
  	wire [31:0] switch_data; // hold the value read from the switches
  	reg [31:0] led_write_data = 32'd0; // counter value here
  
    debouncer rst_db (
      			.clk(clk),
        		.pbin(pbin), 
      			.pbout(rst_clean)	//generated a clean signal
    ); 

    
    
    leds switch_reader (
      			.clk(clk), .rst(rst_clean),
                    .btns(16'd0),			// Not used for this FSM
                    .writeData(32'd0),			// We don't write to switches
                    .writeEnable(1'b0),			// Disabled
                    .readEnable(1'b1),			// Always ON so we can monitor switches
                    .memAddress(30'd0),       
                    .switches(physical_sw),		// Plug in the physical switches
                    .readData(switch_data)		// output data 
    );
    
    switches led_writer (
                    .clk(clk), .rst(rst_clean),
                    .writeData(led_write_data),
                    .writeEnable(1'b1),         	// Always ON so LEDs update instantly
                    .readEnable(1'b0), .memAddress(30'd0),
                    .readData(),                	// Ignored
                    .leds(physical_leds)      
    );
    
    // ALU Signals
    wire [31:0] alu_result;
    wire        alu_zero;
    reg  [3:0]  alu_ctrl_reg;

    // Fixed Operands
    localparam [31:0] OPERAND_A = 32'h10101010;
    localparam [31:0] OPERAND_B = 32'h01010101;
    
    // Instantiate the 32-bit ALU
    ALU_32bit u_alu (
        .A(OPERAND_A),
        .B(OPERAND_B),
        .ALUControl(alu_ctrl_reg),
        .ALUResult(alu_result),
        .Zero(alu_zero)
    );

	// YOUR CODE HERE
	localparam STATE_IDLE    = 2'b00;
    localparam STATE_READ_SW = 2'b01;
    localparam STATE_DISPLAY = 2'b10;

    reg [1:0] state = STATE_IDLE;

    always @(posedge clk or posedge rst_clean) begin
        if (rst_clean) begin
            state          <= STATE_IDLE;
            alu_ctrl_reg   <= 4'b0000;
            led_write_data <= 32'd0;
        end else begin
            case (state)
                STATE_IDLE: begin
                    alu_ctrl_reg   <= 4'b0000;
                    led_write_data <= 32'd0;
                    state          <= STATE_READ_SW;
                end
                
                STATE_READ_SW: begin
                    alu_ctrl_reg   <= switch_data[3:0];
                    state          <= STATE_DISPLAY;
                end
                
                STATE_DISPLAY: begin
                    led_write_data <= {16'd0, alu_result[15:0]};
                    state          <= STATE_READ_SW; 
                end
                
                default: begin
                    state          <= STATE_IDLE;
                end
            endcase
        end
    end
    endmodule
