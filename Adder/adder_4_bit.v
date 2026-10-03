module adder4Bit(x, y, in, sum, out);
    input [3:0] x, y;
    input in;
    output [3:0] sum;
    output out;
    wire [3:1] carry;
    
    fullAdder FA1(x[0], y[0], in, sum[0], carry[1]);
    fullAdder FA2(x[1], y[1], carry[1], sum[1], carry[2]);
    fullAdder FA3(x[2], y[2], carry[2], sum[2], carry[3]);
    fullAdder FA4(x[3], y[3], carry[3], sum[3], out);

endmodule