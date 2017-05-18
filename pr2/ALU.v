module ALU(input integer a, input integer b, input [1:0] op, output integer ans);

	always @(a or b or op) begin
		case (op)
			2'b00:	ans = a + b;
			2'b01:	ans = a - b;
			2'b10:	ans = a * b;
			2'b11:	if(b==0)ans=8888;else ans = (a / b) * 100 + a % b;
		endcase
	end

endmodule