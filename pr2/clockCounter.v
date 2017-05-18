module SwitchToHex(
input wire CLOCK_50, //開關
output reg [6:0] HEX7, HEX6, HEX5, HEX4,HEX3,HEX2,HEX1,HEX0//七段顯示器
);
    integer counter;
    integer centisecond=0;
    integer second=0;
    integer c0=0,c1=0,s0=0,s1=0;
    always @(posedge CLOCK_50)begin
        counter=counter+1;
        if(counter==500000)begin
            counter=0;
            centisecond++;
            c0=centisecond%10;
            c1=centisecond/10;
            if(milisecond==100)begin
                centisecond=0;
                second++;
                s0=second%10;
                s1=second/10;
            end
        end
	end
	CharToHex c1(c1,HEX7);
    CharToHex c2(c0,HEX6);
    CharToHex c3(s1,HEX5);
    CharToHex c4(s0,HEX4);
endmodule
