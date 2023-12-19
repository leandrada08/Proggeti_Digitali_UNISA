module Mux32x2 (
  input wire [31:0] A,
  input wire [31:0] B,
  input wire select,
  output reg [31:0] C
);

  always @ (*) begin
    if (select) begin
      C <= B;
    end else begin
      C <= A;
    end
  end

endmodule
