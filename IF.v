`include "RISCV.sv"

module IF
(
    output [`WIDTH-1:0] o_address,
    output [`WIDTH-1:0] o_instruccion,

    input  [`WIDTH-1:0] i_branch_address   ,
    //input         i_reset,    // Tiene que tener reset
    input         i_select,
    input         i_clock
    );

    // Declaro las variables
    wire [`WIDTH-1 : 0]   next_address;
    wire [`WIDTH-1 : 0]   address;
    wire [`WIDTH-1 : 0]   address_4;
    wire [`WIDTH-1 : 0]   instruccion;

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

    MEM_INST u_MEM_INST
        (
            .address(address),
            .clock(i_clock),
            .instruccion(instruccion)
        );

    //Asignos las salidas

    assign o_address    = address;
    assign o_instruccion= instruccion;





    
endmodule