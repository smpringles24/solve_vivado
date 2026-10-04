`timescale 1ns / 1ps

module tb_ClearLoadRegister;
    reg [3:0] d;
    reg clr, ld, clk;
    wire [3:0] q;

    integer errors = 0;
    integer i;

    // ========== clk 구성 ==========
    initial clk = 0;
    always #5 clk <= ~clk;

    // ========== DUT 구성 ==========
    ClearLoadRegister ClearLoadReg(.d(d), .q(q), .clr(clr), .ld(ld), .clk(clk));

    // ========== Test 구성 ==========
    initial begin
        // case1 - clr = 1, ld = 0인 경우
        clr = 1; ld = 0; d = 4'b0101;
        @(negedge clk);
        if(q !== 4'b0000) begin
            $display("Fail - case 1 | expect:0000 real:%b", q);
            errors = errors + 1;
        end

        // case2 - clr = 0, ld = 1인 모든 경우
        clr = 0; ld = 1;
        for(i = 0; i < 16; i = i + 1)begin
            d = i;
            @(negedge clk);
            if(q !== d) begin
                $display("Fail - case 2 | expect:%b real:%b", d, q);
                errors = errors + 1;
            end
        end

        // case3 - clr = 0, ld = 0인 경우
        clr = 0; ld = 0; d = 4'b0110;
        @(negedge clk);
        if(q !== 4'b1111) begin
            $display("Fail - case 3 | expect:1111 real:%b", q);
            errors = errors + 1;
        end

        // case4 - clr = 1, ld = 1인 경우
        clr = 1; ld = 1; d = 4'b1010;
        @(negedge clk);
        if(q !== 4'b0000) begin
            $display("Fail - case 4 | expect:0000 real:%b", q);
            errors = errors + 1;
        end



// ========== 결과 정리 ==========
        $display("=== Result Summary ==========");
        if (errors) $display("Fail in %0d case", errors);
        else        $display("Pass All Case!");

        $finish;
    end
endmodule