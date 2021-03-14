`timescale 1ns / 1ps

//
// 3rd year -Computer and Systems Engineering-
// Fayoum University
// Microprocessors (301)
// Pipelined Mips 32-bit project
// ____Group1____ 
// Supervised by: Dr.Mohammed Ibrahim
//

//let memory read and write to the same location at the same clock return the recently written value


module RegFile(
    input [4:0] rd1_index,
    input [4:0] rd2_index,
    output reg[31:0] rd1_out,
    output reg[31:0] rd2_out,
    input [4:0] wr_index,
    input [31:0] wr_in,
    input regWrite,
	 input regRead,
	 input clk
    );

	reg[31:0] data[31:0];
	
	
	integer i;
	initial begin
		for(i=0;i<32;i=i+1)
			data[i]=0;
	end
	
	always @(posedge clk)
	begin
		
		if(regRead==1)
		begin
			rd1_out<=data[rd1_index];
			rd2_out<=data[rd2_index];
		end
		
		if(regWrite==1)
			data[wr_index]<=wr_in;
			
		
		if(regRead==1 && regWrite==1 && wr_index==rd1_index)
			rd1_out<=wr_in;
			
		if(regRead==1 && regWrite==1 && wr_index==rd2_index)
			rd2_out<=wr_in;
			
		if(regRead==1 && rd1_index==0)
			rd1_out<=0;
			
		if(regRead==1 && rd2_index==0)
			rd2_out<=0;
	
	end

endmodule
