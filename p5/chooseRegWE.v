`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:55:00 11/13/2025 
// Design Name: 
// Module Name:    RegWE 
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
module chooseRegWE(
    input Controller_RegWE,
    input [4:0] Rs,
    input[4:0] Rt,
    input [4:0] Rd,
    input [4:0] Shamt,
    input [5:0] type,
    output WE
    );

    assign WE = (Controller_RegWE && (!((Rt == 5'b0) && (Rd == 5'b0) && (Shamt == 5'b0) && (type == 6'hf))));


endmodule
