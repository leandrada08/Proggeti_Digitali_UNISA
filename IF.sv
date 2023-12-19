module IF
(
    output [31:0] o_address,
    output [31:0] o_instruccion,

    input  [31:0] i_branch_address   ,
    input         i_reset,
    input         i_select,
    input         i_clock
    );

    // Declaro las variables
    wire [31 : 0]   next_address;
    wire [31 : 0]   address;
    wire [31 : 0]   address_4;
    wire [31 : 0]   instruccion;

    //Instancio las componentes
    MUX32
    (
        .i_branch_address(A),
        .address_4(B),
        .i_select(select),
        .next_address(C)
    );


    ADD4
    (
        .address(current_address),
        .address_4(next_address)
    );

    PC
    (
        .next_address(next_address),
        .i_clock(clock),
        .address(address)
    )

    InstruccionMEM
    (
        .address(),
        .i_clock(clock),
        .instruccion()
    )


    //Asignos las salidas

    assign o_address    = address;
    assign o_instruccion= instruccion;





    
endmodule