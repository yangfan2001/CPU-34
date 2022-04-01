`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/28 01:21:47
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module alu(a,b,aluc,r,zero,carry,negative,overflow);
input[31:0]a;
input[31:0]b;
input[3:0]aluc;
output reg [31:0]r;
output reg zero=0,carry=0,negative=0,overflow=0;

parameter  ADDU = 4'b0000 ;
parameter  ADD = 4'b0010 ;
parameter  SUBU = 4'b0001 ;
parameter  SUB = 4'b0011 ;
parameter  AND = 4'b0100 ;
parameter  OR = 4'b0101 ;
parameter  XOR = 4'b0110 ;
parameter  NOR = 4'b0111 ;
parameter  LUI = 4'b1001 ;
parameter  SLT = 4'b1011 ;
parameter  SLTU = 4'b1010 ;
parameter  SRA = 4'b1100 ;
parameter  SLL = 4'b1110 ;
parameter  SLR = 4'b1111 ;
parameter  SRL = 4'b1101 ;




always@(*)
begin
    zero=0;
    carry=0;
    negative=0;
    overflow=0;
    case(aluc)
        4'b0000:
        begin
            r=a+b;
            if(r==0)
                zero=1;
            if(a[31]==1&&b[31]==1)
                carry=1;
            else carry=0;
            if(a[31]==1&&b[31]==0&&r[31]==0)
                carry=1;
            else carry=0;
            if(a[31]==0&&b[31]==1&&r[31]==0)
                carry=1;
            else carry=0;
            if(r[31]==1)
                negative=1;
            else negative=0;
        end
        4'b0010:
        begin
            r=$signed(a)+$signed(b);
            if(r==0)
                zero=1;
            else zero=0;
            if($signed(r)<0)
                negative=1;
            else negative=0;
            if($signed(a)>0&&$signed(b)>0&&$signed(r)<0)
                overflow=1;
            else overflow=0;
            if($signed(a)<0&&$signed(b)<0&&$signed(r)>0)
                overflow=1;
            else overflow=0;
        end
        4'b0001:
        begin
            r=a-b;
            if(r==0)
                zero=1;
            else zero=0;
            if(a<b)
                carry=1;
            else carry=0;
            if(r[31]==1)
                negative=1;
             else negative=0;
        end
        4'b0011:
        begin
            r=$signed(a)-$signed(b);
            if(r==0)
                zero=1;
            else zero=0;
            if($signed(r)<0)
                negative=1;
             else negative=0;
            if($signed(a)<0&&$signed(b)>0&&$signed(r)>0)
                overflow=1;
            else overflow=0;
            if($signed(a)>0&&$signed(b)<0&&$signed(r)<0)
                overflow=1;
            else overflow=0;
        end
        4'b0100:
        begin
            r=a&b;
            if(r==0)
                zero=1;
            else zero=0;
            if(r[31]==1)
                negative=1;
             else negative=0;
        end
        4'b0101:
        begin
            r=a|b;
            if(r==0)
                zero=1;
            else zero=0;
            if(r[31]==1)
                negative=1;
             else negative=0;
        end
        4'b0110:
            begin
                r=a^b;
            if(r==0)
                zero=1;
            else zero=0;
            if(r[31]==1)
                negative=1;
             else negative=0;
        end
        4'b0111:
            begin
            r=~(a|b);
            if(r==0)
                zero=1;
            else zero=0;
            if(r[31]==1)
                negative=1;
             else negative=0;
        end
        4'b1000:
        begin
            r={b[15:0],16'b0};
            if(r==0)
                zero=1;
            else zero=0;
            if(r[31]==1)
                negative=1;
             else negative=0;
        end
        4'b1001:
        begin
            r={b[15:0],16'b0};
            if(r[31]==1)
                negative=1;
             else negative=0;
            if(r==0)
                zero=1;
            else zero=0;
        end
        4'b1011:
        begin
            r=($signed(a)<$signed(b))?1:0;
            if($signed(a)==$signed(b))
                zero=1;
            else zero=0;
            if($signed(a)<$signed(b))
                negative=1;
             else negative=0;
        end
        4'b1010:
        begin
            r=(a<b)?1:0;
            if(a==b)
                zero=1;
            else zero=0;
            if(r[31]==1)
                negative=1;
             else negative=0;
            if(a<b)
                carry=1;
            else carry=0;
        end
        4'b1100:
        begin
            r=$signed(b)>>>a;
            if($signed(r)==0)
                zero=1;
            else zero=0;
            if(r[31]==1)
                negative=1;
             else negative=0;
            carry=b[a];
        end
        4'b1110:
        begin
            {carry,r}=b<<a;
            if(r==0)
                zero=1;
            else zero=0;
            if(r[31]==1)
                negative=1;
             else negative=0;
        end
        4'b1111:
        begin
            {carry,r}=b<<a;
            if(r==0)
                zero=1;
            else zero=0;
            if(r[31]==1)
                negative=1;
             else negative=0;
        end
        4'b1101:
        begin
            r=b>>a;
            if(r==0)
                zero=1;
            else zero=0;
            if(r[31]==1)
                negative=1;
             else negative=0;
            carry=b[a];
        end
        default:begin
            r=32'bz;
        end
    endcase
end
endmodule

