module ScoreBoardController(CLK, INC, DEC, RESET, seg7disp0, seg7disp1);
    input CLK, INC, DEC, RESET;
    output [6:0] seg7disp0, seg7disp1;
    reg state;
    reg [3:0] BCD0, BCD1;
    reg [6:0] seg7Rom[0:9];
    reg [2:0] RSTCount;

    initial 
    begin
        RSTCount = 3'b000;
        state = 1;
        BCD0 = 0;   BCD1 = 0;

        seg7Rom[0] = 7'b0111111;    seg7Rom[5] = 7'b1101101;
        seg7Rom[1] = 7'b0000110;    seg7Rom[6] = 7'b1111100;
        seg7Rom[2] = 7'b1011011;    seg7Rom[7] = 7'b0000111;
        seg7Rom[3] = 7'b1001111;    seg7Rom[8] = 7'b1111111;
        seg7Rom[4] = 7'b1100110;    seg7Rom[9] = 7'b1100111;
    end

    always@(posedge CLK) begin
        case (state)
            0:
            begin
                state <= 1;
                BCD0 <= 0; BCD1 <= 0;
                RSTCount <= 0;
            end
            1:
            begin
                if(RESET && RSTCount != 3'b100)         RSTCount <= RSTCount + 1;
                else if(RESET && RSTCount == 3'b100)    state <= 0;
                else if(!RESET && INC && !DEC)  
                begin
                    RSTCount <= 0;

                    if(BCD0 == 4'b1001 && BCD1 != 4'b1001) begin
                        BCD0 <= 4'b0000; BCD1 <= BCD1 + 4'b0001;
                    end
                    else if(BCD0 != 4'b1001)   BCD0 <= BCD0 + 4'b0001;
                    else begin
                        BCD0 <= 4'b1001; BCD1 <= 4'b1001;
                    end
                end
                else if(!RESET && !INC && DEC)
                begin
                    RSTCount <= 0;

                    if(BCD0 == 4'b0000 && BCD1 != 4'b0000) begin
                        BCD0 <= 4'b1001; BCD1 <= BCD1 - 4'b0001;
                    end
                    else if(BCD0 != 4'b0000)    BCD0 <= BCD0 - 1;
                    else begin
                        BCD0 <= 0; BCD1 <= 0;
                    end
                end 
                else
                begin
                    RSTCount <= 0;
                end
            end
        endcase
    end

    assign seg7disp1 = seg7Rom[BCD1];
    assign seg7disp0 = seg7Rom[BCD0];
endmodule

module SyncDebouncer(clk, in, out);
    input clk, in;
    output out;
    wire q1;
    DFF d1(.clk(clk), .d(in), .q(q1));
    DFF d2(.clk(clk), .d(q1), .q(out));
endmodule

module SinglePulser(clk, press, sp);
    input clk, press;
    output sp;
    wire syncpress, q;
    SyncDebouncer sd(.clk(clk), .in(press), .out(syncpress));
    DFF d3(.clk(clk), .d(syncpress), .q(q));
    assign sp = ~q & syncpress;
endmodule

module DFF(clk, d, q);
    input clk, d;
    output reg q;
    always @(posedge clk) q <= d;
endmodule

module SPScoreBoardController(CLK, INC, DEC, RESET, seg7disp0, seg7disp1);
    input CLK, INC, DEC, RESET;
    output [6:0] seg7disp0, seg7disp1;
    
    wire SPINC, SPDEC, SDRESET;

    
    SinglePulser INCSP(.clk(CLK), .press(INC), .sp(SPINC));
    SinglePulser DECSP(.clk(CLK), .press(DEC), .sp(SPDEC));
    SyncDebouncer RESETSD(.clk(CLK), .in(RESET), .out(SDRESET));
    ScoreBoardController SBController(.CLK(CLK), .INC(SPINC), .DEC(SPDEC), .RESET(SDRESET), .seg7disp0(seg7disp0), .seg7disp1(seg7disp1));
endmodule