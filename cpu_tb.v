`include "const.h"

module test;

parameter MemAddrSize = `DefaultMemAndIOAddrSize;
parameter ProgAddrSize = `DefaultProgAddrSize;
parameter WordSize = `DefaultWordSize;

reg [WordSize-1:0] inM;
reg [WordSize-1:0] instruction;
reg reset;
wire [WordSize-1:0] outM;
wire writeM;
wire [MemAddrSize-1:0] addressM;
wire [ProgAddrSize-1:0] progCounter;

reg clk;

cpu DUT (inM, instruction, reset, outM, writeM, addressM, progCounter, clk);

always
	#(`ClockPulseWidth) clk = ~clk;

initial begin
	$monitor("At time %t, clk = %d, inM = %d, instruction = %b, reset = %d, outM = %d, writeM = %d, addressM = %d, progCounter = %d",
			$time, clk, inM, instruction, reset,
			outM, writeM, addressM, progCounter);

	clk <= 1;

	inM <= 0; instruction <= 0; reset <= 0;

	@(negedge clk)	reset <= 1;
	@(negedge clk)	reset <= 0;

	@(negedge clk)	#(4*`ClockPulseWidth)	$finish;
end

endmodule
