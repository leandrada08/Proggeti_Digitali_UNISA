`timescale 1ns / 1ps

module tb_ALU();

    // Entradas
    reg [31:0] A;
    reg [31:0] B;
    reg [3 :0] ALU_Sel;
    
    // Salidas
    wire [31:0] ALU_Out;
    wire        Zero;
    wire        Negative;  

    reg [31:0] ALU_Out_AUX;
    
    // Instancia del módulo bajo prueba (DUT)
    ALU u_ALU(
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .ALU_Out(ALU_Out),
        .Zero(Zero),
        .Negativo(Negative)
    );
    


    // Estímulo
    initial begin
        // Inicialización de entradas
        A <= $random;
        B <= $random;
        ALU_Sel <= 3'b000;
        
        # 10;
        ALU_Out_AUX <= A+B;
        #10;
        if(ALU_Out != ALU_Out_AUX) begin
            $error("Error +: Output does not match expected value");
        end

        #10;
        ALU_Sel <= 3'b001;
        ALU_Out_AUX <= A-B;
        #10;
        if(ALU_Out != ALU_Out_AUX) begin
            $error("Error -: Output does not match expected value");
        end


        #10;
        ALU_Sel <= 3'b010;
        ALU_Out_AUX <= A<<B[4:0];
        #10;
        if(ALU_Out != ALU_Out_AUX) begin
            $error("Error <<: Output does not match expected value");
        end

        // #10;
        // ALU_Sel <= 3'b011;
        // #10;
        // if(ALU_Out != unsigned(A)-unsigned(B) ) begin
        //     $error("Error: Output does not match expected value");
        // end
        #10;
        ALU_Sel <= 3'b101;
        ALU_Out_AUX <= A^B;
        #10;
        if(ALU_Out != ALU_Out_AUX ) begin
            $error("Error XOR: Output does not match expected value");
        end

        #10;
        ALU_Sel <= 3'b110;
        ALU_Out_AUX <= A|B;
        #10;
        if(ALU_Out != ALU_Out_AUX ) begin
            $error("Error OR: Output does not match expected value");
        end

        #10;
        ALU_Sel <= 3'b111;
        ALU_Out_AUX <= A&B;
        #10;
        if(ALU_Out != ALU_Out_AUX ) begin
            $error("Error AND: Output does not match expected value");
        end

        #10;
        A <= B;
        ALU_Sel <= 3'b001;
        #10;
        if(Zero!=1) begin
            $error("Error 0: Output does not match expected value");
        end

        #10;
        B <= A + {31'b0,1'b1};
        ALU_Sel <= 3'b001;
        #10;
        if(Negative!=1) begin
            $error("Error Neg: Output does not match expected value");
        end


        #100 $finish;
    end
    
    
endmodule
