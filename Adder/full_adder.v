module fullAdder(x, y, in, sum, out);
    input x, y, in;
    output sum, out;
    
    assign sum = x ^ y ^ in;
    assign out = (x & y) | (y & in) | (in & x);
endmodule