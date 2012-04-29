`include "const.h"

module test;

parameter MemAddrSize = `DefaultAddrSize;
parameter MemAndIOAddrSize = `DefaultAddrSize + 1;
parameter ProgAddrSize = `DefaultProgAddrSize;
parameter WordSize = `DefaultWordSize;

reg [WordSize-1:0] inM;
reg [WordSize-1:0] instruction;
reg reset;
wire [WordSize-1:0] outM;
wire writeM;
wire [MemAndIOAddrSize-1:0] addressM;
wire [ProgAddrSize-1:0] pc;

reg clk;

cpu DUT (inM, instruction, reset, outM, writeM, addressM, pc, clk);

always
	#(`ClockPulseWidth) clk = ~clk;

initial begin
	$monitor("At time %t, clk = %d, in = %d, address = %d, load = %d ==> value = %d",
			$time, clk, in, address, load, value);

	clk <= 1;
	in <= 0; load <= 0; address <= 0;
/*
	@(negedge clk)	load <= 0;
	@(negedge clk)	begin
		in <= 3; load <= 1;
	end
	@(negedge clk)	load <= 0;
	@(negedge clk)	in <= 2;
	@(negedge clk)	load <= 1;
	@(negedge clk)	load <= 0;
	@(negedge clk)	address <= 1;
	@(negedge clk)	load <= 1;
	@(negedge clk)	load <= 0;
	@(negedge clk)	address <= 0;
	@(negedge clk)	in <= 7;
	@(negedge clk)	load <= 1;
	@(negedge clk)	load <= 0;
*/	@(negedge clk)	#(2*`ClockPulseWidth)	$finish;
end

endmodule
