module CounterModule74163(clk, clrN, ldN, p, t, d, q, c);
    input clk, clrN, ldN, p, t;
    input [3:0] d;
    output wire c;
    output reg [3:0] q;

    assign c = &q & t;

    always @(posedge clk)begin
        if (!clrN)      q <= 4'b0000;
        else if (!ldN)  q <= d;
        else if (p && t) q <= q + 1;
    end
endmodule