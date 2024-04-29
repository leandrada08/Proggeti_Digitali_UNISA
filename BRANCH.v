

module BRANCH (
    input           i_zero,
    input           i_neg,
    input           i_branch,
    input   [1 :0]  i_BranchOp,
    output          o_PCSrc,
    output  [31:0]  o_slt_data
);

wire mayor;
wire menor;
wire igual;
wire PCSrc_aux;

assign igual = (i_zero==1'b1) ? 1'b1: 1'b0;

assign menor = (i_zero==1'b0 & i_neg==1'b1)? 1'b1:1'b0;

assign mayor = (i_zero==1'b0 & i_neg==1'b0)? 1'b1:1'b0;


// always @(*) begin
//     if(i_zero) begin
//         igual = 1;
//         menor = 0;
//         mayor = 0;
//     end
//     else begin
//         igual = 0;
//         if (i_neg) begin
//             menor = 1;
//             mayor = 0;
//         end 
//         else begin
//             mayor = 1;
//             menor = 0;
//         end
//     end   
// end


assign PCSrc_aux =  (i_BranchOp==2'b00)?igual:
                    (i_BranchOp==2'b01)?~igual:
                    (i_BranchOp==2'b10)?menor:
                    (i_BranchOp==2'b11)?mayor | igual:
                                        1'b0;

// always @(*) begin
//     case (i_BranchOp)
//         2'b00: begin
//             PCSrc_aux = igual;
//         end
//         2'b01: begin
//             PCSrc_aux = !igual;
//         end 
//         2'b10: begin;
//             PCSrc_aux = menor
//         end 
//         2'b11: begin
//             PCSrc_aux = mayor | igual;
//         end 
//         default: begin
//             PCSrc_aux = 1'b0;
//         end
//     endcase
// end

assign o_PCSrc = (i_branch)? PCSrc_aux : 1'b0;

assign o_slt_data = (i_branch)? {31'h0000,PCSrc_aux} : 32'h0000;
    
endmodule