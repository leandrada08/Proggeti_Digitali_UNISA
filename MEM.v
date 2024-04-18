`include "C:\Users\leand\Documentos\Codigos\DigitaliUNISA\Proggeti_Digitali_UNISA\Common\COMMON_FILES.v"
`include "C:\Users\leand\Documentos\Codigos\DigitaliUNISA\Proggeti_Digitali_UNISA\Mem\MEM_FILES.v"
`include "C:\Users\leand\Documentos\Codigos\DigitaliUNISA\Proggeti_Digitali_UNISA\RISCV.sv" 


module MEM (
    input [WIDTH-1:0]   i_Address,
    input [WIDTH-1:0]   i_WriteData,
    input [1      :0]   i_BranchOp,

    input               i_negative,
    input               i_zero,
    input               i_branch,
    input               i_MemWrite,
    input               i_MemRead,
    input               i_SLTc,

    output              o_PCSrc,

    output[WIDTH-1:0]   o_ReadData,
    output[WIDTH-1:0]   o_Mux
);

//Señales internas
wire [WIDTH-1:0]    a_slt_data;

    
BRANCH
    u_BRANCH
    (
        .i_zero(i_zero),
        .i_neg(i_negative),
        .i_branch(i_branch),
        .i_BranchOp(i_BranchOp),
        .o_PCSrc(o_PCSrc),
        .o_slt_data(a_slt_data)
    );

MEM_DATA
    U_MEM_DATA
    (
        .i_memwrite(i_MemWrite),
        .i_memread(i_MemRead),
        .i_address(i_Address),
        .i_write_data(i_WriteData),
        .o_read_data(o_ReadData)
    );

MUX32
    u_MUX32
    (
        .A(a_slt_data),
        .B(i_Address),
        .select(i_SLTc),
        .C(o_Mux)
    );

endmodule