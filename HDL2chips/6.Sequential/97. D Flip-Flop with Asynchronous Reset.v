module dff_async_rst(
    input  clk,
    input  arst,
    input  d,
    output reg q
);
    // Write your RTL here
    // Remember: arst is ASYNCHRONOUS — must be included in sensitivity list!
    always @(posedge clk, posedge arst) begin
        if (arst)
            q <= 0;
        else
            q <= d;
    end
endmodule