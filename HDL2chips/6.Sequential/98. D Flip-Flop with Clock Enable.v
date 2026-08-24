module dff_clk_enable(
    input  clk,
    input  rst,
    input  en,
    input  d,
    output reg q
);
    // Write your RTL here
    // Remember: rst is SYNCHRONOUS and has priority over en
    always @(posedge clk) begin 
        if (rst)
            q <= 0;
        else begin
            if (en) 
                q <= d;
            else
                q <= q;
        end
    end
endmodule