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
module F_D(
    input clk,
    input reset,
    input FD_en,
    input FD_reset,
    input Req,
    input [31:0] F_Instr,
    input [31:0] F_PC,
    input [31:0] F_PCplus8,
    input [4:0] F_ExcCode,
    input F_BD,
    output reg [31:0] D_Instr,
    output reg [31:0] D_PC,
    output reg [31:0] D_PCplus8,
    output reg [4:0] D_ExcCode,
    output reg D_BD
    );

    always @(posedge clk) begin
        if(reset | FD_reset | Req) begin
            D_Instr <= 32'b0;
            D_PC <= reset ? 32'b0 : Req ? 32'h00004180 : F_PC;
            D_PCplus8 <= 32'b0;
            D_ExcCode <= 5'b0;
            D_BD <= reset ? 1'b0 : Req ? 1'b0 : F_BD;
        end
        else begin
            if(FD_en) begin
                D_Instr <= F_Instr;
                D_PC <= F_PC;
                D_PCplus8 <= F_PCplus8;
                D_ExcCode <= F_ExcCode;
                D_BD <= F_BD;
            end
        end
    end


endmodule
