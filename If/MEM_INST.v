module MEM_INST (
    input   [31:0]      i_pc,
    output  [31:0]      o_instruccion
    );

reg [31:0] inst  [32'h4ff:32'h400];

initial begin
    $readmemb("MEM.hex",inst);
end

assign  o_instruccion = inst[i_pc/4];
endmodule