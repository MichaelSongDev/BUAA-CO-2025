`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:56:33 11/26/2025 
// Design Name: 
// Module Name:    MW 
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
module MW(
    input clk,
    input reset,
    input MW_en,
    input MW_reset,
    input [31:0] M_Instr,
    input [31:0] M_PC,
    input [31:0] M_PCplus8,
    input [4:0] M_A3,
    input [31:0] M_ALUOut,
    input [31:0] M_DMData,
    output reg [31:0] W_Instr,
    output reg [31:0] W_PC,
    output reg [31:0] W_PCplus8,
    output reg [4:0] W_A3,
    output reg [31:0] W_ALUOut,
    output reg [31:0] W_DMData
    );

    always @(posedge clk) begin
        if(reset | MW_reset) begin
            W_Instr <= 32'b0;
            W_PC <= 32'b0;
            W_PCplus8 <= 32'b0;
            W_A3 <= 32'b0;
            W_ALUOut <= 32'b0;
            W_DMData <= 32'b0;
        end
        else begin
            if(MW_en) begin
                W_Instr <= M_Instr;
                W_PC <= M_PC;
                W_PCplus8 <= M_PCplus8;
                W_A3 <= M_A3;
                W_ALUOut <= M_ALUOut;
                W_DMData <= M_DMData;
            end
        end
    end


endmodule
