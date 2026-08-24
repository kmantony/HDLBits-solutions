module dff_dual_reset (
    input  clk,
    input  async_rst,
    input  sync_rst,
    input  d,
    output reg q
);
    // Write your RTL here
    // Remember: sensitivity list must include posedge clk or posedge async_rst
    // Priority: async_rst > sync_rst
    always @ (posedge clk, posedge async_rst) begin
        if (async_rst)
            q <= 0;
        else if (sync_rst)
            q <= 0;
        else
            q <= d;
    end
endmodule