module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss);
    wire enam, enah;
    assign enam = (ss == 8'h59) && ena;
    assign enah = (mm == 8'h59) && enam;
    count0to59 instance1 (clk, reset, ena,ss);
    count0to59 instance2 (clk, reset, enam, mm);
    count0to12 instance3 (clk, reset, enah, hh);
    always @(posedge clk) begin
        if (reset) pm <= 0;
        else begin
            if ((hh == 8'h11) && enah) pm <= ~pm;
        end
    end
endmodule

module count0to59 (input clk, input reset,input ena, output [7:0] q);
	wire ena1;
    assign ena1 = (q[3:0] == 4'h9) && ena;
    count0to9 instance1 (clk, reset, ena, q[3:0]);
    count0to5 instance2 (clk, reset, ena1, q[7:4]);
endmodule

module count0to12 (input clk, input reset, input ena, output [7:0] q);
    always @(posedge clk) begin
        if (reset) begin q <= 8'h12; end
        else begin
            if (ena) begin 
                if (q == 8'h12) begin q <= 8'h1; end
                else begin 
                    if (q == 8'h9) begin q <= 8'h10; end
                    else begin q++; end
                end
            end
        end
    end
endmodule

module count0to9 (input clk, input reset,input ena, output [3:0] q);
    always @(posedge clk) begin
        if (reset) begin q <= 0; end
        else begin
            if (ena) begin 
                if (q == 4'h9) begin q <= 0; end
                else begin q++; end
            end
        end
    end
endmodule

module count0to5 (input clk, input reset,input ena, output [3:0] q);
    always @(posedge clk) begin
        if (reset) begin q <= 0; end
        else begin
            if (ena) begin 
                if (q == 4'd5) begin q <= 0; end
                else begin q++; end
            end
        end
    end
endmodule