module SyncCounter(clk, en, clr, q);
    input clk, en, clr;
    output reg [3:0] q;

    always @(posedge clk)begin
        if(clr == 1)        q <= 4'b0000;
        else if(en == 1)    q <= q + 1;
    end
endmodule