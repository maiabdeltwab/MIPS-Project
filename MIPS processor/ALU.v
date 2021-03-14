`timescale 1ns / 1ps

//
// 3rd year -Computer and Systems Engineering-
// Fayoum University
// Microprocessors (301)
// Pipelined Mips 32-bit project
// ____Group1____ 
// Supervised by: Dr.Mohammed Ibrahim
//

module ALU (
    input  [31:0] a,
    input  [31:0] b,
    output reg [31:0] out_reg,
    output reg [31:0] hi_out,
    input [4:0] operation,
    input [4:0]   shamt,
    output reg negative_flag,
    output reg zero_flag
    );
	 
	 
	 reg[31:0] result;
	 reg[63:0] result2;            
     reg[31:0] hi;
     reg[31:0] lo;

	 
	 always @(*)
	 begin
		zero_flag=0;
		
		case(operation)
			5'b00000:begin                          //and
				result=a&b;  
			end

			5'b00001:begin                          //OR
				result=a|b;
			end

			5'b00010:begin                          //add
				result=a+b;
			end

            5'b00011:begin                          //nor
                result=a|b;
                result=~result;
            end

            5'b00100:begin                         //sltu
                if($unsigned(a)<$unsigned(b))
                    result=8'h1;
                else 
                    result=8'h0;
            end

            5'b00101:begin                         //slt
                if($signed(a)<$signed(b))
                    result=8'h1;
                else 
                    result=8'h0;
            end
                        
            5'b00111:begin                         //sll
                result=a<<shamt;
            end

			5'b00110:begin                        //sub
				result=a-b;
			end

			5'b01000:begin                        //xor
				result=a^b;
			end

			5'b01001:begin                        //addu
				result=$unsigned(a)+$unsigned(b);
			end

            5'b01010:begin                        //subu
				result=$unsigned(a)-$unsigned(b);
			end

            5'b01011:begin                        //sllv
				result=a<<b;
			end	

            5'b01100:begin                        //sra
				result[30:0]=a[30:0]>>shamt;
				result[31]=a[31];
			end	

            5'b01101:begin                        //srav
				result[30:0]=a[30:0]>>b;
				result[31]=a[31];
			end

            5'b01110:begin                        //srlv
				result=a>>b;
			end

            5'b11000:begin                        //srl
				result=a>>shamt;
			end	

            5'b01111:begin                        //div
				lo=a/b;
                hi=a%b;
				result=lo;
			end			

            5'b10000:begin                        //divu
				lo=$unsigned(a)/$unsigned(b);
				hi=$unsigned(a)%$unsigned(b);
				result=lo;
			end	

            5'b10001:begin                        //mult
			      
				result2=$signed(a)*$signed(b);  
				
				hi=result2[63:32];
				lo=result2[31:0];
				result=lo;
				
			end	

            5'b10010:begin                        //multu
				result2=$unsigned(a)*$unsigned(b);

				hi=result2[63:32];
				lo=result2[31:0]; 
				result=lo;				
       		end

            5'b10011:begin                        //mfhi
				result=hi;
			end	

            5'b10100:begin                        //mflo
				result=lo;
			end	

            5'b10101:begin                        //mthi
				hi=a;
			end	

            5'b10111:begin                        //mtlo
				lo=a;
			end

            default:begin                         //others 
                result=8'hx;
                        end							
		endcase

    zero_flag=(result==8'h0)? 1:0;
    negative_flag=(result[31]==1)? 1:0;
    out_reg=result;
	hi_out=hi;

	 end
endmodule

