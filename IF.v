
// `include "C:\Users\leand\Documentos\Codigos\DigitaliUNISA\Proggeti_Digitali_UNISA\COMMON_FILES.v"
// `include "C:\Users\leand\Documentos\Codigos\DigitaliUNISA\Proggeti_Digitali_UNISA\IF_FILES.v"
// `include "C:\Users\leand\Documentos\Codigos\DigitaliUNISA\Proggeti_Digitali_UNISA\RISCV.sv" 

module IF
(
    output [31:0] o_address,
    output [31:0] o_instruccion,

    input  [31:0] i_branch_address   ,
    //input         i_reset,    // Tiene que tener reset
    input         i_select,
    input         i_clock
    );

    // Declaro las variables
    wire [31 : 0]   next_address;
    wire [31 : 0]   address;
    wire [31 : 0]   address_4;
    wire [31 : 0]   instruccion;

    //Instancio las componentes
    MUX32 u_MUX32
        (
            .A(i_branch_address),
            .B(address_4),
            .select(i_select),
            .C(next_address)
        );


    ADD4 u_ADD4
        (
            .current_address(address),
            .next_address(address_4)
        );

    PC u_PC
        (
            .next_address(next_address),
            .clock(i_clock),
            .address(address)
        );

    InstruccionMEM u_InstruccionMEM
        (
            .address(address),
            .clock(i_clock),
            .instruccion(instruccion)
        );

    //Asignos las salidas

    assign o_address    = address;
    assign o_instruccion= instruccion;





    
endmodule