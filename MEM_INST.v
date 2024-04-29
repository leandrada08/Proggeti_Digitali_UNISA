`include "RISCV.sv"


module MEM_INST (
    input   [`WIDTH-1:0]      i_pc,
    output  [`WIDTH-1:0]      o_instruccion
    );

reg [`WIDTH-1:0] inst  [32'h4ff:32'h400];

initial begin
    $readmemb("MEM.hex",inst);
end

assign  o_instruccion = inst[i_pc/4];
endmodule