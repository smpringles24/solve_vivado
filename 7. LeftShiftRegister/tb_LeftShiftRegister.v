`timescale 1ns / 1ps

module tb_LeftShiftRegister;
    reg clr, ld, ls, clk, rIn;
    reg [3:0] d;
    wire [3:0] q;

    integer errors = 0;
    integer i;

    // ========== clk 구성 ==========
    initial clk = 0;
    always #5 clk <= ~clk;

    // ========== DUT 구성 ==========
    LeftShiftRegister dut(.clk(clk), .ld(ld), .ls(ls), .clr(clr), .d(d), .q(q), .rIn(rIn));

    // =============================================
    // ========== Test 구성 (정상 제어신호)==========
    initial begin
        // case1 - clr = 1, ld = 0, ls = 0인 경우
        clr = 1; ld = 0; ls = 0; d = 4'b0101;
        @(negedge clk);
        if(q !== 4'b0000) begin
            $display("Fail - case 1 | expect:0000 real:%b", q);
            errors = errors + 1;
        end

        // case2 - clr = 0, ld = 1, ls = 0인 모든 경우
        clr = 0; ld = 1; ls = 0;
        for(i = 0; i < 16; i = i + 1)begin
            d = i;
            @(negedge clk);
            if(q !== d) begin
                $display("Fail - case 2 | expect:%b real:%b", d, q);
                errors = errors + 1;
            end
        end

        // case3 - clr = 0, ld = 0, ls = 1, Rin = 0인 경우
        clr = 0; ld = 0; ls = 1; rIn = 0; d = 4'b0000;
        @(negedge clk);
        if(q !== 4'b1110) begin
            $display("Fail - case 3 | expect:1110 real:%b", q);
            errors = errors + 1;
        end

        // case4 - clr = 0, ld = 0, ls = 1, Rin = 1인 경우
        clr = 0; ld = 0; ls = 1; rIn = 1; d = 4'b0000;
        @(negedge clk);
        if(q !== 4'b1101) begin
            $display("Fail - case 4 | expect:1101 real:%b", q);
            errors = errors + 1;
        end

        // ========== Test 구성 (오류 제어신호)==========

        // case5 - clr = 1, ld = 1, ls = 0인 경우 (clr 동작)
        clr = 1; ld = 1; ls = 0; d = 4'b1010;
        @(negedge clk);
        if(q !== 4'b0000) begin
            $display("Fail - case 5 | expect:0000 real:%b", q);
            errors = errors + 1;
        end

        // case6 - clr = 1, ld = 0, ls = 1인 경우 (clr 동작)
        clr = 0; ld = 1; ls = 0; d = 4'b1001;   @(negedge clk); // clr 전 init

        clr = 1; ld = 0; ls = 1; d = 4'b0101;
        @(negedge clk);
        if(q !== 4'b0000) begin
            $display("Fail - case 6 | expect:0000 real:%b", q);
            errors = errors + 1;
        end

        // case7 - clr = 0, ld = 1, ls = 1인 경우 (load 동작)
        clr = 0; ld = 1; ls = 1; d = 4'b1010;
        @(negedge clk);
        if(q !== 4'b1010) begin
            $display("Fail - case 7 | expect:1010 real:%b", q);
            errors = errors + 1;
        end

        // case8 - clr = 1, ld = 1, ls = 1인 경우 (clr 동작)
        clr = 1; ld = 1; ls = 1; d = 4'b1010;
        @(negedge clk);
        if(q !== 4'b0000) begin
            $display("Fail - case 8 | expect:0000 real:%b", q);
            errors = errors + 1;
        end





// ========== 결과 정리 ==========
        $display("=== Result Summary ==========");
        if (errors) $display("Fail in %0d case", errors);
        else        $display("Pass All Case!");

        $finish;
    end
endmodule