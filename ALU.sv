module ALU(
input  [31:0]   A, // Primer operando
input  [31:0]   B, // Segundo operando
input  [2:0]    ALU_Sel, // Código de operación
output [31:0]   ALU_Out, // Resultado de la ALU
output          Zero, // Indicador de resultado cero
output          Negativo
);

assign ALU_Out =    (ALU_Sel==3'b000)?suma(A,B):
                    (ALU_Sel==3'b001)?resta(A,B):
                    (ALU_Sel==3'b010)?desplazamiento_izquierda(A,B):
                    (ALU_Sel==3'b011)?resta_unsigned(A,B):
                    (ALU_Sel==3'b100)?desplazamiento_derecha(A,B):
                    (ALU_Sel==3'b101)?xor_logico(A,B):
                    (ALU_Sel==3'b110)?or_logico(A,B):
                    (ALU_Sel==3'b111)?and_logico(A,B):
                                      32'b0;


assign Zero = (ALU_Out == 32'd0) ? 1'b1 : 1'b0;

assign Negativo = ALU_Out[31];

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
function [31:0] resta_unsigned(input [31:0] a,input [31:0] b);
    begin
        resta_unsigned = $unsigned(a) - $unsigned(b);
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
        if(b[31]) begin
            desplazamiento_derecha = desplazamiento_derecha_aritmetico(a, b); // Desplazamiento aritmético a la derecha: 
        end else begin
            desplazamiento_derecha = desplazamiento_derecha_logico(a, b); // Desplazamiento lógico a la derecha
        end
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
// function [31:0] not_logico(input [31:0] a);
//     begin
//         not_logico = ~a;
//     end
// endfunction

















