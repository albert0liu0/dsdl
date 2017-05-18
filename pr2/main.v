module clockCounter(
        input wire CLOCK_50,
        input wire[3:0] KEY, //開關
        output reg [6:0] HEX7, HEX6, HEX5, HEX4,HEX3,HEX2,HEX1,HEX0//七段顯示器
        );
    reg pause=0;
    always @(posedge CLOCK_50 or negedge KEY[0] or negedge KEY[1] or negedge pause)begin
    if(KEY[0]==0)begin
        pause<=!pause;
    end
    if(KEY[1]==0)begin
        pause<=1;
        reset<=1;
    end
    reset<=0;
    CharToHex m1(c1,HEX1);
    CharToHex m2(c0,HEX0);
    CharToHex m3(s1,HEX3);
    CharToHex m4(s0,HEX2);
endmodule
