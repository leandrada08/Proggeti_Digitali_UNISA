//`timescale 1ns / 1ps

module tb_GENERADOR_CONSTANTE();

    // Entradas
    reg [31:0] instruccion;
    
    // Salidas
    wire [31:0] constante;
    
    // Instancia del módulo bajo prueba (DUT)
    GENERADOR_CONSTANTE u_GENERADOR_CONSTANTE(
        .instruccion(instruccion),
        .constante(constante)
    );
    



    // Estímulo
    initial begin
        // Inicialización de entradas
        instruccion[31:0]<= 32'b0;
        instruccion[6:0] <= 7'b0110011;
        # 10;
        if(constante != 32'b0) begin
            $error("Error1: Output does not match expected value");
        end

        instruccion[31:0] <= 32'hffffffff;
        instruccion[6:0]    <= 7'b0010011;
        instruccion[14:12]  <= 3'b010;
        #10;

        if(constante != { {20{instruccion[31]}}, instruccion[31:20]} ) begin
            $error("Error2: Output does not match expected value");
        end

        instruccion[31:0]<= 32'b0;
        instruccion[6:0]    <= 7'b0010011;
        #10;
        if(constante != { {20{instruccion[31]}}, instruccion[31:20]} ) begin
            $error("Error3: Output does not match expected value");
        end
        instruccion[31:0]<= {32'hffffffff};
        instruccion[6:0]  <= 7'b0100011;
        #10;
        if(constante != { {20{instruccion[31]}}, instruccion[31:25],instruccion[11:7]} ) begin
            $error("Error4: Output does not match expected value");
        end

        instruccion[6:0]    <= 7'b1100011;
        #10;
        if(constante != { {19{instruccion[31]}},instruccion[7],instruccion[30:25],instruccion[11:8],1'b0} ) begin
            $error("Error5: Output does not match expected value");
        end


        


        #100 $finish;
    end
    
    
endmodule