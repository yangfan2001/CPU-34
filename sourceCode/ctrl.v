`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/16 20:39:16
// Design Name: 
// Module Name: ctrl
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


module ctrl(
    input [31:0]id_instr,
    input [31:0]ex_instr,
    input [31:0]me_instr,
    input [31:0]wb_instr,
    input equal,
    output [3:0]aluc,
    output dmem_read,
    output dmem_write,
    output regfile_write,
    output [3:0]PcMuxSel,
    output [2:0]AluAMuxSel,
    output [3:0]AluBMuxSel,
    output [2:0]MuxAddrSel,
    output [2:0]MuxDataSel,
    output [53:0]oI,
    output reg [4:0]Stall,
    output reg [5:0]Collision,//signal which represents there is data coliision occurs!,
    output MeMulSig,
    output ExMulSig,
    output Branch
    );

wire [53:0]I;
wire [53:0]I1;
wire [53:0]I2;
wire [53:0]I3;


//decode the instruction in ID part 
decoder id_decoder(.imem_instr(id_instr),.I(I));
decoder ex_decoder(.imem_instr(ex_instr),.I(I1));
decoder me_decoder(.imem_instr(me_instr),.I(I2));
decoder wb_decoder(.imem_instr(wb_instr),.I(I3));

//31 signal in ID part
assign IdAdd=I[0],IdAddu=I[1],IdSub=I[2],IdSubu=I[3],IdAnd=I[4];
assign IdOr=I[5],IdXor=I[6],IdNor=I[7],IdSlt=I[8],IdSltu=I[9];
assign IdSllv=I[10],IdSrlv=I[11],IdSrav=I[12],IdAddi=I[14];
assign IdAddiu=I[15],IdAndi=I[16],IdOri=I[17],IdXori=I[18];
assign IdSlti=I[19],IdSltiu=I[20],IdLui=I[21],IdSll=I[22],IdSrl=I[23];
assign IdSra=I[24],IdBeq=I[25],IdBne=I[26],IdJ=I[28];
assign IdJal=I[29],IdJr=I[30],IdLw=I[32],IdSw=I[33];
assign IdMul=I[45],IdMultu=I[46];
assign IdMfhi=I[40],IdMflo=I[41];
assign IdMthi=I[42],IdMtlo=I[43];

wire [4:0]IdRsc = id_instr[25:21];
wire [4:0]IdRtc = id_instr[20:16];

// To examine whether any write Register acition in Ex
assign ExAdd=I1[0],ExAddu=I1[1],ExSub=I1[2],ExSubu=I1[3],ExAnd=I1[4];
assign ExOr=I1[5],ExXor=I1[6],ExNor=I1[7],ExSlt=I1[8],ExSltu=I1[9];
assign ExSllv=I1[10],ExSrlv=I1[11],ExSrav=I1[12],ExAddi=I1[14];
assign ExAddiu=I1[15],ExAndi=I1[16],ExOri=I1[17],ExXori=I1[18];
assign ExSlti=I1[19],ExSltiu=I1[20],ExLui=I1[21],ExSll=I1[22],ExSrl=I1[23];
assign ExSra=I1[24],ExBeq=I1[25],ExBne=I1[26],ExJ=I1[28];
assign ExJal=I1[29],ExJr=I1[30],ExLw=I1[32],ExSw=I1[33];
assign ExMul=I1[45],ExMultu=I1[46];
assign ExMfhi=I1[40],ExMflo=I1[41];
assign ExMthi=I1[42],ExMtlo=I1[43];
assign ExMulSig = ExMul;

assign ExRfWrite = ~(ExJr|ExSw|ExBeq|ExBne|ExJ);
wire ExRdc_2016 = ExLw|ExAddi|ExAddiu|ExAndi|ExOri|ExXori|ExLui|ExSlti|ExSltiu;
wire [4:0]ExRdc = ExRdc_2016?ex_instr[20:16]:ex_instr[15:11];

// To examine whether any write Register acition in Me
assign MeAdd=I2[0],MeAddu=I2[1],MeSub=I2[2],MeSubu=I2[3],MeAnd=I2[4];
assign MeOr=I2[5],MeXor=I2[6],MeNor=I2[7],MeSlt=I2[8],MeSltu=I2[9];
assign MeSllv=I2[10],MeSrlv=I2[11],MeSrav=I2[12],MeAddi=I2[14];
assign MeAddiu=I2[15],MeAndi=I2[16],MeOri=I2[17],MeXori=I2[18];
assign MeSlti=I2[19],MeSltiu=I2[20],MeLui=I2[21],MeSll=I2[22],MeSrl=I2[23];
assign MeSra=I2[24],MeBeq=I2[25],MeBne=I2[26],MeJ=I2[28];
assign MeJal=I2[29],MeJr=I2[30],MeLw=I2[32],MeSw=I2[33];
assign MeMul=I2[45],MeMultu=I2[46];
assign MeMfhi=I2[40],MeMflo=I2[41];
assign MeMthi=I2[42],MeMtlo=I2[43];
assign MeMulSig = MeMul;

assign MeRfWrite = ~(MeJr|MeSw|MeBeq|MeBne|MeJ);
wire MeRdc_2016 = MeLw|MeAddi|MeAddiu|MeAndi|MeOri|MeXori|MeLui|MeSlti|MeSltiu;
wire [4:0]MeRdc = MeRdc_2016?me_instr[20:16]:me_instr[15:11];

// define Id signal
assign regfile_write = ~(IdJr|IdSw|IdBeq|IdBne|IdJ);
assign dmem_read = IdLw;
assign dmem_write = IdSw;
wire Jump = IdJ|IdJal|(IdBeq&equal)|(IdBne&~equal)|IdJr; // 跳转信号

assign aluc[3] = IdSlt|IdSltu|IdSll|IdSrl|IdSra|IdSllv|IdSrlv|IdSrav|IdSlti|IdSltiu|IdLui;
assign aluc[2] = IdAnd|IdOr|IdXor|IdNor|IdSll|IdSrl|IdSra|IdSllv|IdSrlv|IdSrav|IdAndi|IdOri|IdXori;
assign aluc[1] = IdAdd|IdSub|IdXor|IdNor|IdSlt|IdSltu|IdSll|IdSllv|IdAddi|IdXori|IdLw|IdSw|IdSlti|IdSltiu;
assign aluc[0] = IdSub|IdSubu|IdOr|IdNor|IdSlt|IdSrl|IdSrlv|IdOri|IdBeq|IdBne|IdSlti|IdLui;

assign PcMuxSel = {(IdJ|IdJal),((IdBeq&equal)|(IdBne&~equal)),(IdJr),(~((IdBeq&equal)|(IdBne&~equal)|IdJ|IdJal|IdJr))};

wire alub_sext16 = IdAddi|IdAddiu|IdSlti|IdSltiu|IdLw|IdSw;
wire alub_ext16 = IdAndi|IdOri|IdXori|IdLui;

assign AluAMuxSel = {(~(IdSra|IdSll|IdSrl|IdJal)),(IdSra|IdSll|IdSrl),(IdJal)};
assign AluBMuxSel = {~(alub_ext16|alub_sext16|IdJal),(alub_sext16),(alub_ext16),{IdJal}};


wire rdc_1511 =IdAdd|IdAddu|IdSub|IdSubu|IdAnd|IdOr|IdXor|IdNor|IdSlt|IdSltu|IdSll|IdSrl|IdSra|IdSllv|IdSrlv|IdSrav|IdMul;
wire rdc_2016 = IdLw|IdAddi|IdAddiu|IdAndi|IdOri|IdXori|IdLui|IdSlti|IdSltiu;

assign MuxAddrSel = {IdJal,rdc_2016,rdc_1511};
assign MuxDataSel ={IdMul,IdLw,~(IdMul|IdLw)};

assign IdRsRead = IdLw|IdSw|IdAddi|IdAddiu|IdAndi|IdOri|IdXori|IdSlti|IdSltiu|IdAddu|IdAnd|IdBeq
|IdBne|IdJr|IdLw|IdXor|IdNor|IdOr|IdSllv|IdSltu|IdSubu|IdSw|IdAdd|IdSub|IdSlt|IdSrlv|IdSrav|IdMul;

assign IdRtRead = IdAddu|IdAnd|IdBeq|IdBne|IdXor|IdNor|IdOr|IdSll|IdSllv|IdSltu|IdSra|
IdSrl|IdSubu|IdAdd|IdSub|IdSlt|IdSrlv|IdSrav|IdMul;

assign Stall_sign = ExRfWrite&((ExRdc==IdRsc)||(ExRdc==IdRtc))||MeRfWrite&((MeRdc==IdRsc)||(MeRdc==IdRtc));
//assign Stall = Stall_sign?5'b00011:5'b00000;

always @(*) begin
    Stall = 5'b00000;
    Collision = 6'b000000;
    if(ExRfWrite&&ExRdc!=5'b00000)begin
        if(IdRsRead&(ExRdc==IdRsc))begin
            //Stall = 5'b00011;
            Collision[0]=1;
        end
        else if(IdRtRead&(ExRdc==IdRtc)) begin
            //Stall = 5'b00011;
            Collision[1]=1;
        end
    end
    else if(MeRfWrite&&MeRdc!=5'b00000)begin
        if(IdRsRead&(MeRdc==IdRsc))begin
            //Stall = 5'b00011;
            Collision[2]=1;
        end
        else if (IdRtRead&(MeRdc==IdRtc))begin
            //Stall = 5'b00011;
            Collision[3]=1;
        end
    end
end

/*always @(*) begin
     Stall = 5'b00000;
     if(Jump)begin
        Stall = 5'b00010; // After branch instruction,Stop the PipeLine!
    end
end*/


assign oI = Stall;
assign Branch = Jump;

endmodule
