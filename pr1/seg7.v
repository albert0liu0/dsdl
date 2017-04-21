module Seg7(DigIn, DigOut);
    input integer DigIn;
    output reg[7:0]DigOut;
    case(DigIn)
        0:DigOut<=8'b11000000;
        1:DigOut<=8'b01100000;
        2:DigOut<=8'b11011010;
        3:DigOut<=8'b11110010;
        4:DigOut<=8'b01100110;
        5:DigOut<=8'b10110110;
        6:DigOut<=8'b10111110;
        7:DigOut<=8'b11100000;
        8:DigOut<=8'b11111110;
        9:DigOut<=8'b11110110;
        default:DigOut<=8'b00000000;
    endcase
endmodule
module SwitchToSeg7(SwiIn,SegOut);
    input [6:0]SwiIn;
    output [15:0]SegOut;
    always@(SwiIn) begin
        integer A;
        A=SwiIn/10;
        integer B;
        B=SwiIn%10;
        Seg7(A,SegOut[15:8]);
        Seg7(B,SegOut[7:0]);
    end
}
    
