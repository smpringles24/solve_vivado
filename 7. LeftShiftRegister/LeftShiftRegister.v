module LeftShiftRegister(clk, ld, ls, clr, d, q, rIn);
    input clk, ld, ls, clr, rIn;
    input [3:0] d;
    output reg [3:0] q;

    always @(posedge clk) begin
        if (clr)        q <= 4'b0000;
        else if (ld)    q <= d;
        else if (ls)    q <= {q[2:0], rIn};
    end

endmodule