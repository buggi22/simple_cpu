`include "const.h"

`define TestCycles 20

module test;

reg reset;
reg clk;

computer #(`DefaultMemAndIOAddrSize, `DefaultProgAddrSize, `DefaultWordSize)
	DUT (reset, clk);

always
	#(`ClockPulseWidth) clk = ~clk;

initial begin
	$monitor("At time %t, clk = %d, progCounter = %d, instruction = %b",
			$time, clk, DUT.progCounter, DUT.instruction);

	#(2 * `ClockPulseWidth)
	DUT.ROM.mem[3] = 16'b0000_0000_0000_0001;
	DUT.ROM.mem[4] = 16'b1110_0000_0000_0111;

	clk <= 1;

	reset <= 0;

	@(negedge clk)	reset <= 1;
	@(negedge clk)	reset <= 0;

	@(negedge clk)	#(2*(`TestCycles+1)*`ClockPulseWidth)	$finish;
end

endmodule
