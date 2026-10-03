`timescale 1ns / 1ps

module tb_SRLatch();
    reg s, r;
    wire q, nq;

    integer errors = 0;

    SRLatch dut (.s(s), .r(r), .q(q), .nq(nq));

    initial begin      
        // init setting
        s = 0; 
        r = 1;
        #10;
        r = 0;

        // case 1
        s = 0;
        r = 0;

        #5;

        if(q !== 0) begin
            $display("case 1 fail (s: 0, r = 0)");
            errors = errors + 1;
        end

        // case 2
        s = 1;
        r = 0;

        #5;

        if(q !== 1) begin
            $display("case 2 fail (s: 1, r = 0)");
            errors = errors + 1;
        end

        // case 3
        s = 0;
        r = 0;

        #5;

        if(q !== 1) begin
            $display("case 3 fail (s: 0, r = 0)");
            errors = errors + 1;
        end

        // case 4 - 비정상 case
        s = 1;
        r = 1;

        #5;

        if(!(q === 0 && nq === 0)) begin
            $display("case 4 fail (s: 1, r = 1)");
            errors = errors + 1;
        end

        if(errors)  $display("Test fail: %0d err!", errors);
        else        $display("Test success!");

        $finish;
    end


    
endmodule
