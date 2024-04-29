`include "RISCV.sv"

module CPU (
    input clk
);
    

// Registers for IF stage 
wire [`WIDTH-1 : 0] PC;
wire [`WIDTH-1 : 0] IR;


// Registers for ID stage
wire [`WIDTH-1 : 0] register1;
wire [`WIDTH-1 : 0] register2;
wire [`WIDTH-1 : 0] constante;
wire [`REGADDR]     WriteReg;
wire                RegWrite;
wire                ALUSrc;
wire                MemWrite;
wire                MemRead;
wire                Branch;
wire                MemToReg;
wire                SLTc;
wire [2:0]          ALUControl;
wire [1:0]          BranchOp;

//Registers for EX stage
wire [`WIDTH-1 : 0] ALUResult;
wire [`WIDTH-1 : 0] PCBranch;
wire                zero;
wire                negative;




//Registers for MEM stage
wire                PCSrc;
wire [`WIDTH-1 : 0] ReadData;
wire [`WIDTH-1 : 0] Mux;


// Registers for WB stage
wire [`WIDTH-1 : 0] WriteData;




MEM u_MEM
    (
        .i_Address(ALUResult),
        .i_WriteData(register2),
        .i_BranchOp(BranchOp),
        .i_negative(negative),
        .i_zero(zero),
        .i_branch(Branch),
        .i_MemWrite(MemWrite),
        .i_MemRead(MemRead),
        .i_SLTc(SLTc),
        .o_PCSrc(PCSrc),
        .o_ReadData(ReadData),
        .o_Mux(Mux)
    );


IF u_IF
    (
    .o_address(PC),
    .o_instruccion(IR),
    .i_branch_address(PCBranch),
    .i_select(PCSrc),
    .i_clock(clk)
    );


ID u_ID
    (
        .i_clk(clk),
        .i_instruccion(IR),
        .i_WriteData(WriteData),
        .i_RegWrite(RegWrite),
        .i_WriteReg(WriteReg),
        .o_register1(register1),
        .o_register2(register2),
        .o_constante(constante),
        .o_WriteReg(WriteReg),
        .o_RegWrite(RegWrite),
        .o_ALUSrc(ALUSrc),
        .o_MemWrite(MemWrite),
        .o_MemRead(MemRead),
        .o_Branch(Branch),
        .o_MemToReg(MemToReg),
        .o_SLTc(SLTc),
        .o_ALUControl(ALUControl),
        .o_BranchOp(BranchOp)
    );



EX u_EX
    (
        .i_PC(PC),
        .i_register1(register1),
        .i_register2(register2),
        .i_constante(constante),
        .i_SLTc(SLTc),
        .i_ALUSrc(ALUSrc),
        .i_ALUControl(ALUControl),
        .o_ALUResult(ALUResult),
        .o_PCBranch(PCBranch),
        .o_zero(zero),
        .o_negative(negative)
    );


// Stage Wb

MUX32 u_MUX32
    (
        .A(ReadData),
        .B(Mux),
        .select(MemToReg),
        .C(WriteData)
    );

endmodule