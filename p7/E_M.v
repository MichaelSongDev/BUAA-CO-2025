`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:05:15 11/26/2025 
// Design Name: 
// Module Name:    EM 
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
module E_M(
    input clk,
    input reset,
    input EM_en,
    input EM_reset,
    input Req,
    input [31:0] E_Instr,
    input [31:0] E_PC,
    input [31:0] E_PCplus8,
    input [31:0] E_ALUOut,
    input [31:0] E_RD2,
    input [4:0] E_A3,
    input [4:0] E_ExcCode,
    input E_BD,
    output reg [31:0] M_Instr,
    output reg [31:0] M_PC,
    output reg [31:0] M_PCplus8,
    output reg [31:0] M_ALUOut,
    output reg [31:0] M_RD2,
    output reg [4:0] M_A3,
    output reg [4:0] M_ExcCode,
    output reg M_BD
    );

    always @(posedge clk) begin
        if(reset | EM_reset | Req) begin
            M_Instr <= 32'b0;
            M_PC <= reset ? 32'b0 : Req ? 32'h00004180 : E_PC;
            M_PCplus8 <= 32'b0;
            M_ALUOut <= 32'b0;
            M_RD2 <= 32'b0;
            M_A3 <= 32'b0;
            M_BD <= reset ? 1'b0 : Req ? 1'b0 : E_BD;
            M_ExcCode <= 5'b0;
        end
        else begin
            if(EM_en) begin
                M_Instr <= E_Instr;
                M_PC <= E_PC;
                M_PCplus8 <= E_PCplus8;
                M_ALUOut <= E_ALUOut;
                M_RD2 <= E_RD2;
                M_A3 <= E_A3;
                M_BD <= E_BD;
                M_ExcCode <= E_ExcCode;
            end
        end
    end


endmodule
