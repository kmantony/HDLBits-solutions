module dff_sync_preset_clear(
    input  clk,
    input  pre,
    input  clr,
    input  d,
    output reg q
);
    // Write your RTL here
    // Remember: clr > pre > d (all SYNCHRONOUS at posedge clk)
    always @ (posedge clk) begin 
        if (clr)
            q <= 0;
        else if (pre)
            q <= 1;
        else 
            q <= d;
    end
endmodule