module TrafficLightController(CLK, Sa, Sb, Ga, Ya, Ra, Gb, Yb, Rb);
    input CLK, Sa, Sb;
    output reg Ga, Ya, Ra, Gb, Yb, Rb;

    reg [3:0] state = 0;

    always@(posedge CLK) begin
        case(state)
            0, 1, 2, 3, 4:      state <= state + 1;
            5:                  if (Sb)    state <= state + 1;
            6:                  state <= 7;
            7, 8, 9, 10:        state <= state + 1;
            11:                 if (Sa || !Sb)  state <= 12;
            12:                 state <= 0;
            default:            state <= 0;
        endcase
    end

        always@(*) begin
        Ga = 0; Ya = 0; Ra = 0;
        Gb = 0; Yb = 0; Rb = 0;

        case(state)
            0, 1, 2, 3, 4:      begin Ga = 1; Rb = 1; end
            5:                  begin Ga = 1; Rb = 1; end
            6:                  begin Ya = 1; Rb = 1; end
            7, 8, 9, 10:        begin Ra = 1; Gb = 1; end
            11:                 begin Ra = 1; Gb = 1; end
            12:                 begin Ra = 1; Yb = 1; end
            default:            begin Ra = 1; Rb = 1; end // 예외 상황
        endcase
    end
endmodule