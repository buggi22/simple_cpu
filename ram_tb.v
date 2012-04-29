`include "const.h"

module test;

wire [`DefaultWordSize-1:0] value;
reg [`DefaultWordSize-1:0] in;
reg [`DefaultAddrSize-1:0] address;
reg load;

reg clk;

ram DUT (in, address, load, value, clk);

always
	#(`ClockPulseWidth) clk = ~clk;

initial begin
	$monitor("At time %t, clk = %d, in = %d, address = %d, load = %d ==> value = %d",
			$time, clk, in, address, load, value);

	clk <= 1;
	in <= 0; load <= 0; address <= 0;

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
	@(negedge clk)	#(2*`ClockPulseWidth)	$finish;
end

endmodule
