`include "C:\Users\leand\Documentos\Codigos\DigitaliUNISA\Proggeti_Digitali_UNISA\Ex\EX_FILES.v"
`include "C:\Users\leand\Documentos\Codigos\DigitaliUNISA\Proggeti_Digitali_UNISA\Common\COMMON_FILES.v"
`include "C:\Users\leand\Documentos\Codigos\DigitaliUNISA\Proggeti_Digitali_UNISA\RISCV.sv"


module EX
(
    input [WIDTH-1:0]   i_PC,
    input [WIDTH-1:0]   i_register1,
    input [WIDTH-1:0]   i_register2,
    input [WIDTH-1:0]   i_constante,

    input               i_SLTc,
    input               i_ALUSrc,
    input [2:0]         i_ALUControl,



    output[WIDTH-1:0]   o_ALUResult,
    output[WIDTH-1:0]   o_PCBranch,
    output              o_zero,
    output              o_negative,

);

// Señales aux

wire [WIDTH-1:0]        a_out_mux;

ALU
    u_ALU
    (
        .A(i_register1),
        .B(a_out_mux),
        .ALU_Sel(i_ALUControl),
        .ALU_Out(o_ALUResult),
        .Zero(o_zero)
    );

ADD
    u_ADD
    (
        .A(i_PC),
        .B(i_constante),
        .C(o_PCBranch)
    );

MUX32
    u_MUX
    (
        .A(i_register2),
        .B(i_constante),
        .select(i_ALUSrc),
        .C(a_out_mux)
    );

endmodule
