`include "const.h"

module computer(reset, clk);

parameter MemAddrSize = `DefaultMemAndIOAddrSize;
parameter ProgAddrSize = `DefaultProgAddrSize;
parameter WordSize = `DefaultWordSize;

input reset;
input clk;

wire [ProgAddrSize-1:0] progCounter;
wire [WordSize-1:0] instruction;
wire [WordSize-1:0] fromCpuToMem;
wire [WordSize-1:0] fromMemToCpu;
wire [MemAddrSize-1:0] addressM;
wire writeM;

ram #(ProgAddrSize, WordSize)
	ROM (0, progCounter, 0, instruction, clk);
ram #(MemAddrSize, WordSize)
	MemAndIO (fromCpuToMem, addressM, writeM, fromMemToCpu, clk);
cpu #(MemAddrSize, ProgAddrSize, WordSize) 
	CPU (fromMemToCpu, instruction, reset, fromCpuToMem, writeM, addressM, progCounter, clk);

endmodule
