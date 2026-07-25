module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
    always @(negedge clk) begin
        if (reset == 0)
            q<=d;
        else 
            q<=8'h0x34;
    end
endmodule