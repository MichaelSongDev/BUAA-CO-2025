`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:53:50 10/18/2025 
// Design Name: 
// Module Name:    ext 
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
module ext(
    input [15:0] imm,
    input [1:0] EOp,
    output [31:0] ext
    );

    assign ext = (EOp == 2'd0) ? {{16{imm[15]}}, imm} :
                 (EOp == 2'd1) ? {16'b0, imm} :
                 (EOp == 2'd2) ? {imm, 16'b0} :
                 {{14{imm[15]}}, imm, 2'b0};

endmodule
