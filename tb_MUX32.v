`timescale 1ns / 1ps

module tb_MUX32();

    // Entradas
    reg [31:0] A;
    reg [31:0] B;
    reg select;
    
    // Salidas
    wire [31:0] C;
    
    // Instancia del módulo bajo prueba (DUT)
    MUX32 u_MUX32(
        .A(A),
        .B(B),
        .select(select),
        .C(C)
    );
    


    // Estímulo
    initial begin
        // Inicialización de entradas
        A <= $random;
        B <= $random;
        select = 0;
        # 10;
        if(C != A) begin
            $error("Error: Output does not match expected value");
        end

        select = 1;
        # 10;
        if(C != B) begin
            $error("Error: Output does not match expected value");
        end

        #100 $finish;
    end
    
    
endmodule
