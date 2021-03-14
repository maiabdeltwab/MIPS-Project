`timescale 1ns / 1ps

//
// 3rd year -Computer and Systems Engineering-
// Fayoum University
// Microprocessors (301)
// Pipelined Mips 32-bit project
// ____Group1____ 
// Supervised by: Dr.Mohammed Ibrahim
//

module Register
#(
	parameter WIDTH=32
)
(
	input[WIDTH-1:0] din,
	output reg[WIDTH-1:0] dout,
	input clk,
	input en,
	input reset_b
    );


	always @(posedge clk)
	begin
		if(reset_b==0)
			dout<=0;
		else
			if(en==1)
			begin
				dout<=din;
			end
	end

endmodule
