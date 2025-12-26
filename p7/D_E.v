`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:27:56 11/26/2025 
// Design Name: 
// Module Name:    DE 
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
module D_E(
    input clk,
    input reset,
    input DE_en,
    input DE_reset,
    input Req,
    input [31:0] D_Instr,
    input [31:0] D_PC,
    input [31:0] D_PCplus8,
    input [31:0] D_RD1,
    input [31:0] D_RD2,
    input [4:0] D_A3,
    input [31:0] D_imm32,
    input [4:0] D_ExcCode,
    input D_BD,
    output reg [31:0] E_Instr,
    output reg [31:0] E_PC,
    output reg [31:0] E_PCplus8,
    output reg [31:0] E_RD1,
    output reg [31:0] E_RD2,
    output reg [4:0] E_A3,
    output reg [31:0] E_imm32,
    output reg [4:0] E_ExcCode,
    output reg E_BD
    );

    always @(posedge clk) begin
        if(reset | DE_reset | Req) begin
            E_Instr <= 32'b0;
            E_PC <= reset ? 32'b0 : Req ? 32'h00004180 : D_PC;
            E_PCplus8 <= 32'b0;
            E_RD1 <= 32'b0;
            E_RD2 <= 32'b0;
            E_A3 <= 32'b0;
            E_imm32 <= 32'b0;
            E_ExcCode <= 5'b0;
            E_BD <= reset ? 1'b0 : Req ? 1'b0 : D_BD;
        end
        else begin
            if(DE_en) begin
                E_Instr <= D_Instr;
                E_PC <= D_PC;
                E_PCplus8 <= D_PCplus8;
                E_RD1 <= D_RD1;
                E_RD2 <= D_RD2;
                E_A3 <= D_A3;
                E_imm32 <= D_imm32;
                E_ExcCode <= D_ExcCode;
                E_BD <= D_BD;
            end
        end
    end


endmodule
