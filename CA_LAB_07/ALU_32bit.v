`timescale 1ns / 1ps

module ALU_32bit (
    input  wire [31:0] A,
    input  wire [31:0] B,
    input  wire [3:0]  ALUControl,
    output wire [31:0] ALUResult,
    output wire        Zero
);

    // ALU Control Encodings
    localparam ALU_AND = 4'b0000;
    localparam ALU_OR  = 4'b0001;
    localparam ALU_ADD = 4'b0010;
    localparam ALU_XOR = 4'b0011;
    localparam ALU_SLL = 4'b0100;
    localparam ALU_SRL = 4'b0101;
    localparam ALU_SUB = 4'b0110;

    // Internal Control Signals for the 1-bit slices
    reg        b_invert;
    reg  [1:0] slice_op;
    
    // Wires for cascading and routing
    wire [31:0] carry;
    wire [31:0] cascade_result;
    reg  [31:0] final_result;

    // Decode ALUControl
    always @(*) begin
        case (ALUControl)
            ALU_AND: begin b_invert = 1'b0; slice_op = 2'b00; end
            ALU_OR:  begin b_invert = 1'b0; slice_op = 2'b01; end
            ALU_ADD: begin b_invert = 1'b0; slice_op = 2'b10; end
            ALU_XOR: begin b_invert = 1'b0; slice_op = 2'b11; end
            ALU_SUB: begin b_invert = 1'b1; slice_op = 2'b10; end // Subtract sets invert to 1
            default: begin b_invert = 1'b0; slice_op = 2'b00; end 
        endcase
    end

    // Manual Cascaded Instantiation of 32 Slices
    ALU_1bit s0  (.a(A[0]),  .b(B[0]),  .cin(b_invert), .b_invert(b_invert), .op(slice_op), .result(cascade_result[0]),  .cout(carry[0]));
    ALU_1bit s1  (.a(A[1]),  .b(B[1]),  .cin(carry[0]),  .b_invert(b_invert), .op(slice_op), .result(cascade_result[1]),  .cout(carry[1]));
    ALU_1bit s2  (.a(A[2]),  .b(B[2]),  .cin(carry[1]),  .b_invert(b_invert), .op(slice_op), .result(cascade_result[2]),  .cout(carry[2]));
    ALU_1bit s3  (.a(A[3]),  .b(B[3]),  .cin(carry[2]),  .b_invert(b_invert), .op(slice_op), .result(cascade_result[3]),  .cout(carry[3]));
    ALU_1bit s4  (.a(A[4]),  .b(B[4]),  .cin(carry[3]),  .b_invert(b_invert), .op(slice_op), .result(cascade_result[4]),  .cout(carry[4]));
    ALU_1bit s5  (.a(A[5]),  .b(B[5]),  .cin(carry[4]),  .b_invert(b_invert), .op(slice_op), .result(cascade_result[5]),  .cout(carry[5]));
    ALU_1bit s6  (.a(A[6]),  .b(B[6]),  .cin(carry[5]),  .b_invert(b_invert), .op(slice_op), .result(cascade_result[6]),  .cout(carry[6]));
    ALU_1bit s7  (.a(A[7]),  .b(B[7]),  .cin(carry[6]),  .b_invert(b_invert), .op(slice_op), .result(cascade_result[7]),  .cout(carry[7]));
    ALU_1bit s8  (.a(A[8]),  .b(B[8]),  .cin(carry[7]),  .b_invert(b_invert), .op(slice_op), .result(cascade_result[8]),  .cout(carry[8]));
    ALU_1bit s9  (.a(A[9]),  .b(B[9]),  .cin(carry[8]),  .b_invert(b_invert), .op(slice_op), .result(cascade_result[9]),  .cout(carry[9]));
    ALU_1bit s10 (.a(A[10]), .b(B[10]), .cin(carry[9]),  .b_invert(b_invert), .op(slice_op), .result(cascade_result[10]), .cout(carry[10]));
    ALU_1bit s11 (.a(A[11]), .b(B[11]), .cin(carry[10]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[11]), .cout(carry[11]));
    ALU_1bit s12 (.a(A[12]), .b(B[12]), .cin(carry[11]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[12]), .cout(carry[12]));
    ALU_1bit s13 (.a(A[13]), .b(B[13]), .cin(carry[12]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[13]), .cout(carry[13]));
    ALU_1bit s14 (.a(A[14]), .b(B[14]), .cin(carry[13]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[14]), .cout(carry[14]));
    ALU_1bit s15 (.a(A[15]), .b(B[15]), .cin(carry[14]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[15]), .cout(carry[15]));
    ALU_1bit s16 (.a(A[16]), .b(B[16]), .cin(carry[15]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[16]), .cout(carry[16]));
    ALU_1bit s17 (.a(A[17]), .b(B[17]), .cin(carry[16]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[17]), .cout(carry[17]));
    ALU_1bit s18 (.a(A[18]), .b(B[18]), .cin(carry[17]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[18]), .cout(carry[18]));
    ALU_1bit s19 (.a(A[19]), .b(B[19]), .cin(carry[18]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[19]), .cout(carry[19]));
    ALU_1bit s20 (.a(A[20]), .b(B[20]), .cin(carry[19]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[20]), .cout(carry[20]));
    ALU_1bit s21 (.a(A[21]), .b(B[21]), .cin(carry[20]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[21]), .cout(carry[21]));
    ALU_1bit s22 (.a(A[22]), .b(B[22]), .cin(carry[21]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[22]), .cout(carry[22]));
    ALU_1bit s23 (.a(A[23]), .b(B[23]), .cin(carry[22]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[23]), .cout(carry[23]));
    ALU_1bit s24 (.a(A[24]), .b(B[24]), .cin(carry[23]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[24]), .cout(carry[24]));
    ALU_1bit s25 (.a(A[25]), .b(B[25]), .cin(carry[24]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[25]), .cout(carry[25]));
    ALU_1bit s26 (.a(A[26]), .b(B[26]), .cin(carry[25]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[26]), .cout(carry[26]));
    ALU_1bit s27 (.a(A[27]), .b(B[27]), .cin(carry[26]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[27]), .cout(carry[27]));
    ALU_1bit s28 (.a(A[28]), .b(B[28]), .cin(carry[27]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[28]), .cout(carry[28]));
    ALU_1bit s29 (.a(A[29]), .b(B[29]), .cin(carry[28]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[29]), .cout(carry[29]));
    ALU_1bit s30 (.a(A[30]), .b(B[30]), .cin(carry[29]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[30]), .cout(carry[30]));
    ALU_1bit s31 (.a(A[31]), .b(B[31]), .cin(carry[30]), .b_invert(b_invert), .op(slice_op), .result(cascade_result[31]), .cout(carry[31]));

    // Choose between ALU or shifter
    always @(*) begin
        case (ALUControl)
            ALU_SLL: final_result = A << B[4:0];    // Shift Left
            ALU_SRL: final_result = A >> B[4:0];    // Shift Right
            default: final_result = cascade_result; // Arithmetic and Logic
        endcase
    end

    // Assign outputs
    assign ALUResult = final_result;
    assign Zero = (final_result == 32'h00000000);

endmodule