`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/16 20:36:19
// Design Name: 
// Module Name: decoder
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

module decoder(
    input [31:0] imem_instr,
    output[53:0]I                    
);
    wire [31:0] my_cmd;
    assign my_cmd = imem_instr;
    //add
    assign   I[0]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]&my_cmd[5]&~my_cmd[4]&~my_cmd[3]&~my_cmd[2]&~my_cmd[1]&~my_cmd[0];
    //addu
    assign   I[1]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]&my_cmd[5]&~my_cmd[4]&~my_cmd[3]&~my_cmd[2]&~my_cmd[1]&my_cmd[0];
    //sub
    assign   I[2]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]&my_cmd[5]&~my_cmd[4]&~my_cmd[3]&~my_cmd[2]&my_cmd[1]&~my_cmd[0];
    //subu
    assign   I[3]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]&my_cmd[5]&~my_cmd[4]&~my_cmd[3]&~my_cmd[2]&my_cmd[1]&my_cmd[0];
    //and
    assign   I[4]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]&my_cmd[5]&~my_cmd[4]&~my_cmd[3]&my_cmd[2]&~my_cmd[1]&~my_cmd[0];
    //or
    assign   I[5]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]&my_cmd[5]&~my_cmd[4]&~my_cmd[3]&my_cmd[2]&~my_cmd[1]&my_cmd[0];
    //xor
    assign   I[6]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]&my_cmd[5]&~my_cmd[4]&~my_cmd[3]&my_cmd[2]&my_cmd[1]&~my_cmd[0];
    //nor
    assign   I[7]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]&my_cmd[5]&~my_cmd[4]&~my_cmd[3]&my_cmd[2]&my_cmd[1]&my_cmd[0];
    //slt
    assign   I[8]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]&my_cmd[5]&~my_cmd[4]&my_cmd[3]&~my_cmd[2]&my_cmd[1]&~my_cmd[0];
    //sltu
    assign   I[9]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]&my_cmd[5]&~my_cmd[4]&my_cmd[3]&~my_cmd[2]&my_cmd[1]&my_cmd[0];
    //sllv
    assign   I[10]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]&~my_cmd[5]&~my_cmd[4]&~my_cmd[3]&my_cmd[2]&~my_cmd[1]&~my_cmd[0];
    //srlv
    assign   I[11]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]&~my_cmd[5]&~my_cmd[4]&~my_cmd[3]&my_cmd[2]&my_cmd[1]&~my_cmd[0];
    //srav
    assign   I[12]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]&~my_cmd[5]&~my_cmd[4]&~my_cmd[3]&my_cmd[2]&my_cmd[1]&my_cmd[0];
    //clz
    assign I[13]=~my_cmd[31]&my_cmd[30]&my_cmd[29]&my_cmd[28]&~my_cmd[27]&~my_cmd[26]
                    &my_cmd[5]&~my_cmd[4]&~my_cmd[3]&~my_cmd[2]&~my_cmd[1]&~my_cmd[0];

    //addi
    assign   I[14]=~my_cmd[31]&~my_cmd[30]&my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26];
    //addiu
    assign   I[15]=~my_cmd[31]&~my_cmd[30]&my_cmd[29]&~my_cmd[28]&~my_cmd[27]&my_cmd[26];
    //andi
    assign   I[16]=~my_cmd[31]&~my_cmd[30]&my_cmd[29]&my_cmd[28]&~my_cmd[27]&~my_cmd[26];
    //ori
    assign   I[17]=~my_cmd[31]&~my_cmd[30]&my_cmd[29]&my_cmd[28]&~my_cmd[27]&my_cmd[26];
    //xori
    assign   I[18]=~my_cmd[31]&~my_cmd[30]&my_cmd[29]&my_cmd[28]&my_cmd[27]&~my_cmd[26];
    //slti
    assign   I[19]=~my_cmd[31]&~my_cmd[30]&my_cmd[29]&~my_cmd[28]&my_cmd[27]&~my_cmd[26];
    //sltiu
    assign   I[20]=~my_cmd[31]&~my_cmd[30]&my_cmd[29]&~my_cmd[28]&my_cmd[27]&my_cmd[26];
    //lui
    assign   I[21]=~my_cmd[31]&~my_cmd[30]&my_cmd[29]&my_cmd[28]&my_cmd[27]&my_cmd[26];
    //sll
    assign   I[22]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]&~my_cmd[5]&~my_cmd[4]&~my_cmd[3]&~my_cmd[2]&~my_cmd[1]&~my_cmd[0];
    //srl
    assign   I[23]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]&~my_cmd[5]&~my_cmd[4]&~my_cmd[3]&~my_cmd[2]&my_cmd[1]&~my_cmd[0];
    //sra
    assign   I[24]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]&~my_cmd[5]&~my_cmd[4]&~my_cmd[3]&~my_cmd[2]&my_cmd[1]&my_cmd[0];

    //beq
    assign   I[25]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&my_cmd[28]&~my_cmd[27]&~my_cmd[26];
    //bne
    assign   I[26]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&my_cmd[28]&~my_cmd[27]&my_cmd[26];
    //bgez
    assign  I[27]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&my_cmd[26];

    //j
    assign   I[28]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&my_cmd[27]&~my_cmd[26];
    //jal
    assign   I[29]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&my_cmd[27]&my_cmd[26];
    //jr
    assign   I[30]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]&~my_cmd[5]&~my_cmd[4]&my_cmd[3]&~my_cmd[2]&~my_cmd[1]&~my_cmd[0];
    //jalr
    assign  I[31]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]
                    &~my_cmd[5]&~my_cmd[4]&my_cmd[3]&~my_cmd[2]&~my_cmd[1]&my_cmd[0];

    //lw
    assign   I[32]=my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&my_cmd[27]&my_cmd[26];
    //sw
    assign   I[33]=my_cmd[31]&~my_cmd[30]&my_cmd[29]&~my_cmd[28]&my_cmd[27]&my_cmd[26];
    //lb
    assign  I[34]=my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26];
    //lbu
    assign  I[35]=my_cmd[31]&~my_cmd[30]&~my_cmd[29]&my_cmd[28]&~my_cmd[27]&~my_cmd[26];
    //lhu
    assign  I[36]=my_cmd[31]&~my_cmd[30]&~my_cmd[29]&my_cmd[28]&~my_cmd[27]&my_cmd[26];
    //lh
    assign  I[37]=my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&my_cmd[26];
    //sb
    assign  I[38]=my_cmd[31]&~my_cmd[30]&my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26];
    //sh
    assign  I[39]=my_cmd[31]&~my_cmd[30]&my_cmd[29]&~my_cmd[28]&~my_cmd[27]&my_cmd[26];
    
    //mfhi
    assign  I[40]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]
                    &~my_cmd[5]&my_cmd[4]&~my_cmd[3]&~my_cmd[2]&~my_cmd[1]&~my_cmd[0];
    //mflo 
    assign  I[41]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]
                    &~my_cmd[5]&my_cmd[4]&~my_cmd[3]&~my_cmd[2]&my_cmd[1]&~my_cmd[0];
    //mthi
    assign  I[42]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]
                    &~my_cmd[5]&my_cmd[4]&~my_cmd[3]&~my_cmd[2]&~my_cmd[1]&my_cmd[0];
    //mtlo
    assign  I[43]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]
                    &~my_cmd[5]&my_cmd[4]&~my_cmd[3]&~my_cmd[2]&my_cmd[1]&my_cmd[0];
    //div
    assign  I[44]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]
                    &~my_cmd[5]&my_cmd[4]&my_cmd[3]&~my_cmd[2]&my_cmd[1]&~my_cmd[0];
    //mul
    assign  I[45]=~my_cmd[31]&my_cmd[30]&my_cmd[29]&my_cmd[28]&~my_cmd[27]&~my_cmd[26]
                    &~my_cmd[5]&~my_cmd[4]&~my_cmd[3]&~my_cmd[2]&my_cmd[1]&~my_cmd[0];
    //multu
    assign  I[46]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]
                    &~my_cmd[5]&my_cmd[4]&my_cmd[3]&~my_cmd[2]&~my_cmd[1]&my_cmd[0];
    //divu
    assign  I[47]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]
                    &~my_cmd[5]&my_cmd[4]&my_cmd[3]&~my_cmd[2]&my_cmd[1]&my_cmd[0];
    
    //mfc0
    assign  I[48]=~my_cmd[31]&my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]
                    &~my_cmd[25]&~my_cmd[24]&~my_cmd[23]&~my_cmd[22]&~my_cmd[21];
    //mtc0
    assign  I[49]=~my_cmd[31]&my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]
                    &~my_cmd[25]&~my_cmd[24]&my_cmd[23]&~my_cmd[22]&~my_cmd[21];
     //syscall
     assign I[50]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]
                    &~my_cmd[5]&~my_cmd[4]&my_cmd[3]&my_cmd[2]&~my_cmd[1]&~my_cmd[0];
     //break
     assign I[51]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]
                    &~my_cmd[5]&~my_cmd[4]&my_cmd[3]&my_cmd[2]&~my_cmd[1]&my_cmd[0];
     //teq
     assign I[52]=~my_cmd[31]&~my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]
                    &my_cmd[5]&my_cmd[4]&~my_cmd[3]&my_cmd[2]&~my_cmd[1]&~my_cmd[0];
     //eret
     assign I[53]=~my_cmd[31]&my_cmd[30]&~my_cmd[29]&~my_cmd[28]&~my_cmd[27]&~my_cmd[26]
                    &my_cmd[25]&~my_cmd[24]&~my_cmd[23]&~my_cmd[22]&~my_cmd[21]
                    &~my_cmd[5]&my_cmd[4]&my_cmd[3]&~my_cmd[2]&~my_cmd[1]&~my_cmd[0];
endmodule
