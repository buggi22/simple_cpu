`include "const.h"

module cpu(inM, instruction, reset, outM, writeM, addressM, progCounter, clk);

parameter MemAddrSize = `DefaultMemAndIOAddrSize;
parameter ProgAddrSize = `DefaultProgAddrSize;
parameter WordSize = `DefaultWordSize;

input [WordSize-1:0] inM;
input [WordSize-1:0] instruction;
input reset;
output [WordSize-1:0] outM;
output writeM;
output [MemAddrSize-1:0] addressM;
output [ProgAddrSize-1:0] progCounter;
input clk;

reg writeM;
reg [MemAddrSize-1:0] addressM;
reg [ProgAddrSize-1:0] progCounter;

reg [WordSize-1:0] registerA;
reg [WordSize-1:0] registerD;

wire [WordSize-1:0] wireAorM;
wire isZero;
wire isNeg;

alu ALU (outM, isZero, isNeg, registerD, wireAorM,
	instruction[`ControlBit1], instruction[`ControlBit2], 
	instruction[`ControlBit3], instruction[`ControlBit4], 
	instruction[`ControlBit5], instruction[`ControlBit6] );
defparam ALU.WordSize = WordSize;

assign wireAorM = instruction[`ARegisterOrMemoryBit] ? registerA : inM;

always @(posedge clk) begin
	if(reset)
		progCounter <= 0;

	addressM <= registerA;

	if(~instruction[`AddrOrComputeInstructionBit]) begin
		registerA <= {1'b0, instruction[14:0]};

		if(~reset)
			progCounter <= progCounter + 1;
		
		writeM <= 0;
	end
	else begin
		if(instruction[`DestABit])
			registerA <= outM;
		if(instruction[`DestDBit])
			registerD <= outM;

		writeM <= instruction[`DestMBit];

		if(~reset) begin
			if(isZero && instruction[`JumpEQBit])
				progCounter <= registerA;
			else if(isNeg && instruction[`JumpLTBit])
				progCounter <= registerA;
			else if(~isZero && ~isNeg && instruction[`JumpGTBit])
				progCounter <= registerA;
			else
				progCounter <= progCounter + 1;
		end
	end
end

endmodule
