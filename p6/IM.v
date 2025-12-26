`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:38:54 11/12/2025 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [31:0] PC,
    output [31:0] Instr
    );

    reg [31:0] ROM [0:4095];
    wire [31:0] addr;

initial begin
    $readmemh("code.txt", ROM, 0, 4095);
end

    assign addr = ((PC - 32'h00003000) >> 2);
    assign Instr = ROM[addr];


endmodule
