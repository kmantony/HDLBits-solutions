module dff_sync_rst(
    input  clk,
    input  rst,
    input  d,
    output reg q
);
    // Write your RTL here
    // Remember: rst is SYNCHRONOUS — only checked at rising edge of clk
    always @ (posedge clk) begin
        if (rst)
            q <= 0;
        else 
            q <= d;
    end
endmodule