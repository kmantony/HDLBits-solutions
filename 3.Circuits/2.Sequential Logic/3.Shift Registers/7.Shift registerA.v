module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
	reg Q1, Q2, Q3;
    always @(posedge clk) begin
        if (resetn) begin
            {Q1, Q2, Q3, out} <= {in, Q1, Q2, Q3};
        end
        else begin
            {Q1, Q2, Q3, out} <= 0;
        end
    end
endmodule
