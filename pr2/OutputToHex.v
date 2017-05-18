module OutputToHex(input integer DIG_In, output reg [6:0] HEX0,output reg [6:0] HEX1, output reg [6:0] HEX2, output reg [6:0] HEX3);
	integer neg = 0, digits = 1, x, h0, h1, h2, h3;
	always@(DIG_In)begin	
		neg = 0;
		digits = 1;
		x = DIG_In;
		
		if (x < 0)
			begin
				neg = 1;
				x = -x;
			end
		h0 = x % 10;
		x = x / 10;
		if(x>0)digits=digits+1;
		h1 = x % 10;
		x = x / 10;
		if(x>0)digits=digits+1;
		h2 = x % 10;
		x = x / 10;
		if(x>0)digits=digits+1;
		h3 = x % 10;
		if(neg==1)begin
			case(digits)
				1:h1=-1;
				2:h2=-1;
				3:h3=-1;
			endcase
		end
	end
	CharToHex c0(h0, HEX3);
	CharToHex c1(h1, HEX2);
	CharToHex c2(h2, HEX1);
	CharToHex c3(h3, HEX0);
endmodule
