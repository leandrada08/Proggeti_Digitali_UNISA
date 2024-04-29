`include "RISCV.sv"


module ADD4(
  input wire [`WIDTH-1:0] current_address,
  output reg [`WIDTH-1:0] next_address
  );

always @(*) begin
  next_address <= current_address + 4;
end
endmodule