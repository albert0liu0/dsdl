module counter(
    input wire CLOCK_50, pause, reset,
    output reg [6:0] HEX7, HEX6, HEX5, HEX4,HEX3,HEX2,HEX1,HEX0//七段顯示器
);
    integer counter;
    integer centisecond=0;
    integer second=0;
    integer c0=0,c1=0,s0=0,s1=0;
    reg pause=0;
    always @(CLOCK_50 or pause or reset)begin
        if(reset)begin
            counter=0;
            centisecond=0;
            second=0;
        end
        if(!pause)begin
            counter=counter+1;
            if(counter==1000000)begin
                counter=0;
                centisecond=centisecond+1;
                c0=centisecond%10;
                c1=centisecond/10;
                if(centisecond==100)begin
                    centisecond=0;
                    second=second+1;
                    s0=second%10;
                    s1=second/10;
                end
            end
        end
    end
    CharToHex m1(c1,HEX1);
    CharToHex m2(c0,HEX0);
    CharToHex m3(s1,HEX3);
    CharToHex m4(s0,HEX2);
endmodule
