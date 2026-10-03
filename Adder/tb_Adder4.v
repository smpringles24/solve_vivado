`timescale 1ns / 1ps

module tb_adder4Bit;
    reg [3:0] x, y;
    reg in;
    wire [3:0] sum;
    wire out;
    
    integer i, j, k;
    integer errors = 0;
    
    adder4Bit dut (.x(x), .y(y), .in(in), .sum(sum), .out(out));
    
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_adder4Bit);
        
        //모든 입력 조합 테스트
        for (i = 0; i < 16; i = i + 1)
            for (j = 0; j < 16; j = j + 1)
                for (k = 0; k < 2; k = k + 1) begin
                    x = i; y = j; in = k;
                    #10;
                    if ({out, sum} !== i + j + k) begin
                        $display("ERROR: %d + %d + %d = %d (got out=%b sum=%d)",i, j, k, i + j + k, out, sum);
                        errors = errors + 1;
                    end
                end
                
                if (errors == 0) $display("PASS: all 512 case!");
                else             $display("FAIL: %0d errors", errors);
                $finish;
    end
endmodule
