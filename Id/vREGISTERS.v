module vREGISTERS (
    input wire clk, 
    //input wire reset, 
    input wire [1:0] RA,
    input wire [1:0] RB,
    input wire [1:0] RW, 
    input wire RegWrite, 
    input wire [255:0] busW, 
    output wire [255:0] busA,
    output wire [255:0] busB 
);

    // Divento 3 registers di 256 bits
    reg [255:0] registros [0:2];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            registros <= 256'b0;
        end else if (RegWrite) begin
            // Escribir en el registro seleccionado
            case (RW)
                2'b00: registros <= {registros[2:1], b  usW};
                2'b01: registros <= {registros[2], busW, registros[0]};
                2'b10: registros <= {busW, registros[1:0]};
                default: registros <= registros; // No hacer nada si la dirección es inválida
            endcase
        end
    end


    assign busA = registros[RA];
    assign busB = registros[RB];

endmodule
