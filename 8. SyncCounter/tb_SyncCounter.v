`timescale 1ns / 1ps

module tb_SyncCounter;
    reg clk, clr, en;
    wire [3:0] q;

    integer err = 0;
    integer i;

    // clk 구성
    initial clk = 0;
    always #5 clk <= ~clk;

    // dut 구성
    SyncCounter dut(.clk(clk), .clr(clr), .en(en), .q(q));


    // ========== Test Case ==========
    initial begin
        // initial - clear counter
        clr = 1; en = 0;
        @(negedge clk);

        // case1: en = 1
        clr = 0; en = 1;
        for(i = 0; i < 17; i = i + 1)begin
            if(q !== i[3:0]) begin
                $display("err case 1 - expect: %b, output: %b",i[3:0] , q);
                err = err + 1;
            end
            clr = 0; en = 1;
            @(negedge clk);
        end


        // case2.1: clr = 1 / en = 0
        clr = 1; en = 0;
        @(negedge clk);

        if (q !== 4'b0000) begin
            $display("err case 2.1 - expect: 0000, output: %b", q);
            err = err + 1;
        end


        // make some value
        clr = 0; en = 1;
        repeat(3) @(negedge clk);

        // case2.2: clr = 1 / en = 1
        clr = 1; en = 1;
        @(negedge clk);

        if (q !== 4'b0000) begin
            $display("err case 2.2 - expect: 0000, output: %b", q);
            err = err + 1;
        end


        // make some value
        clr = 0; en = 1;
        repeat(5) @(negedge clk);

        // case3: en = 0
        clr = 0; en = 0;
        @(negedge clk);

        for(i = 0; i < 3; i = i + 1)begin
            if (q !== 4'b0101) begin
                $display("err case 3 - expect: 0101, output: %b", q);
                err = err + 1;
            end
            @(negedge clk);
        end

        // ========== Result Summary ==========
        $display("=== Result Summary ==========");
        if (err == 0)
            $display("All Test Case Clear!");
        else
            $display("Test fail! %0d error occur!", err);

        $finish;
    end
endmodule