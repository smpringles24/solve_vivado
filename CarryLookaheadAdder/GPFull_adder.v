module GPFull_adder(x, y, in, g, p, s);
    input x, y, in;
    output g, p, s;

    assign g = x & y;   // generate
    assign p = x ^ y;   // propagate
    assign s = p ^ in;
endmodule