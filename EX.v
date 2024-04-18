// `include "C:\Users\leand\Documentos\Codigos\DigitaliUNISA\Proggeti_Digitali_UNISA\EX_FILES.v"
// `include "C:\Users\leand\Documentos\Codigos\DigitaliUNISA\Proggeti_Digitali_UNISA\COMMON_FILES.v"
// `include "C:\Users\leand\Documentos\Codigos\DigitaliUNISA\Proggeti_Digitali_UNISA\RISCV.sv"


module EX
(
    input [31:0]   i_PC,
    input [31:0]   i_register1,
    input [31:0]   i_register2,
    input [31:0]   i_constante,

    input               i_SLTc,
    input               i_ALUSrc,
    input [2:0]         i_ALUControl,



    output[31:0]   o_ALUResult,
    output[31:0]   o_PCBranch,
    output              o_zero,
    output              o_negative

);

// Señales aux

wire [31:0]        a_out_mux;

ALU u_ALU (
        .A(i_register1),
        .B(a_out_mux),
        .ALU_Sel(i_ALUControl),
        .ALU_Out(o_ALUResult),
        .Zero(o_zero)
    );

ADD u_ADD (
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
