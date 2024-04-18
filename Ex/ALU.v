module ALU (
input wire [31:0] A, // Primer operando
input wire [31:0] B, // Segundo operando
input wire [3:0] ALU_Sel, // Código de operación
output reg [31:0] ALU_Out, // Resultado de la ALU
output reg Zero // Indicador de resultado cero
);



always @(*) begin
    case (ALU_Sel)
        4'b000: ALU_Out = suma(A, B); // Suma
        4'b001: ALU_Out = resta(A, B); // Resta
        4'b010: ALU_Out = desplazamiento_izquierda(A, B); // Desplazamiento lógico a la izquierda
        4'b011: ALU_Out = resta_unsigned(A, B); //Resta unsigned
        4'b100: ALU_Out = desplazamiento_derecha(A, B); // Desplazamiento aritmético a la derecha
        4'b101: ALU_Out = xor_logico(A, B); // XOR
        4'b110: ALU_Out = or_logico(A, B); // OR
        4'b111: ALU_Out = and_logico(A, B); // AND
        default: ALU_Out = 32'd0; // Operación no definida
    endcase
    Zero = (ALU_Out == 32'd0) ? 1'b1 : 1'b0; // Establece el indicador Zero si el resultado es cero
end

endmodule
// Función para realizar la suma de dos operandos de 32 bits
function [31:0] suma(input [31:0] a,input [31:0] b);
    begin
        suma = a + b;
    end
endfunction

// Función para realizar la resta de dos operandos de 32 bits
function [31:0] resta(input [31:0] a,input [31:0] b);
    begin
        resta = a - b;
    end
endfunction

// Función para realizar la resta de dos operandos de 32 bits
function [31:0] resta(input [31:0] a,input [31:0] b);
    begin
        resta = $unsigned(a) - $unsigned(b);
    end
endfunction



// Función para realizar el desplazamiento lógico a la izquierda de un operando de 32 bits según el valor de los 5 bits menos significativos del otro operando
function [31:0] desplazamiento_izquierda(input [31:0] a,input [31:0] b);
    begin
        desplazamiento_izquierda = a << b[4:0];
    end
endfunction

// Función para realizar el desplazamiento lógico a la derecha de un operando de 32 bits según el valor de los 5 bits menos significativos del otro operando
function [31:0] desplazamiento_derecha(input [31:0] a,input [31:0] b);
    begin
        case (b[31])
                1'b0:ALU_Out = desplazamiento_derecha_logico(A, B); // Desplazamiento lógico a la derecha
                1'b1:ALU_Out = desplazamiento_derecha_aritmetico(A, B); // Desplazamiento aritmético a la derecha: 
            default: 
        endcase
    end
endfunction

function [31:0] desplazamiento_derecha_logico(input [31:0] a,input [31:0] b);
    begin
        desplazamiento_derecha_logico = a >> b[4:0];
    end
    
endfunction

function [31:0] desplazamiento_derecha_aritmetico(input [31:0] a,input [31:0] b);
    begin
        desplazamiento_derecha_aritmetico = $signed(a) >>> b[4:0];
    end
    
endfunction







// Función para realizar la operación lógica AND entre dos operandos de 32 bits
function [31:0] and_logico(input [31:0] a,input [31:0] b);
    begin
        and_logico = a & b;
    end
endfunction

// Función para realizar la operación lógica OR entre dos operandos de 32 bits
function [31:0] or_logico(input [31:0] a,input [31:0] b);
    begin
        or_logico = a | b;
    end
endfunction

// Función para realizar la operación lógica XOR entre dos operandos de 32 bits
function [31:0] xor_logico(input [31:0] a,input [31:0] b);
    begin
        xor_logico = a ^ b;
    end
endfunction

// Función para realizar la operación lógica NOT sobre un operando de 32 bits
function [31:0] not_logico(input [31:0] a);
    begin
        not_logico = ~a;
    end
endfunction

















