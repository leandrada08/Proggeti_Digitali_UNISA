`timescale 1ns / 1ps

module tb_CONTROL();

    // Entradas
    reg [6:0] opcode;


    
    // Salidas
    wire [1:0]  ALUOp;
    wire        RegWrite;
    wire        ALUSrc;
    wire        MemWrite;
    wire        MemRead;
    wire        Branch;
    wire        MemToReg;


    
    // Instancia del módulo bajo prueba (DUT)
    CONTROL u_CONTROL(
        .opcode(opcode),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Branch(Branch),
        .MemToReg(MemToReg),
        .ALUop(ALUOp)
    );
    


    // Estímulo
    initial begin
        // Inicialización de entradas
        opcode  <=  7'b0110011;
        # 10;

        if( ALUOp!=2'b10 ) begin
            $error("Error Tipo R ALUOp: Output does not match expected value");
        end
        if(RegWrite!=1'b1 ) begin
            $error("Error Tipo R RegWrite: Output does not match expected value");
        end
        if(ALUSrc!=1'b0 ) begin
            $error("Error Tipo R ALUSrc: Output does not match expected value");
        end
        if(MemWrite!=1'b0) begin
            $error("Error Tipo R MemWrite: Output does not match expected value");
        end
        if(MemRead!=1'b0) begin
            $error("Error Tipo R MemRead: Output does not match expected value");
        end
        if(Branch!=1'b0) begin
            $error("Error Tipo R Branch: Output does not match expected value");
        end

        if(MemToReg!=1'b0) begin
            $error("Error Tipo R MemToReg: Output does not match expected value");
        end


        opcode  <=  7'b0010011;
        #10;

        if(~(RegWrite==1'b1 & ALUSrc==1'b1 & MemWrite==1'b0 & MemRead==1'b0 & Branch==1'b0 & MemToReg==1'b0 & ALUOp==2'b11)) begin
            $error("Error Tipo I sin loads: Output does not match expected value");
        end

        opcode  <=  7'b0000011;
        # 10;

        if(~(RegWrite==1'b1 & ALUSrc==1'b1 & MemWrite==1'b0 & MemRead==1'b1 & Branch==1'b0 & MemToReg==1'b1 & ALUOp==2'b00)) begin
            $error("Error Tipo I loads: Output does not match expected value");
        end

        opcode  <=  7'b0100011;
        # 10;

        if(~(RegWrite==1'b0 & ALUSrc==1'b1 & MemWrite==1'b1 & MemRead==1'b0 & Branch==1'b0 & MemToReg==1'b0 & ALUOp==2'b00)) begin
            $error("Error Tipo S: Output does not match expected value");
        end


        #100 $finish;
    end
    
    
endmodule