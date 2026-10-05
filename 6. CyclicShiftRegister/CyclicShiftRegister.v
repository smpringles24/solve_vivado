module CyclicSHiftRegister(clk, q, rst);
    input clk, rst;
    output reg [2:0] q;

    always@(posedge clk)begin
        if(rst) q = 3'b000;
        else begin
            q[0] <= q[2];
            q[1] <= q[0];
            q[2] <= q[1];
        end
    end

endmodule