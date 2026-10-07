`timescale 1ns / 1ps

module ALU_1bit (
    input  wire       a,
    input  wire       b,
    input  wire       cin,       
    input  wire       b_invert,  
    input  wire [1:0] op,        // 00: AND, 01: OR, 10: ADD/SUB, 11: XOR
    output wire       result,
    output wire       cout       
);

    wire b_mux;
    wire and_res, or_res, xor_res, add_res;

    // 2:1 MUX for Operand B inversion (for SUB)
    assign b_mux = b_invert ? ~b : b;

    // Logic Operations
    assign and_res = a & b_mux;
    assign or_res  = a | b_mux;
    assign xor_res = a ^ b_mux;

    // Full Adder Logic for ADD/SUB
    assign add_res = a ^ b_mux ^ cin;
    assign cout    = (a & b_mux) | (cin & (a ^ b_mux));

    // 4:1 MUX for Output Selection
    assign result = (op == 2'b00) ? and_res :
                    (op == 2'b01) ? or_res  :
                    (op == 2'b10) ? add_res :
                                    xor_res ;

endmodule
