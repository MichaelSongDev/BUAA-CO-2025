`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:14:07 11/13/2025 
// Design Name: 
// Module Name:    ImmExt 
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
module ImmExt(
    input [31:0] Instr,
    input Op,
    output [31:0] imm32,
    output [15:0] imm16
    );

    assign imm16 = Instr[15:0];

    Ext ext(.imm16(imm16),
            .Op(Op),
            .imm32(imm32));


endmodule
