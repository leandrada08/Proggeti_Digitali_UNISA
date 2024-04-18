
module GENERADOR_CONSTANTE(
    input wire [31:0] instruccion, // Ingresso dell'istruzione
    output wire [31:0] constante // Uscita della costante immediata
);

    // Dichiarazione dei segnali interni
    wire [11:0] I_imm; // Costante immediata di tipo I
    wire [11:0] S_imm; // Costante immediata di tipo S
    wire [6:0] opcode; // Codice operativo dell'istruzione

    // Assegnazione dei segnali interni in base al formato dell'istruzione
    assign I_imm = instruccion[31:20]; // Bit [31:20] dell'istruzione
    assign S_imm = {instruccion[31:25], instruccion[11:7]}; // Bit [31:25] e [11:7] dell'istruzione
   
    // Logica di selezione della costante immediata in base al tipo di istruzione
    always @(*) begin
        case (opcode)
            7'b0110011: // Tipo R
                constante = 32'b0; // Non c'è costante immediata
            7'b0010011: // Tipo I
                case (instruccion[14:12]) // Campo di funzione 3 dell'istruzione
                    3'b000: // ADDI
                    3'b010: // SLTI
                    3'b100: // XORI
                    3'b110: // ORI
                    3'b111: // ANDI
                        constante = { {20{I_imm[11]}}, I_imm }; // Estensione del segno da 12 a 32 bit
                    3'b001: // SLLI
                        constante = { {20{1'b0}}, I_imm[5:0] }; // Estensione dello zero da 6 a 32 bit
                    3'b011: // SLTIU
                        constante = { {20{1'b0}}, I_imm }; // Estensione dello zero da 12 a 32 bit
                    3'b101: // SRLI o SRAI
                        case (instruccion[31:25]) // Campo di funzione 7 dell'istruzione
                            7'b0000000: // SRLI
                                constante = { {20{1'b0}}, I_imm[5:0] }; // Estensione dello zero da 6 a 32 bit
                            7'b0100000: // SRAI
                                constante = { {20{I_imm[11]}}, I_imm[5:0] }; // Estensione del segno da 6 a 32 bit
                            default:
                                constante = 32'b0; // Codice operativo non valido
                        endcase
                    default:
                        constante = 32'b0; // Codice operativo non valido
                endcase
            7'b0000011: // Tipo I
                case (instruccion[14:12]) // Campo di funzione 3 dell'istruzione
                    3'b010: // LW
                        constante = { {20{I_imm[11]}}, I_imm }; // Estensione del segno da 12 a 32 bit
                    default:
                        constante = 32'b0; // Codice operativo non valido
                endcase
            7'b0100011: // Tipo S
                constante = { {20{S_imm[11]}}, S_imm }; // Estensione del segno da 12 a 32 bit
            7'b1100011: // Tipo B
                constante = { {19{S_imm[11]}}, S_imm[10:5], S_imm[4:1], 1'b0 }; // Estensione del segno da 12 a 32 bit e spostamento a sinistra di 1 bit
            default:
                constante = 32'b0; // Codice operativo non valido
        endcase
    end

endmodule








