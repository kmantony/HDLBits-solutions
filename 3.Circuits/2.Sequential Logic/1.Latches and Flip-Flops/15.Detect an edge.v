module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0] old = 0; 
    integer i;
    always @(posedge clk) begin
        for (i=0; i<=7;i++) begin
            if (old[i]==0 && in[i])
                pedge[i] <= 1;
            else
                pedge[i] <= 0;
        end
        old<=in;
    end
endmodule