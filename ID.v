`include "RISCV.sv"



module ID (
    input               i_clk,
    input [`WIDTH-1:0]   i_instruccion,
    input [`WIDTH-1:0]   i_WriteData,
    input               i_RegWrite,
    output[`REGADDR]   i_WriteReg,

    output[`WIDTH-1:0]   o_register1,
    output[`WIDTH-1:0]   o_register2,
    output[`WIDTH-1:0]   o_constante,
    output[`REGADDR]   o_WriteReg,

    output              o_RegWrite,
    output              o_ALUSrc,
    output              o_MemWrite,
    output              o_MemRead,
    output              o_Branch,
    output              o_MemToReg,

    output              o_SLTc,

    output[2:0]         o_ALUControl,
    output[1:0]         o_BranchOp

    // Procesamiento vectorial
    // input [255:0] i_v_register,
    // output[255:0] o_v_register1,
    // output[255:0] o_v_register2,

);

// Señales auxiliares de instruccion
wire [`REGADDR]    a_rs1;
wire [`REGADDR]    a_rs2;
wire [6 : 0]    a_op_code;

//Señales auxiliar de control


wire [1 : 0]     a_ALUOp;

assign a_rs1 = i_instruccion[19:15];
assign a_rs2 = i_instruccion[24:20];

    


GENERADOR_CONSTANTE u_GENERADOR_CONSTANTE
    (
        .instruccion(instruccion),
        .constante(o_constante)
    );

REGISTERS u_REGISTERS
    (
        .clk(i_clk),
        .RA(a_rs1),
        .RB(a_rs2),
        .RW(i_WriteReg),
        .RegWrite(i_RegWrite),
        .busW(i_register),
        .busA(o_register1),
        .busB(o_register2)
    );

// vREGISTERS
// (
//     .RA(a_rs1[1:0]),
//     .RB(a_rs2[1:0]),
//     .RW(a_rd[1:0])
//     .clk(i_clk),
//     .RegWrite(a_reg_write),
//     .busW(i_v_register),
//     .busA(o_v_register1),
//     .busB(o_v_register2)
// )

CONTROL u_CONTROL
    (
        .opcode(a_op_code),
        .RegWrite(o_RegWrite),
        .ALUSrc(o_ALUSrc),
        .MemWrite(o_MemWrite),
        .MemRead(o_MemRead),
        .Branch(o_Branch),
        .MemToReg(o_MemToReg),
        .ALUop(a_ALUOp)
    );

ALU_CONTROL u_ALU_CONTROL
    (
        .ALUop(a_ALUOp),
        .funct3(i_instruccion[`func3]),
        .funct7(i_instruccion[`func7]),
        .ALUControl(o_ALUControl),
        .BranchOp(o_BranchOp),
        .SLTc(o_SLTc)
    );

assign o_WriteReg = i_instruccion[`rd];


endmodule