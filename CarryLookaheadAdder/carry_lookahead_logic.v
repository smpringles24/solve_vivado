module carry_lookahead_logic(G, P, in, C, out);
input [3:0] G, P;
input in;
output [3:1] C;
output out;

assign C[1] = G[0] | P[0] & in;
assign C[2] = G[1] | P[1] & G[0] | P[1] & P[0] & in;
assign C[3] = G[2] | P[2] & G[1] | P[2] & P[1] & G[0] | P[2] & P[1] & P[0] & in;
assign out = G[3] | P[3] & G[2] | P[3] & P[2] & G[1] | P[3] & P[2] & P[1] & G[0] | P[3] & P[2] & P[1] & P[0] & in; 

endmodule