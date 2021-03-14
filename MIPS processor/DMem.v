`timescale 1ns / 1ps

//
// 3rd year -Computer and Systems Engineering-
// Fayoum University
// Microprocessors (301)
// Pipelined Mips 32-bit project
// ____Group1____ 
// Supervised by: Dr.Mohammed Ibrahim
//

//memory size is 8 Kbyte
	module DMem(
	input[31:0] din,
	input[31:0] address,
	output reg[31:0] dout,
	input read,
	input clk,
	input write
    );
	 
	 
	wire[10:0] actual_address;
	assign actual_address=address[12:2];

	reg[31:0] data[2**11-1:0];
	
	 
	 always @(posedge clk)
	 begin
		if(write==1)
		begin
			data[actual_address]<=din;
		end
		else if(read==1)
		begin
			dout<=data[actual_address];
		end
	 end
endmodule
