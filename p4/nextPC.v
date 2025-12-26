`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:44:23 11/12/2025 
// Design Name: 
// Module Name:    nextPC 
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
module nextPC(
    input [31:0] PC,
    input [31:0] GRF,
    input [25:0] imm26,
    input [15:0] imm16,
    input zero,
    input [1:0] nextPC_Sel,
    output [31:0] nextPC
    );

    parameter PCPLUS4 = 2'b00,
              GRFAddr = 2'b01,
              IMM26 = 2'b10,
              IMM16 = 2'b11;

    wire [31:0] pcplus4;
    wire [31:0] grf;
    wire [31:0] imm26addr;
    wire [31:0] imm16addr;
    wire [31:0] signext;

    assign pcplus4 = PC + 32'h00000004;
    assign grf = GRF;
    assign imm26addr = {PC[31:28], imm26, 2'b00};
    assign signext = {{14{imm16[15]}}, imm16, 2'b00};
    assign imm16addr = pcplus4 + signext;
    
    assign nextPC = (nextPC_Sel == PCPLUS4) ? pcplus4 :
                    (nextPC_Sel == GRFAddr) ? grf :
                    (nextPC_Sel == IMM26) ? imm26addr :
                    (zero == 1'b0) ? pcplus4 :  imm16addr;

endmodule
