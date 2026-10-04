module ClearLoadRegister(d, q, clr, ld, clk);
    input [3:0] d;
    input clr, ld, clk;
    output reg [3:0] q;

    always@(posedge clk)begin
        if(clr == 1)                   q <= 4'b0000;
        else if(ld == 1)  q <= d;       
    end
endmodule