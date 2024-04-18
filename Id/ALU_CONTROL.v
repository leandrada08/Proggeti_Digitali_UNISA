
module ALU_CONTROL(
    input  [1:0] ALUop,
    input  [2:0] funct3,
    input  [6:0] funct7,
    output [2:0] ALUControl,
    output [1:0] BranchOp,
    output       SLTc
);

always @(*)
begin
    case(ALUop)
        2'b10: // Instrucciones tipo R
            case(funct3)
                3'b000: begin // ADD o SUB
                    ALUControl = ((funct7[5] == 1)) ? 3'b001 : 3'b000;
                    BranchOp = 2'b00;
                    SLTc = 1'b0;
                end
                3'b001: begin // SLL
                    ALUControl = 3'b010;
                    BranchOp = 2'b00;
                    SLTc = 1'b0;
                end
                3'b010: begin // SLT
                    ALUControl = 3'b001;
                    BranchOp = 2'b10;
                    SLTc = 1'b1;
                end
                3'b011: begin // SLTU
                    ALUControl = 3'b011;//Sub unsigned
                    BranchOp = 2'b10;
                    SLTc = 1'b1;
                end
                3'b100: begin // XOR
                    ALUControl = 3'b101;
                    BranchOp = 2'b00;
                    SLTc = 1'b0;
                end
                3'b101: begin // SRA o SRL
                    ALUControl = 3'b100;
                    BranchOp = 2'b00;
                    SLTc = 1'b0;
                end
                3'b110: begin // OR
                    ALUControl = 3'b110;
                    BranchOp = 2'b00;
                    SLTc = 1'b0;
                end
                3'b111: begin // AND
                    ALUControl = 3'b111;
                    BranchOp = 2'b00;
                    SLTc = 1'b0;
                end
                default: begin // Por defecto, se establece la operación como ADD.
                    ALUControl = 3'b000;
                    BranchOp = 2'b00;
                    SLTc = 1'b0;
                end
            endcase
        2'b11: // Instrucciones tipo I
            case(funct3)
                3'b000: begin // ADDI
                    ALUControl = 3'b000;
                    BranchOp = 2'b00;
                    SLTc = 1'b0;
                end
                3'b001: begin // SLLI
                    ALUControl = 3'b010;
                    BranchOp = 2'b00;
                    SLTc = 1'b0;
                end
                3'b010: begin // SLTI
                    ALUControl = 3'b001;
                    BranchOp = 2'b10;
                    SLTc = 1'b1;
                end
                3'b011: begin // SLTIU
                    ALUControl = 3'b011;
                    BranchOp = 2'b10;
                    SLTc = 1'b1;
                end
                3'b100: begin // XORI
                    ALUControl = 3'b101;
                    BranchOp = 2'b00;
                    SLTc = 1'b0;
                end
                3'b101: begin // SRLI o SRAI
                    ALUControl = 3'b100;
                    BranchOp = 2'b00;
                    SLTc = 1'b0;
                end
                3'b110: begin // ORI
                    ALUControl = 3'b110;
                    BranchOp = 2'b00;
                    SLTc = 1'b0;
                end
                3'b111: begin // ANDI
                    ALUControl = 3'b111;
                    BranchOp = 2'b00;
                    SLTc = 1'b0;
                end
                default: begin // Por defecto, se establece la operación como ADDI.
                    ALUControl = 3'b000;
                    BranchOp = 2'b00;
                    SLTc = 1'b0;
                end
            endcase
        2'b00: begin
            ALUControl = 3'b000;
            BranchOp = 2'b00;
            SLTc = 1'b0;
        end
        2'b01:
            case (funct3)
                3'b000: begin
                    ALUControl = 3'b001;
                    BranchOp = 2'b00;
                    SLTc = 1'b0;    
                end
                3'b001: begin
                    ALUControl = 3'b001;
                    BranchOp = 2'b01;
                    SLTc = 1'b0;    
                end 
                3'b100 , 3'b110: begin
                    ALUControl = 3'b011;
                    BranchOp = 2'b10;
                    SLTc = 1'b0;    
                end 
                3'b101 , 3'b111: begin
                    ALUControl = 3'b011;
                    BranchOp = 2'b11;
                    SLTc = 1'b0;    
                end 
                default: begin
                    ALUControl = 3'b001;
                    BranchOp = 2'b00;
                    SLTc = 1'b0;
                end
            endcase
        default: begin
            ALUControl = 3'b000;
            BranchOp = 2'b00;
            SLTc = 1'b0;
        end
    endcase
end

endmodule

