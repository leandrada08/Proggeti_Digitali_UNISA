`timescale 1ns / 1ps

module tb_BRANCH();

    // Entradas
    reg         i_zero;
    reg         i_neg;
    reg         i_branch;
    reg  [1 :0] i_BranchOp;
    
    // Salidas
    wire [31:0] o_slt_data;
    wire        o_PCSrc;
    
    // Instancia del módulo bajo prueba (DUT)
    BRANCH u_BRANCH(
        .i_zero(i_zero),
        .i_neg(i_neg),
        .i_branch(i_branch),
        .i_BranchOp(i_BranchOp),
        .o_slt_data(o_slt_data),
        .o_PCSrc(o_PCSrc)
    );
    



    // Estímulo
    initial begin
        // Inicialización de entradas
        i_zero      <= 1'b1;
        i_neg       <= 1'b0;
        i_branch    <= 1'b1;
        i_BranchOp  <= 2'b00;

        # 10;
        if(o_PCSrc!=1'b1) begin
            $error("Error: Output does not match expected value");
        end

        # 10;
        i_zero      <= 1'b0;
        i_neg       <= 1'b1;

        i_BranchOp  <= 2'b00;
        # 10;
        if(o_PCSrc!=1'b0) begin
            $error("Error: Output does not match expected value");
        end

        i_BranchOp  <= 2'b10;
        #10;
        if(o_PCSrc!=1'b1) begin
            $error("Error: Output does not match expected value");
        end
        #10;
        i_neg       <= 1'b0;
        #10;
        if(o_PCSrc!=1'b0) begin
            $error("Error: Output does not match expected value");
        end
        i_BranchOp  <= 2'b11;
        #10;
        if(o_PCSrc!=1'b1) begin
            $error("Error: Output does not match expected value");
        end

        i_branch    <= 1'b0;
        #10;
        if(o_PCSrc!=1'b0) begin
            $error("Error: Output does not match expected value");
        end

        #100 $finish;
    end
    
    
endmodule