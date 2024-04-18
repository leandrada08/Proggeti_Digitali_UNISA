
module REGISTERS (
    input wire clk, 
    //input wire reset,
    input wire [4:0] RA,
    input wire [4:0] RB,
    input wire [4:0] RW, 
    input wire RegWrite, 
    input wire [31:0] busW, 
    output wire [31:0] busA, 
    output wire [31:0] busB 
);


    // Divento i 32 registers
    reg [31:0] registros [0:31];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            registros <= 32'b0;
        end else if (RegWrite) begin
            // Escribir en el registro seleccionado
            case (RW)
                5'b00000: registros <= {registros[31:1], busW};
                5'b00001: registros <= {registros[31:2], busW, registros[0]};
                5'b00010: registros <= {registros[31:3], busW, registros[1:0]};
                5'b00011: registros <= {registros[31:4], busW, registros[2:0]};
                5'b00100: registros <= {registros[31:5], busW, registros[3:0]};
                5'b00101: registros <= {registros[31:6], busW, registros[4:0]};
                5'b00110: registros <= {registros[31:7], busW, registros[5:0]};
                5'b00111: registros <= {registros[31:8], busW, registros[6:0]};
                5'b01000: registros <= {registros[31:9], busW, registros[7:0]};
                5'b01001: registros <= {registros[31:10], busW, registros[8:0]};
                5'b01010: registros <= {registros[31:11], busW, registros[9:0]};
                5'b01011: registros <= {registros[31:12], busW, registros[10:0]};
                5'b01100: registros <= {registros[31:13], busW, registros[11:0]};
                5'b01101: registros <= {registros[31:14], busW, registros[12:0]};
                5'b01110: registros <= {registros[31:15], busW, registros[13:0]};
                5'b01111: registros <= {registros[31:16], busW, registros[14:0]};
                5'b10000: registros <= {registros[31:17], busW, registros[15:0]};
                5'b10001: registros <= {registros[31:18], busW, registros[16:0]};
                5'b10010: registros <= {registros[31:19], busW, registros[17:0]};
                5'b10011: registros <= {registros[31:20], busW, registros[18:0]};
                5'b10100: registros <= {registros[31:21], busW, registros[19:0]};
                5'b10101: registros <= {registros[31:22], busW, registros[20:0]};
                5'b10110: registros <= {registros[31:23], busW, registros[21:0]};
                5'b10111: registros <= {registros[31:24], busW, registros[22:0]};
                5'b11000: registros <= {registros[31:25], busW, registros[23:0]};
                5'b11001: registros <= {registros[31:26], busW, registros[24:0]};
                5'b11010: registros <= {registros[31:27], busW, registros[25:0]};
                5'b11011: registros <= {registros[31:28], busW, registros[26:0]};
                5'b11100: registros <= {registros[31:29], busW, registros[27:0]};
                5'b11101: registros <= {registros[31:30], busW, registros[28:0]};
                5'b11110: registros <= {registros[31:31], busW, registros[29:0]};
                5'b11111: registros <= {busW, registros[30:0]};
                default: registros <= registros;
            endcase

            /* No lo puedo hacer asi?
            
            registros[RW] <= busW;?
            
            */
        end
    end

    assign busA = registros[RA];
    assign busB = registros[RB];

endmodule

