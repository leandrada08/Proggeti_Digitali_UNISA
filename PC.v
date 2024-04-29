`include "RISCV.sv"


module PC (
    input clock, 
    input [`WIDTH-1:0] next_address, 
    output reg [`WIDTH-1:0] address
    );

always @(posedge clock) begin
    address <= (|next_address === 1'bx) ? 32'h1000: next_address; //Analizo si al menos 1 bit es indeterminado, si es asi, reinicio el sistema, si no solo guardo la siguiente instruccion
end

endmodule