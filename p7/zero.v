`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:03 11/26/2025 
// Design Name: 
// Module Name:    zero 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module zero(
    input [31:0] in1,
    input [31:0] in2,
    input [5:0] type,
    output zero
    );

    parameter BEQ   = 6'b001000,
              BNE   = 6'b001001;

    wire beq;
    wire bne;

    assign beq = (in1 == in2);
    assign bne = (in1 != in2);

    assign zero = (type == BEQ) ? beq :
                (type == BNE) ? bne :
                1'b0;

endmodule
