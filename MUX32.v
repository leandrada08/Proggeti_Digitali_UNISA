`include "RISCV.sv"


module MUX32 (
  input wire [`WIDTH-1:0] A,
  input wire [`WIDTH-1:0] B,
  input wire select,
  output reg [`WIDTH-1:0] C
);

  always @ (*) begin
    if (select) begin
      C <= B;
    end else begin
      C <= A;
    end
  end

endmodule
