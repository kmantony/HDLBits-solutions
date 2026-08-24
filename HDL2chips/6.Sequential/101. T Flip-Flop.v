module t_flipflop(
    input  clk,
    input  rst,
    input  t,
    output reg q
);
    // Write your RTL here
    // Remember: rst is SYNCHRONOUS and has priority over t
    always @(posedge clk) begin
        if (rst)
            q <= 0;
        else 
            q <= t?~q:q;
    end
endmodule