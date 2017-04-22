module SwitchToHex(
input wire [17:0] SW, //開關
output reg [6:0] HEX7, HEX6, HEX5, HEX4//七段顯示器
);
    always @(SW)begin
        integer A=SW[17:11];
        if(A>99)A=99;
        integer A0=A%10;
        integer A1=A/10;
        integer B=SW[10:4];
        if(B>99)B=99;
        integer B0=B%10;
        integer B1=B/10;
        CharToHex(A1,HEX7);
        CharToHex(A0,HEX6);
        CharToHex(B1,HEX5);
        CharToHex(B0,HEX4);
endmodule
