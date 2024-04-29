`timescale 1ns / 1ps

module tb_ALU_CONTROL();

    // Entradas
    reg [1:0] ALUop;
    reg [2:0] funct3;
    reg [6:0] funct7;


    
    // Salidas
    wire [2:0]  ALUControl;
    wire [1:0]  BranchOp;
    wire        SLTc;


    
    // Instancia del módulo bajo prueba (DUT)
    ALU_CONTROL u_ALU_CONTROL(
        .ALUop(ALUop),
        .funct3(funct3),
        .funct7(funct7),
        .ALUControl(ALUControl),
        .BranchOp(BranchOp),
        .SLTc(SLTc)
    );
    


    // Estímulo
    initial begin
        // Inicialización de entradas
        ALUop   <= 2'b10; 
        funct3  <= 3'b000;
        funct7  <= 7'b0100000;
        # 10;
        if(ALUControl!=3'b001) begin
            $error("Error SUB AluControl: Output does not match expected value");
        end
        if(BranchOp!=2'b00) begin
            $error("Error SUB BranchOp: Output does not match expected value");
        end
        if(SLTc!=1'b0) begin
            $error("Error SUB SLTC: Output does not match expected value");
        end
        funct7  <= 7'b0000000;
        #10;
        if(ALUControl!=3'b000) begin
            $error("Error ADD: Output does not match expected value");
        end

        #10
        funct3  <= 3'b100;
        # 10;
        if(~(ALUControl==3'b101 & BranchOp==2'b00 & SLTc==1'b0)) begin
            $error("Error3: Output does not match expected value");
        end



        #10
        funct3  <= 3'b111;
        # 10;
        if(~(ALUControl==3'b111 & BranchOp==2'b00 & SLTc==1'b0)) begin
            $error("Error4: Output does not match expected value");
        end
        #10


        ALUop   <= 2'b11; 
        funct3  <= 3'b010;
        # 10;
        if(ALUControl!=3'b001) begin
            $error("Error SLT AluControl: Output does not match expected value");
        end
        if(BranchOp!=2'b10) begin
            $error("Error SLT BranchOp: Output does not match expected value");
        end
        if(SLTc!=1'b1) begin
            $error("Error SLT SLTC: Output does not match expected value");
        end
        #10

        
        funct3  <= 3'b111;
        # 10;
        if(~(ALUControl==3'b111 & BranchOp==2'b00 & SLTc==1'b0)) begin
            $error("Error6: Output does not match expected value");
        end
        #10


        
        ALUop   <= 2'b00; 
        # 10;
        if(~(ALUControl==3'b000 & BranchOp==2'b00 & SLTc==1'b0)) begin
            $error("Error7: Output does not match expected value");
        end
        #10


        
        ALUop   <= 2'b01; 
        funct3  <= 3'b000;

        # 10;
        if(ALUControl!=3'b001) begin
            $error("Error Beq AluControl: Output does not match expected value");
        end
        if(BranchOp!=2'b00) begin
            $error("Error Beq BranchOp: Output does not match expected value");
        end
        if(SLTc!=1'b0) begin
            $error("Error Beq SLTC: Output does not match expected value");
        end
        #10
        #100 $finish;
    end
    
    
endmodule