module clock_gating_icg (
    input  clk,
    input  en,
    input  test_mode,
    output gated_clk
);
    reg latch;
    always @(*) begin
        if (~clk)
            latch = en|test_mode;
    end
    assign gated_clk = clk&latch;
endmodule