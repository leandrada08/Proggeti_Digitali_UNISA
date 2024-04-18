// Módulo del control
module CONTROL(
    input [6:0] opcode, // Código de operación de la instrucción
    output RegWrite, // Señal para escribir en el banco de registros
    output ALUSrc, // Señal para seleccionar el segundo operando de la ALU
    output MemWrite, // Señal para escribir en la memoria de datos
    output MemRead, // Señal para leer de la memoria de datos
    output Branch, // Señal para realizar un salto condicional
    output MemToReg, // Señal para seleccionar el dato que se escribe en el registro destino
    output [1:0] ALUop
    );

    // Decodificador de 7 bits para identificar el tipo de instrucción
    always @* begin
        case (opcode)
            7'b0110011: begin // Tipo R
                RegWrite = 1'b1;
                ALUSrc = 1'b0;
                MemWrite = 1'b0;
                MemRead = 1'b0;
                Branch = 1'b0;
                MemToReg = 1'b0;
                ALUop = 2'b10;
            end
            7'b0010011: begin // Tipo I sin loads
                RegWrite = 1'b1;
                ALUSrc = 1'b1;
                MemWrite = 1'b0;
                MemRead = 1'b0;
                Branch = 1'b0;
                MemToReg = 1'b0;
                ALUop = 2'b11;
            end
            7'b0000011: begin // Tipo I loads
                RegWrite = 1'b1;
                ALUSrc = 1'b1;
                MemWrite = 1'b0;
                MemRead = 1'b1;
                Branch = 1'b0;
                MemToReg = 1'b1;
                ALUop = 2'b00;
            end
            7'b0100011: begin // Tipo S
                RegWrite = 1'b0;
                ALUSrc = 1'b1;
                MemWrite = 1'b1;
                MemRead = 1'b0;
                Branch = 1'b0;
                MemToReg = 1'b0;
                ALUop = 2'b00;
            end
            7'b1100011: begin // Tipo B
                RegWrite = 1'b0;
                ALUSrc = 1'b0;
                MemWrite = 1'b0;
                MemRead = 1'b0;
                Branch = 1'b1;
                MemToReg = 1'b0;
                ALUop = 2'b01;
            end
            default: begin // Código de operación inválido
                RegWrite = 1'b0;
                ALUSrc = 1'b0;
                MemWrite = 1'b0;
                MemRead = 1'b0;
                Branch = 1'b0;
                MemToReg = 1'b0;
                ALUop = 2'b00;
            end
        endcase
    end

endmodule
