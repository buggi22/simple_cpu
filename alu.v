// alu ported from TECS book project

`include "const.h"

module alu(out, zr, ng, x, y, zx, nx, zy, ny, f, no);

	parameter WordSize = `DefaultWordSize;

	input [WordSize-1:0]x;
	input [WordSize-1:0]y;
	input zx, nx, zy, ny, f, no;
	output [WordSize-1:0]out;
	output zr, ng;

	wire [WordSize-1:0]ax;
	wire [WordSize-1:0]bx;
	wire [WordSize-1:0]ay;
	wire [WordSize-1:0]by;
	wire [WordSize-1:0]result_f;

	assign ax = zx ? {WordSize{1'b0}} : x;
	assign bx = nx ? ~ax : ax;
	 
	assign ay = zy ? {WordSize{1'b0}} : y;
	assign by = ny ? ~ay : ay;
	 
	assign result_f = f ? bx + by : bx & by;
	assign out = no ? ~result_f : result_f;
	 
	assign ng = out[WordSize-1];
	assign zr = ~|out;  // using unary reduction OR

endmodule
