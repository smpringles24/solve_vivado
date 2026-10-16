module TLC4stateMainUnit (CLK, Sa, Sb, Ga, Ya, Ra, Gb, Yb, Rb, T50, T40, clr);
    input CLK, Sa, Sb, T50, T40;
    output reg Ga, Ya, Ra, Gb, Yb, Rb, clr;
    reg [1:0] state = 0, nextstate = 0;

    localparam GA = 2'd0, YA = 2'd1, GB = 2'd2, YB = 2'd3;

    always@(*) begin
        Ga = 0; Ya = 0; Ra = 0;
        Gb = 0; Yb = 0; Rb = 0;
        clr = 0;
        nextstate = state;

        case(state)
            GA:
            begin
                Ga = 1; Rb = 1;
                if(T50 && Sb) begin
                    nextstate = YA; 
                end
            end

            YA:  
            begin
                Ya = 1; Rb = 1;
                clr = 1;
                nextstate = GB;
            end

            GB:  
            begin
                Ra = 1; Gb = 1;
                if(T40 && (Sa || !Sb)) begin
                    nextstate = YB;
                end
            end

            YB:  
            begin
                Ra = 1; Yb = 1;
                clr = 1;
                nextstate = GA;
            end
        endcase
    end

    always @(posedge CLK) begin
        state <= nextstate;
    end
endmodule

module timer (CLK, clr, T50, T40);
    input CLK, clr;
    output T50, T40;
    reg [2:0] count = 0;

    always@(posedge CLK) begin
        if (clr)                count <= 3'b000;
        else if (count < 7)     count <= count + 1;
    end

    assign T40 = (count >= 3'b100);
    assign T50 = (count >= 3'b101);
endmodule

module TLC4(CLK, Sa, Sb, Ga, Ya, Ra, Gb, Yb, Rb);
    input CLK, Sa, Sb;
    output Ga, Ya, Ra, Gb, Yb, Rb;
    wire clr, T50, T40;

    TLC4stateMainUnit mainUnit(.CLK(CLK), .Sa(Sa), .Sb(Sb), .clr(clr), .T50(T50), .T40(T40), .Ga(Ga), .Ya(Ya), .Ra(Ra), .Gb(Gb), .Yb(Yb), .Rb(Rb));
    timer tim(.CLK(CLK), .clr(clr), .T50(T50), .T40(T40));
endmodule