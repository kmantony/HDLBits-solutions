module top_module();
    reg clk, in;
    reg [2:0] s;
    wire out;
    initial clk=0;
    always begin 
        #5; clk = ~clk;
    end
    initial begin
        in=0;s=3'b010;#10;
        in=0;s=3'b110;#10;
        in=1;s=3'b010;#10;
        in=0;s=3'b111;#10;
        in=1;s=3'b000;#30;
        in=0;s=3'b000;
    end
    q7 inst1 (clk, in, s, out);
endmodule