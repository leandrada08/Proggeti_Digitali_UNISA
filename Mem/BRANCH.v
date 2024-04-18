module BRANCH (
    input           i_zero,
    input           i_neg,
    input           i_branch,
    input           i_BranchOp,
    output          o_PCSrc,
    output  [31:0]  o_slt_data
);

wire mayor;
wire menor;
wire igual;
wire PCSrc_aux;


always @(*) begin
    if(zero) begin
        igual = 1;
        menor = 0;
        mayor = 0;
    end
    else begin
        igual = 0;
        if (negativo) begin
            menor = 1;
            mayor = 0;
        end 
        else begin
            mayor = 1;
            menor = 0;
        end
    end   
end

always @(*) begin
    case (i_BranchOp)
        2'b00: begin
            PCSrc_aux = igual;
        end
        2'b01: begin
            PCSrc_aux = !igual;
        end 
        2'b10: begin;
            PCSrc_aux = menor
        end 
        2'b11: begin
            PCSrc_aux = mayor | igual;
        end 
        default: begin
            PCSrc_aux = 1'b0;
        end
    endcase
end

assign o_PCSrc = (i_branch)? PCSrc_aux : 1'b0;

assign o_slt_data = (i_branch)? {31'h0000,PCSrc_aux} : 32'h0000;
    
endmodule