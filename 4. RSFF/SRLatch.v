// data flow(RTL) ver.
module SRLatch(s, r, q, nq);
    input s, r;
    output wire q, nq;

    assign #1 q = ~(r | nq);
    assign #1 nq = ~(s | q);
endmodule

// structured ver.
// module SRLatch(s, r, q, nq);
//     input s, r;
//     output wire q, nq;

//     nor #1 (q, r, nq);
//     nor #1 (nq, s, q);
// endmodule