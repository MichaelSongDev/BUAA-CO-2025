`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:46:11 10/19/2025
// Design Name:   expr
// Module Name:   D:/co/p1/expr/expr_tb.v
// Project Name:  expr
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: expr
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module expr_tb;

	// Inputs
	reg clk;
	reg clr;
	reg [7:0] in;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	expr uut (
		.clk(clk), 
		.clr(clr), 
		.in(in), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;
		in = 0;

		// Wait 100 ns for global reset to finish
		#100;
		in = "1";
		clk = 1;

		#100
		clk = 0;

		#100
		in = "+";
		clk = 1;

		#100
		clk = 0;

		#100
		in = "2";
		clk = 1;

		#100
		clk = 0;

		#100
		in = "*";
		clk = 1;

		#100
		clk = 0;

		#100
		in = "3";
		clk = 1;
        
		// Add stimulus here

	end
      
endmodule

