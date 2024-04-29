//`timescale 1ns / 1ps

module tb_ADD();

    // Entradas
    reg [31:0] A;
    reg [31:0] B;
    
    // Salidas
    wire [31:0] C;
    
    // Instancia del módulo bajo prueba (DUT)
    ADD u_ADD(
        .A(A),
        .B(B),
        .C(C)
    );
    



    // Estímulo
    initial begin
        // Inicialización de entradas
        A <= $random;
        B <= $random;

        # 10;
        if(C != A + B) begin
            $error("Error: Output does not match expected value");
        end

        # 10;
        A <=$random;
        B <=$random;
        # 10;
        if(C != A + B) begin
            $error("Error: Output does not match expected value");
        end

        #100 $finish;
    end
    
    
endmodule