`timescale 1ns / 1ps

//
// 3rd year -Computer and Systems Engineering-
// Fayoum University
// Microprocessors (301)
// Pipelined Mips 32-bit project
// ____Group1____ 
// Supervised by: Dr.Mohammed Ibrahim
//


module Control_unit(
    input [5:0] opcode,
    input [5:0] func ,
    output reg  sign_sel , 
    output reg  regDst , 
    output reg   aluSrc , 
    output reg   memRead , 
    output reg  memWrite ,
    output reg   memToReg ,
    output reg   readenable , 
    output reg   writeenable , 
    output reg   beq ,
    output reg   bne ,
    output reg   blez ,
    output reg   bgez ,
    output reg   bgtz ,  
    output reg jal ,
    output reg  jr ,
    output reg   j ,
    output reg jalr ,
    output reg lui ,
    output reg lbu ,
    output reg lhu ,
    output reg  sb ,
    output reg sh ,
    output reg mfhi,
    output reg mflo,
    output reg  mthi,
    output reg   mtlo,
    output reg r31_select ,   
    output reg [4:0] operation 
    );        
    always @(*) 
    begin
     sign_sel = opcode==6'b001000 || opcode==6'b001010 || opcode==6'b000100 || opcode==6'b000101 || opcode==6'b000110 || opcode==6'b000111 || opcode==6'b000010 || opcode==6'b000011 || opcode==6'b100011 || opcode==6'b101011 || opcode==6'b100101 || opcode==6'b100100 || opcode==6'b101000 || opcode==6'b101001 || opcode==6'b000001 ;
     memToReg = opcode == 6'b100011 || opcode==6'b100101 || opcode==6'b100100;
     regDst =  opcode== 6'b000000 ; //r-type 
     aluSrc = opcode== 6'b001000 || opcode== 6'b001110 || opcode==6'b001001 || opcode==6'b001100 ||opcode==6'b001101 ||opcode==6'b001011 ||opcode==6'b001010 ||opcode==6'b100011 ||opcode==6'b101011 || opcode==6'b100101 || opcode==6'b100100 || opcode==6'b101000 || opcode==6'b101001;
     memRead =opcode==6'b100011 || opcode==6'b100101 || opcode==6'b100100 ; 
     memWrite= opcode == 6'b101011 || opcode==6'b101000 || opcode==6'b101001 ;
   
     readenable =( ~(opcode==6'b000010) && ~(opcode==6'b000011) && ~(opcode ==6'b001111) && ~(func==6'b010000) && ~(func==6'b010010) );
    
     writeenable = (~(opcode ==6'b000100) && ~(opcode ==6'b000101) && ~(opcode ==6'b000110) && ~(opcode ==6'b000111) && ~(opcode == 6'b000010) && ~(opcode ==6'b101011) && ~(opcode==6'b101000) && ~(opcode==6'b101001) && ~(func==6'b001000) && ~(func==6'b010001) && ~(func==6'b010011) && ~(func==6'b011010) && ~(func==6'b011011) && ~(func==6'b011000) && ~(func==6'b011001) );
   
     beq =opcode== 6'b000100 ;
     bne=opcode== 6'b000101 ;
     jal =opcode == 6'b000011 ;
     jr = (opcode == 6'b000000 && func == 001000) ;
     j = opcode == 6'b000010;
     jalr = opcode ==6'b001001;
     r31_select  =opcode == 6'b000011;
     blez = opcode==6'b000110;
     bgez = opcode==6'b000001;
     bgtz = opcode==6'b000111;
     lui  = opcode==6'b001111;
     lbu   = opcode==6'b100100;
     lhu	= opcode==6'b100101;
     sb 	= opcode==6'b101000;
     sh   = opcode==6'b101001;   
     mfhi = (opcode==6'b000000 && func==6'b010000 ) ;
     mflo = (opcode==6'b000000 && func==6'b010010 ) ;
     mthi = (opcode==6'b000000 && func==6'b010001 ) ;
     mtlo = (opcode==6'b000000 && func==6'b010011 ) ;
     
     
    
   case(opcode) 
	6'b000000:    //R_type
	begin 
   		 case (func) 
 			6'b100100 : 
   			begin  
   		     		operation = 5'b00000 ; //and  
   			end 
 		  	6'b100101 : 
 		  	begin  
 			       	operation = 5'b00001 ; //or  
 		  	end     
 		       6'b100000 :
 		       begin 
 		               operation  =  5'b00010;    //add
 		       end 
 		       6'b100111 :
 		       begin 
 		               operation  = 5'b00011;    //nor
 		       end
 		       6'b101011 :
 		       begin 
 		               operation  = 5'b00100;    //sltu
 		       end 
 		       6'b101010 :
 		       begin
 		               operation  = 5'b00101;    //slt
 		       end
 		       6'b000000 :
 		       begin 
 		               operation = 5'b00111;    //sll
 		       end
 		       6'b100010 :
 		       begin 
 		               operation  = 5'b00110;    //sub
 		       end
 		       6'b100110 :
 		       begin
 		               operation  = 5'b01000;    //xor
 		       end
 		       6'b100001 :
 		       begin 
 		              operation = 5'b01001;    //addu
 		       end
 		       6'b100011 :
 		       begin
 		              operation = 5'b01010;    //subu
 		       end
 		       6'b001000 :
 		       begin
 		              operation = 5'bxxxxx;    //jr 
 		       end
 		       6'b001001 :
 		       begin
 		              operation = 5'bxxxxx;    //jalr
 		       end
        		6'b000100 :
        		begin
        		       operation  = 5'b01011;    //sllv
        		end
        		6'b000011 :
        		begin
        		       operation= 5'b01100;    //sra
        		end
        		6'b000111 :
        		begin 
        		       operation  = 5'b01101;    //srav
        		end
        		6'b000110 :
        		begin
        		       operation= 5'b01110;    //srlv
        		end
        		6'b000010 :
        		begin
        		       operation= 5'b11000;    //srl
        		end 
        		6'b011010 :
        		begin
        		       operation= 5'b01111;    //div
        		end
        		6'b011011 :
        		begin
        		       operation= 5'b10000;    //divu
        		end
        		6'b011000 :
        		begin
        		       operation= 5'b10001;    //mult
        		end
        		6'b011001 :
        		begin
        		       operation= 5'b10010;    //multu
        		end
        		6'b010000 :
        		begin
        		       operation= 5'b10011;    //mfhi
        		end
        		6'b010010 :
        		begin
        		       operation= 5'b10100;    //mflo
        		end
        		6'b010001 :
        		begin
        		       operation= 5'b10101;    //mthi
        		end
        		6'b010011 :
        		begin
        		       operation= 5'b10111;    //mtlo
        		end

     
       		        endcase //case(func)
	end
	6'b001000:    //addi
	begin
		operation  = 5'b00010;
	end
	6'b001001:    //addiu
	begin
		operation   = 5'b00010;
	end
	6'b001100:    //andi
	begin
		operation   = 5'b00000;
	end
	6'b001101:      //ori
	begin
		operation   = 5'b00001;	
	end
	6'b001010:     //slti
	begin
		operation  = 5'b00101;	
	end
	6'b001011:    //sltiu
	begin
		operation   = 5'b00100; 
	end
	6'b000100:    //beq
	begin
		operation   = 5'b00110;
	end
	6'b000101:   //bne
	begin
		operation   = 5'b00110;
	end
	6'b000110:   //blez
	begin
		operation   = 5'b00110;
	end
	6'b000001:   //bgez
	begin
		operation   = 5'b00110;
	end
	6'b000111:   //bgtz
	begin
		operation   = 5'b00110;
	end

	6'b000010:   //j
	begin
		operation  = 5'bxxxxx;	
	end
	6'b000011:    //jal
	begin
		operation  = 5'bxxxxx;
	end
	6'b001111:    //lui
	begin
		operation  = 5'bxxxxx;
	end
	6'b100100:	//lbu
	begin
		operation  = 5'b00010;
	end
	6'b100101:	//lhu
	begin
		operation  = 5'b00010;
	end
	6'b100011:    //lw
	begin
		operation  =  5'b00010;
	end
	6'b101011:    //sw
	begin
		operation  =  5'b00010;
	end
	6'b001110:    //xori
	begin
		operation  =  5'b01000;
	end
	6'b101000:    //sb
	begin
		operation  =  5'b00010;
	end
	6'b101001:    //sh
	begin
		operation  =  5'b00010;
	end

  endcase //case(opcode)

end    
endmodule
