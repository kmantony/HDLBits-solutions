module top_module ();
    reg clk, reset, t, q;
    initial clk = 0;
    always begin
        #5; clk = ~clk;
    end
    initial begin
        reset=0;t=0;#10;
        reset=1;t=0;#10;
        reset=0;t=1;
    end
    tff inst1(clk, reset, t, q);
endmodule