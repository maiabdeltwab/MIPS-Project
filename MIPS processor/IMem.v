`timescale 1ns / 1ps

//
// 3rd year -Computer and Systems Engineering-
// Fayoum University
// Microprocessors (301)
// Pipelined Mips 32-bit project
// ____Group1____ 
// Supervised by: Dr.Mohammed Ibrahim
//

//8 Kbyte instruction memory (13-bit address)
     	module IMem(
	input[31:0] address,
	output reg [31:0] dout,
	input clk,
	input enable
    );


//	wire[10:0] actual_address;
//	assign actual_address=address[12:2];

//	reg[31:0] instrmem[2**11-1:0] ;

//	initial
//	begin

//	$readmemb("instr.txt", instrmem);

//	end
	
//	always @(posedge clk)
//	begin
//		if(enable==1)
//			dout<=instrmem[actual_address];
//	end
wire[10:0] actual_address;
	assign actual_address=address[12:2];

	reg[31:0] data[2**11-1:0];

	always @(posedge clk)
	begin
		if(enable==1)
			dout<=data[actual_address];
	end


endmodule
