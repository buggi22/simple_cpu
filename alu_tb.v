// test bench for arithmetic logic unit (alu)

//  to compile and run:
//   $ iverilog alu_tb.v alu.v -o alu_tb
//   $ vvp alu_tb

`timescale 1ns / 100ps

module test_alu;
	wire [15:0]result;
	wire zr, ng;

	reg [15:0]a;
	reg [15:0]b;
	reg zx, nx, zy, ny, f, no;

	reg clk;

	alu DUT(result, zr, ng, a, b, zx, nx, zy, ny, f, no);   // define DUT (device under test)

	always
		#10 clk = ~clk;

	initial begin
		$timeformat(-9, 1, " ns", 6);

		clk = 1'b0;

		@(negedge clk) a = 16'h00AA; b = 16'h0AA0; zx = 0; nx = 0; zy = 0; ny = 0; f = 0; no = 0;
		@(negedge clk) a = 16'h00A0; b = 16'hA000; zx = 0; nx = 0; zy = 0; ny = 0; f = 0; no = 0;
		@(negedge clk) a = 16'h00A0; b = 16'hA000; zx = 0; nx = 0; zy = 0; ny = 0; f = 1; no = 0;
		@(negedge clk) a = 16'h0007; b = 16'h0005; zx = 0; nx = 0; zy = 0; ny = 0; f = 0; no = 0;
		@(negedge clk) a = 16'h0007; b = 16'h0005; zx = 0; nx = 0; zy = 0; ny = 0; f = 1; no = 0;

		@(negedge clk)
		$finish;

	end // initial

	always @(*)
		#1 $display("At t=%t, a=%h, b=%h, zx=%h, nx=%h, zy=%h, ny=%h, f=%h, no=%h, result=%h, zr=%h, ng=%h",
			$time, a, b, zx, nx, zy, ny, f, no, result, zr, ng);

endmodule
