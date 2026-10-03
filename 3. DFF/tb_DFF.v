`timescale 1ns / 1ps

module tb_DFF;
    reg clk, rst, d;
    wire q;

    integer errors = 0;

    DFF dut (.clk(clk), .rst(rst), .d(d), .q(q));

    // clk 세팅
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1;
        d = 0;

        // case 1 - rst:1 d:0 -> q:0
        #6 if(q !== 0) begin
            $display("Err");
            errors = errors + 1;
        end

        // case 2 - rst:1 d:1 -> q:0
        d = 1;
        #10 if(q !== 0) begin
            $display("Err");
            errors = errors + 1;
        end

        // case 3 = rst:0 d:1 -> q:1
        rst = 0;
        d = 1;
        #10 if(q !== 1) begin
            $display("Err");
            errors = errors + 1;
        end

        // case 4 = rst:0 d:0 -> q:0
        rst = 0;
        d = 0;
        #10 if(q !== 0) begin
            $display("Err");
            errors = errors + 1;
        end

        if (errors == 0)    $display("PASS: all 4 case!");
        else                $display("Fail: %d errors", errors);
    $finish;
    end
endmodule