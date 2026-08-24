module negedge_dff(
    input  clk,
    input  rst,
    input  d,
    output reg q
);
    // Write your RTL here
    // Remember: Trigger exclusively on negedge clk!
    always @ (negedge clk) begin 
        if (rst)
            q <= 0;
        else 
            q<= d;
    end
endmodule