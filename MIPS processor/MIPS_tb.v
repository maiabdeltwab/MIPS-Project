`timescale 1ns / 1ps

//
// 3rd year -Computer and Systems Engineering-
// Fayoum University
// Microprocessors (301)
// Pipelined Mips 32-bit project
// ____Group1____ 
// Supervised by: Dr.Mohammed Ibrahim
//

module MIPS_tb;

	// Inputs
	reg clk=0;
	reg reset_b;

	// Instantiate the Unit Under Test (UUT)
	MIPS uut (
		.clk(clk), 
		.reset_b(reset_b)
	);


parameter CLK_PERIOD=10;
	
	//clk process
	always begin
	
	#(CLK_PERIOD/2);
	
	clk= ~ clk;
	
	end
	
	
	
	integer i=0;
	integer data_file;
	reg[31:0] line_instr;
	
	initial begin
	//open file for reading 
	data_file=$fopen("instrh.hex","r");
	
	if (data_file == 0) begin
    $display("data_file handle was NULL");
    $finish;
  end
	
	//write instruction memory contents
	
	for(i=0;i<2048;i=i+1)
	begin
		$fscanf(data_file, "%x\r\n",line_instr); 
		if ($feof(data_file)) begin
			$display("End of file while reading memory contents");
			$finish;
		end
		uut.IM.data[i]=line_instr;
	end
	
	$display("Instruction memory is initialized.");
	
	end

	//////////////////////////////////////////////////////
	
	wire program_end;
	
	assign program_end= uut.pc_if==32'h48;
	
	
	integer regFile=0;
	reg[31:0] regReadVal=0;
	
	initial begin
	
	@(posedge clk);
	#1;
	reset_b=0;
	#(CLK_PERIOD*10);
	reset_b<=1;
	#(CLK_PERIOD);
	
	@(posedge program_end);
	
	$display("Program is executed.");
	
	//Do comparison of registers
	
end
      
endmodule

