module CharToHex(DIG_In,DIG_Out);
    input integer DIG_In;    // MSB D, C, B, A LSB
    output reg [6:0] DIG_Out;   // MSB dp, g, f, e, d, c, b, a LSB
	 always @* begin
    case( DIG_In )
        0:          DIG_Out <= 7'b1000000;    // 0
        1:          DIG_Out <= 7'b1111001;    // 1
        2:          DIG_Out <= 7'b0100100;    // 2
        3:          DIG_Out <= 7'b0110000;    // 3
        4:          DIG_Out <= 7'b0011001;    // 4
        5:          DIG_Out <= 7'b0010010;    // 5
        6:          DIG_Out <= 7'b0000011;    // 6
        7:          DIG_Out <= 7'b1111000;    // 7
        8:          DIG_Out <= 7'b0000000;    // 8
        9:          DIG_Out <= 7'b0010000;    // 9
        -1:         DIG_Out <= 7'b0111111;    // dp
        default:    DIG_Out <= 7'b1111111;    // off
     endcase
	  end
endmodule
