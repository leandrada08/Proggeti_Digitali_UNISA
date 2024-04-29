`include "RISCV.sv"

module EX
(
    input [`WIDTH-1:0]   i_PC,
    input [`WIDTH-1:0]   i_register1,
    input [`WIDTH-1:0]   i_register2,
    input [`WIDTH-1:0]   i_constante,

    input               i_SLTc,
    input               i_ALUSrc,
    input [2:0]         i_ALUControl,



    output[`WIDTH-1:0]   o_ALUResult,
    output[`WIDTH-1:0]   o_PCBranch,
    output              o_zero,
    output              o_negative

);

// Señales aux

wire [`WIDTH-1:0]        a_out_mux;

ALU u_ALU(i_register1,a_out_mux,i_ALUControl,o_ALUResult,o_zero,o_negative);

ADD u_ADD(
        .A(i_PC),
        .B(i_constante),
        .C(o_PCBranch)
    );

MUX32 u_MUX32(
        .A(i_register2),
        .B(i_constante),
        .select(i_ALUSrc),
        .C(a_out_mux)
    );

endmodule
