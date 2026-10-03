module CLA_4bit(x, y, in, sum, out);
    input [3:0] x, y;
    input in;
    output [3:0] sum;
    output out;

    wire [3:0] g, p;
    wire [3:1] c;

    GPFull_adder GPFA0(x[0], y[0], in, g[0], p[0], sum[0]);
    GPFull_adder GPFA1(x[1], y[1], c[1], g[1], p[1], sum[1]);
    GPFull_adder GPFA2(x[2], y[2], c[2], g[2], p[2], sum[2]);
    GPFull_adder GPFA3(x[3], y[3], c[3], g[3], p[3], sum[3]);


    carry_lookahead_logic CLLogic(g, p, in, c, out);
endmodule