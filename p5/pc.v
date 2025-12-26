`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:33:55 11/12/2025 
// Design Name: 
// Module Name:    pc 
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
module pc(
    input clk,
    input reset,
    input PC_en,
    input [31:0] nextPC,
    output [31:0] PC
    );

    reg [31:0] PCReg;

    always @(posedge clk) begin
        if (reset) begin
            PCReg <= 32'h00003000;
        end
        else begin
            if (PC_en) begin
                PCReg <= nextPC;
            end
        end
    end

    assign PC = PCReg;

endmodule
