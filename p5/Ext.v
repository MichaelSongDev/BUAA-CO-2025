`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:08:47 11/13/2025 
// Design Name: 
// Module Name:    Ext 
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
module Ext(
    input [15:0] imm16,
    input Op,
    output [31:0] imm32
    );

    assign imm32 = (Op == 1'b0) ? {16'h0000, imm16} : {{16{imm16[15]}}, imm16};


endmodule
