`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:19:45 10/21/2025 
// Design Name: 
// Module Name:    CNNX 
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
module CNNX(
    input [35:0] a,
    input [8:0] b,
    output reg [15:0] ans
    );

    integer i, j, k, l;

    always @(*) begin
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                ans[i*4+j] = 0;
                for (k = 0; k < 3; k = k + 1) begin
                    for (l = 0; l < 3; l = l + 1) begin
                        ans[i*4+j] = ans[i*4+j] ^ (a[(i+k)*6+j+l] & b[k*3+l]);
                    end
                end 
            end
        end
    end

endmodule
