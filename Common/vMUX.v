module vMUX (
  input wire [255:0] A,
  input wire [255:0] B,
  input wire select,
  output reg [255:0] C
);

  always @ (*) begin
    if (select) begin
      C <= B;
    end else begin
      C <= A;
    end
  end

endmodule
