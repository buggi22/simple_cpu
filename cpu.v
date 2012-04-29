`include "const.h"

module cpu(inM, instruction, reset, outM, writeM, addressM, pc, clk);

parameter MemAddrSize = `DefaultAddrSize;
parameter MemAndIOAddrSize = `DefaultAddrSize + 1;
parameter ProgAddrSize = `DefaultProgAddrSize;
parameter WordSize = `DefaultWordSize;

input [WordSize-1:0] inM;
input [WordSize-1:0] instruction;
input reset;
output [WordSize-1:0] outM;
output writeM;
output [MemAndIOAddrSize-1:0] addressM;
output [ProgAddrSize-1:0] pc;
input clk;

reg [WordSize-1:0] outM;
reg writeM;
reg [MemAndIOAddrSize-1:0] addressM;
reg [ProgAddrSize-1:0] pc;

reg [WordSize-1:0] registerA;
reg [WordSize-1:0] registerD;
reg [ProgAddrSize-1:0] progCounter;

wire [WordSize-1:0] wireAorM;
wire isZero;
wire isNeg;
wire zeroX;
wire zeroY;
wire negateX;
wire negateY;
wire func;
wire negateOutput;

alu ALU (outM, isZero, isNeg, registerD, wireAorM,
	zeroX, negateX, zeroY, negateY, func, negateOutput);
defparam ALU.WordSize = WordSize;

always @(posedge clk) begin
	// TBD
end

endmodule
