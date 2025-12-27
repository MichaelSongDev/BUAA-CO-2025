`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:17:02 09/18/2025 
// Design Name: 
// Module Name:    sales 
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
module sales(
    input clk,
    input rst,
    input [31:0] price,
    input [31:0] num,
    output [31:0] avg
    );

    reg [31:0] amount;
    reg [31:0] total_num;
    reg [31:0] product;


    // always @(posedge rst) begin
    //     amount <= 32'd0;
    //     total_num <= 32'd0;
        
    // end

    always @(posedge clk) begin
        if(rst) begin
          total_num <= 32'd0;
          amount <= 32'd0;
        end
        else begin  
            total_num <= total_num + num;
            product <= num * price;
            amount <= amount + product;
        end
    end

    assign avg = (total_num == 0) ? 32'd0 : amount / total_num;


endmodule
