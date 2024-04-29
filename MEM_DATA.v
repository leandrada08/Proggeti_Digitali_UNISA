`include "RISCV.sv"



module MEM_DATA(
    input           i_memwrite,i_memread,
    input  [`WIDTH-1:0]   i_address,
    input  [`WIDTH-1:0]   i_write_data, 
    output [`WIDTH-1:0]   o_read_data
    );
    


    reg [`WIDTH-1:0] data [32'h3bfff:32'hc00];

    integer index;

    initial begin
        for (index=32'hc00 ; index < 32'h3bfff ; index=index+1) begin
            data[index] = 0;
        end
    end

    always @(i_address, i_memread) begin
        if(i_memwread) begin
            o_read_data = data[i_address>>2];
        end
    end

    always @(i_address, i_write_data) begin
        if(i_memwrite) begin
            data[i_address>>2] = i_write_data;
        end
    end
endmodule


