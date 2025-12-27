`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:39:50 09/18/2025
// Design Name:   sales
// Module Name:   D:/verilog/seq_circ_exer3/sales_tb.v
// Project Name:  seq_circ_exer3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: sales
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sales_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [31:0] price;
	reg [31:0] num;

	// Outputs
	wire [31:0] avg;

	// Instantiate the Unit Under Test (UUT)
	sales uut (
		.clk(clk), 
		.rst(rst), 
		.price(price), 
		.num(num), 
		.avg(avg)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		price = 0;
		num = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 1;
		clk = 1;

		#100;
		rst = 0;
		clk = 0;

		#100
		clk = 1;
		price = 32'd1;
		num = 32'd2;

		#100;
		clk=0;

		#100;
		clk = 1;
		price = 32'd2;
		num = 32'd1;

		#100;
		clk = 0;

		#100;
		clk = 1;
		price = 32'd3;
		num = 32'd3;
        
		#100;
		rst = 1;
		// Add stimulus here

	end
      
endmodule

