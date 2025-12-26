`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:02:35 11/13/2025 
// Design Name: 
// Module Name:    IFU 
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
module IFU(
    input [31:0] GRF,
    input [25:0] imm26,
    input [15:0] imm16,
    input [1:0] select,
    input zero,
    input clk,
    input reset,
    output [31:0] Instr,
    output [31:0] PC,
    output [31:0] PCplus4
    );

    wire [31:0] nextPC;

    pc ProgramCounter(.clk(clk),
          .reset(reset),
          .nextPC(nextPC),
          .PC(PC));

    nextPC nPC(.PC(PC),
               .GRF(GRF),
               .imm26(imm26),
               .imm16(imm16),
               .zero(zero),
               .nextPC_Sel(select),
               .nextPC(nextPC));
            
    IM im(.PC(PC),
          .Instr(Instr));

    assign PCplus4 = PC + 32'h00000004;

endmodule
