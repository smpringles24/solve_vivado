module DFF(clk, d, rst, q);
    input clk, d, rst;
    output reg q;

    always@(posedge clk)begin
        if (rst == 1)   q <= 0;
        else            q <= d;
    end
endmodule