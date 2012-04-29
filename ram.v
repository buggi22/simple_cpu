`include "const.h"
// `define RAM_DEBUG
`define MAX_RAM_DEBUG_OUTPUT 20

module ram(in, address, load, out, clk);

parameter AddrSize = `DefaultAddrSize;
parameter WordSize = `DefaultWordSize;

input [WordSize-1:0] in;
input [AddrSize-1:0] address;
input load;
input clk;
output [WordSize-1:0] out;

reg [WordSize-1:0] out;
reg [WordSize-1:0] mem [0:(1<<AddrSize) - 1];

integer i;
initial begin
	for(i = 0; i < (1<<AddrSize); i = i + 1) begin
		mem[i] <= {WordSize{1'b0}};
	end
end

always @(posedge clk) begin
	if(load)
		mem[address] <= in;
	out <= mem[address];
end

`ifdef RAM_DEBUG

integer j;
always @(negedge clk) begin
	for(j = 0; j < (1<<AddrSize); j = j + 1) begin
		$display("Mem at %d = %h (%d)", j, mem[j], mem[j]);
		if(j == `MAX_RAM_DEBUG_OUTPUT / 2 - 1 &&
				`MAX_RAM_DEBUG_OUTPUT < (1<<AddrSize)) begin
			$display("...");
			j = (1<<AddrSize) - 1 - (`MAX_RAM_DEBUG_OUTPUT / 2);
		end
	end
end

`endif

endmodule
