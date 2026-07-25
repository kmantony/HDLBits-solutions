module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] old; integer i;
    always @(posedge clk) begin
        if (reset) begin
            out<=0;
        end
        else begin
            for (i=0; i<=31; i++) begin
                if (old[i]==1'b1 && in[i]==1'b0) begin
                    out[i] <= 1'b1; 
                end
            end
        end
        old<=in;
    end
endmodule