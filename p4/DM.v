`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:29:02 11/13/2025 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input [31:0] Addr,
    input [31:0] WD,
    input clk,
    input reset,
    input WE,
    input [31:0] PC,
    output [31:0] Data
    );

    reg [31:0] RAM [0:3071];
    wire [31:0] RAMAddr;
    integer i;

    assign RAMAddr = (Addr >> 2);

    always @(posedge clk) begin
        if(reset) begin
            for(i = 0; i < 3072; i = i + 1) begin
                RAM[i] <= 23'h00000000;
            end
        end
        else begin
            if(WE) begin
                RAM[RAMAddr] <= WD;
                $display("@%h: *%h <= %h", PC, Addr, WD);
            end
        end
    end

    assign Data = RAM[RAMAddr];


endmodule
