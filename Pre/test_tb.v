`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:41:08 09/11/2025
// Design Name:   a2
// Module Name:   D:/verilog/pre_proj_test/test_tb.v
// Project Name:  pre_proj_test
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: a2
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_tb;

	// Inputs
	reg [31:0] cnt, ans1, ans2;

	always #10 cnt = cnt + 1;

	initial begin
		cnt = 0;
		ans1 = 0;
		ans2 = 0;
		#15
		ans1 = cnt;
		#10
		ans2 = cnt;
	end
      
endmodule

