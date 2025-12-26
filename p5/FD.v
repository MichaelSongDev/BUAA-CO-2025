`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:05:02 11/26/2025 
// Design Name: 
// Module Name:    FD 
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
module FD(
    input clk,
    input reset,
    input FD_en,
    input FD_reset,
    input [31:0] F_Instr,
    input [31:0] F_PC,
    input [31:0] F_PCplus8,
    output reg [31:0] D_Instr,
    output reg [31:0] D_PC,
    output reg [31:0] D_PCplus8
    );

    always @(posedge clk) begin
        if(reset | FD_reset) begin
            D_Instr <= 32'b0;
            D_PC <= 32'b0;
            D_PCplus8 <= 32'b0;
        end
        else begin
            if(FD_en) begin
                D_Instr <= F_Instr;
                D_PC <= F_PC;
                D_PCplus8 <= F_PCplus8;
            end
        end
    end


endmodule
