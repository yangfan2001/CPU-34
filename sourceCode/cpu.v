`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/17 16:46:51
// Design Name: 
// Module Name: cpu
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

//Rage's Dynamic PipeLine 31+interupt+mul CPU 
module cpu(
    input clk,
    input rst,
    input interupt,
    input [31:0]dmem_out,
    input [31:0]imem_instr,
    output dmem_read,
    output dmem_write,
    output [31:0]pc,
    output [31:0]dmem_wdata,
    output [31:0]dmem_waddr,
    output [31:0]o1,
    output [31:0]o2,
    output [31:0]o3,
    output [31:0]o4,
    output [31:0]o5,
    output [31:0]o6,
    output [31:0]o7,
    output [31:0]rfOut
    );
wire pc_clk = clk & ~(interupt);
// declaration of the variable
// IF Part

wire [31:0] IfAddPc;
wire [31:0] IfMuxPcOut0;
wire [31:0] IfMuxPcOut;
wire [31:0] IfPcOut;
wire [31:0] IfImemOut;
wire [3:0] MuxPcSel;

// for ID part
wire [3:0] IdAluc;
wire IdDmemRead,IdDmemWrite,IdRegFileWrite;
wire [3:0] IdPcMuxSel;
wire [2:0] IdAluAMuxSel;
wire [3:0] IdAluBMuxSel;
wire [2:0] IdMuxAddrSel;
wire [2:0]IdMuxDataSel;
wire [4:0]Stall;
wire [5:0]Collision;
wire equal;
wire regfile_write;
wire [4:0]rsc,rtc,rdc;
wire [31:0]rd;
wire [31:0]IdRs;
wire [31:0]IdRt;
wire [31:0]IdExt5out;
wire [31:0]IdExt16out;
wire [31:0]IdExt18out;
wire [31:0]IdSext16out;
wire [31:0]IdMuxAluA;
wire [31:0]IdMuxAluB;
wire [31:0]IdCat;
wire [31:0]IdHigh,IdHighIn,IdHighOut;
wire [31:0]IdLow,IdLowIn,IdLowOut;
wire IdHighWrite,IdLowWrite;

// IF/ID part
reg [31:0] IfIdNpc;
reg [31:0] IfIdIr;

// EX part
wire [31:0]ExOut;
wire [31:0]ExMulOut;
// ID/EX part
reg [31:0] IdExRt;
reg [31:0] IdExAluA;
reg [31:0] IdExAluB;
reg [31:0] IdExIr;
reg IdExRfWrite;
reg IdExDmemR,IdExDmemW;
reg [2:0]IdExMuxAddrSel;
reg [2:0]IdExMuxDataSel;
reg [3:0]IdExAluc;
// Me part
wire [31:0]MeOut;
// EX/Me part
reg [31:0]ExMeIr;
reg [31:0]ExMeRt;
reg [31:0]ExMeAluOut;
reg [31:0]ExMeMulOut;
reg ExMeRfWrite;
reg ExMeDmemR,ExMeDmemW;
reg [2:0]ExMeMuxAddrSel;
reg [2:0]ExMeMuxDataSel;
// ME/WB part
reg [31:0] MeWbIr;
reg [31:0] MeWbAluOut;
reg [31:0] MeWbDmemOut;
reg [31:0] MeWbMulOut;
reg MeWbRfWrite;
reg [2:0]MeWbMuxAddrSel;
reg [2:0]MeWbMuxDataSel;


// for WB part
wire [31:0]WbMuxAddrOut;
wire [31:0]WbMuxDataOut;
wire [2:0]WbMuxAddrSel;
wire [2:0]WbMuxDataSel;
wire [31:0]temp;
// control part
wire ExMulSig,MeMulSig;
wire Branch;
ctrl ctrl_unit(
    .id_instr(IfIdIr),
    .ex_instr(IdExIr),
    .me_instr(ExMeIr),
    .wb_instr(MeWbIr),
    .equal(equal),
    .aluc(IdAluc),
    .dmem_read(IdDmemRead),
    .dmem_write(IdDmemWrite),
    .regfile_write(IdRegFileWrite),
    .PcMuxSel(IdPcMuxSel),
    .AluAMuxSel(IdAluAMuxSel),
    .AluBMuxSel(IdAluBMuxSel),
    .MuxAddrSel(IdMuxAddrSel),
    .MuxDataSel(IdMuxDataSel),
    .Stall(Stall),
    .Collision(Collision),
    .ExMulSig(ExMulSig),
    .MeMulSig(MeMulSig),
    .oI(temp),
    .Branch(Branch)
    );

// IF part
assign IfAddPc = IfIdNpc + {{(14){IfIdIr[15]}},IfIdIr[15:0],2'b0};
assign IfImemOut = imem_instr;
assign pc = IfPcOut;



pcreg cpu_pc(
    .clk(pc_clk),
    .rst(rst),
    .ena(1),
    .data_in(IfMuxPcOut),
    .data_out(IfPcOut)
);
// Mux for PC
mux4 PcMux(
   .InputData1(IfPcOut+4),
   .InputData2(IdRs),
   .InputData3(IfAddPc),
   .InputData4(IdCat),
   .Sel(IdPcMuxSel),
   .OutputData(IfMuxPcOut0)
);
assign IfMuxPcOut = Stall[0]?IfPcOut:IfMuxPcOut0;

// IF/ID part
always @(posedge clk or posedge rst) begin
    if(rst)begin
        IfIdNpc <= 32'b0;
        IfIdIr <= 32'b0;
    end
    else if(Stall[0]&!Stall[1])begin
        IfIdNpc <= 32'b0;
        IfIdIr <= 32'b0;
    end
    else if(!Stall[0]) begin
        IfIdNpc <= IfPcOut +32'h4;
        IfIdIr <= IfImemOut;
    end
end
// ID part
assign rd = WbMuxDataOut;
assign rsc = IfIdIr[25:21];
assign rtc = IfIdIr[20:16];
assign rdc = WbMuxAddrOut;
assign equal = (IdMuxAluA == IdMuxAluB);
assign IdExt18out = {{(14){IfIdIr[15]}},IfIdIr[15:0],2'b0};
assign IdExt5out  =  {27'b0,IfIdIr[10:6]};
assign IdExt16out  = {16'b0,IfIdIr[15:0]};
assign IdSext16out = {{(16){IfIdIr[15]}},IfIdIr[15:0]};
assign IdCat = {IfIdNpc[31:28],IfIdIr[25:0],2'b0};

// In ID part the controller make signal 
wire [31:0]Rs,Rt;
assign IdRs=Collision[0]?ExOut:Collision[2]?MeOut:Rs;
assign IdRt=Collision[1]?ExOut:Collision[3]?MeOut:Rt;

regfiles cpu_ref
(
.regfile_ena(1'b1),
.regfile_rst(rst),
.regfile_clk(~clk),
.rdc(rdc),
.rsc(rsc),
.rtc(rtc),
.rd(rd),
.regfile_write(regfile_write),
.rs(Rs),
.rt(Rt),
.rf_out(rfOut)
);

// the mux for AluA  & ALuB
mux3 AluAMux
(
   .InputData1(IfIdNpc),
   .InputData2(IdExt5out),
   .InputData3(IdRs),
   .Sel(IdAluAMuxSel),
   .OutputData(IdMuxAluA)
);
mux4 AluBMux
(
   .InputData1(32'h4),
   .InputData2(IdExt16out),
   .InputData3(IdSext16out),
   .InputData4(IdRt),
   .Sel(IdAluBMuxSel),
   .OutputData(IdMuxAluB)
);

// ID/EX PART
always @(posedge clk or posedge rst) begin
    if(rst)begin
        IdExRt <= 32'b0;
        IdExIr <= 32'b0;
        IdExAluA <= 32'b0;
        IdExAluB <= 32'b0;
        IdExAluc <= 4'b0;
        IdExRfWrite <= 1'b0;
        IdExDmemR <= 1'b0;
        IdExDmemW <= 1'b0;
        IdExMuxAddrSel <= 3'b0;
        IdExMuxDataSel <= 3'b0;
    end
    else if (Stall[1]&!Stall[2])begin
        IdExRt <= 32'b0;
        IdExIr <= 32'b0;
        IdExAluA <= 32'b0;
        IdExAluB <= 32'b0;
        IdExAluc <= 4'b0;
        IdExRfWrite <= 1'b0;
        IdExDmemR <= 1'b0;
        IdExDmemW <= 1'b0;
        IdExMuxAddrSel <= 3'b0;
        IdExMuxDataSel <= 3'b0;
    end
    else if(!Stall[1]) begin
        IdExRt <= IdRt;
        IdExIr <= IfIdIr;
        IdExAluA <= IdMuxAluA;
        IdExAluB <= IdMuxAluB;
        IdExAluc <= IdAluc;
        IdExRfWrite <= IdRegFileWrite;
        IdExDmemR <= IdDmemRead;
        IdExDmemW <= IdDmemWrite;
        IdExMuxAddrSel <= IdMuxAddrSel;
        IdExMuxDataSel <= IdMuxDataSel;
    end
end

// EX part
wire [31:0] ExAluOut;
wire [3:0]aluc;
wire [31:0]ExMulA,ExMulB;
wire [63:0]ExMulZ;
assign aluc = IdExAluc;
alu cpu_alu
(
    .a(IdExAluA),
    .b(IdExAluB),
    .aluc(aluc),
    .r(ExAluOut)
);
assign ExMulA = IdExAluA;
assign ExMulB = IdExAluB;
mul cpu_mul
(
    .a(ExMulA),
    .b(ExMulB),
    .z(ExMulZ)
);
assign ExMulOut = ExMulZ[31:0];
assign ExOut = ExMulSig?ExMulOut:ExAluOut;//定义Ex的输出接口

// EX/ME PART
always @(posedge clk or posedge rst) begin
    if(rst)begin
        ExMeIr <=32'b0;
        ExMeRt <= 32'b0;
        ExMeAluOut <= 32'b0;
        ExMeMulOut <= 32'b0;
        ExMeRfWrite <= 1'b0;
        ExMeDmemR <= 1'b0;
        ExMeDmemW <= 1'b0;
        ExMeMuxAddrSel <= 3'b0;
        ExMeMuxDataSel <= 3'b0;
    end
    else if(Stall[2]&!Stall[3]) begin
        ExMeIr <=32'b0;
        ExMeRt <= 32'b0;
        ExMeAluOut <= 32'b0;
        ExMeMulOut <= 32'b0;
        ExMeRfWrite <= 1'b0;
        ExMeDmemR <= 1'b0;
        ExMeDmemW <= 1'b0;
        ExMeMuxAddrSel <= 3'b0;
        ExMeMuxDataSel <= 3'b0;
    end
    else if(!Stall[2]) begin
        ExMeIr <= IdExIr;
        ExMeRt <= IdExRt;
        ExMeAluOut <= ExAluOut;
        ExMeMulOut <= ExMulOut;
        ExMeRfWrite <= IdExRfWrite;
        ExMeDmemR <= IdExDmemR;
        ExMeDmemW <= IdExDmemW;
        ExMeMuxAddrSel <= IdExMuxAddrSel;
        ExMeMuxDataSel <= IdExMuxDataSel;
    end
end
// ME part
wire [31:0]MeDmemOut;
assign dmem_waddr = ExMeAluOut;
assign dmem_wdata = ExMeRt;
assign dmem_read = ExMeDmemR;
assign dmem_write = ExMeDmemW;
assign MeDmemOut = dmem_out;
assign MeOut = MeMulSig?ExMeMulOut:ExMeAluOut;
// ME/WB PART
always @(posedge clk or posedge rst) begin
    if(rst)begin
        MeWbIr <=32'b0;
        MeWbAluOut <= 32'b0;
        MeWbDmemOut <= 32'b0;
        MeWbMulOut <= 32'b0;
        MeWbRfWrite <= 1'b0;
        MeWbMuxAddrSel <= 3'b0;
        MeWbMuxDataSel <= 3'b0;
    end
    else if(Stall[3]&!Stall[4])begin
        MeWbIr <=32'b0;
        MeWbAluOut <= 32'b0;
        MeWbDmemOut <= 32'b0;
        MeWbMulOut <= 32'b0;
        MeWbRfWrite <= 1'b0;
        MeWbMuxAddrSel <= 3'b0;
        MeWbMuxDataSel <= 3'b0;
    end
    else if(!Stall[3]) begin
        MeWbIr <= ExMeIr;
        MeWbAluOut <= ExMeAluOut;
        MeWbDmemOut <= MeDmemOut;
        MeWbMulOut <= ExMeMulOut;
        MeWbRfWrite <= ExMeRfWrite;
        MeWbMuxAddrSel <= ExMeMuxAddrSel;
        MeWbMuxDataSel <= ExMeMuxDataSel;
    end
end
// WB part
// defination of the signal
assign regfile_write = MeWbRfWrite;
assign WbMuxAddrSel = MeWbMuxAddrSel;
assign WbMuxDataSel = MeWbMuxDataSel;

mux3 WbAddrMux
(
   .InputData1(MeWbIr[15:11]),
   .InputData2(MeWbIr[20:16]),
   .InputData3(5'b11111),
   .Sel(WbMuxAddrSel),
   .OutputData(WbMuxAddrOut)
);

mux3 WbDataMux
(
   .InputData1(MeWbAluOut),
   .InputData2(MeWbDmemOut),
   .InputData3(MeWbMulOut),
   .Sel(WbMuxDataSel),
   .OutputData(WbMuxDataOut)
);

//assign WbMuxDataOut = WbMuxDataSel?MeWbDmemOut:MeWbAluOut;

// output for test 
assign o1 = Branch;//IdRs;
assign o2 = IfIdIr;//Rs;
assign o3 = IdRt;//IdRt;
assign o4 = Rt;//Rt;
assign o5 = Collision;
assign o6 = ExOut;
assign o7 = MeOut;
endmodule