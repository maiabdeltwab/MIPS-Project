`timescale 1ns / 1ps

//
// 3rd year -Computer and Systems Engineering-
// Fayoum University
// Microprocessors (301)
// Pipelined Mips 32-bit project
// ____Group1____ 
// Supervised by: Dr.Mohammed Ibrahim
//

module RegFile_tb;

	// Inputs
	reg [4:0] rd1_index;
	reg [4:0] rd2_index;
	reg [4:0] wr_index;
	reg [31:0] wr_in;
	reg regWrite;
	reg regRead;
	reg clk=1;

	// Outputs
	wire [31:0] rd1_out;
	wire [31:0] rd2_out;

	// Instantiate the Unit Under Test (UUT)
	RegFile uut (
		.rd1_index(rd1_index), 
		.rd2_index(rd2_index), 
		.rd1_out(rd1_out), 
		.rd2_out(rd2_out), 
		.wr_index(wr_index), 
		.wr_in(wr_in), 
		.regWrite(regWrite), 
		.regRead(regRead),
		.clk(clk)
	);
	
	parameter CLK_PERIOD=10;
	
	//clk process
	always begin
	
	
	#(CLK_PERIOD/2);
	
	clk= ~ clk;
	
	end

	initial begin
		// Initialize Inputs
		rd1_index = 0;
		rd2_index = 0;
		wr_index = 0;
		wr_in = 0;
		regWrite = 0;
		regRead=0;


		@(posedge clk);
		
		#1;
		#(CLK_PERIOD*10);
		
		wr_index=3;
		wr_in=32'hff00ff00;
		regWrite=1;
		
		#CLK_PERIOD;
		
		
		wr_index=31;
		wr_in=32'hcc00ff00;
		regWrite=1;
		
		#CLK_PERIOD;
		regWrite=0;
		regRead=1;
		
		rd1_index=3;
		rd2_index=31;
		
		#CLK_PERIOD;
		
		if(rd1_out!==32'hff00ff00 || rd2_out!==32'hcc00ff00)
		begin
			$display("Incorrect Register file operation");
		end
		else
			$display("The read operation was successful");
        

	end
      
endmodule

