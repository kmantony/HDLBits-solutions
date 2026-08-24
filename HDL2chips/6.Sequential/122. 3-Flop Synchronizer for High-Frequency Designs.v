module cdc_sync_3ff #(
    parameter RESET_VAL = 1'b0
)(
    input  destination_clk,
    input  destination_rst,
    input  async_in,
    output sync_out
);
    // Write your RTL here
    reg sync_ff1, sync_ff2, sync_ff3;
    always @(posedge destination_clk) begin
        if (destination_rst) begin
            sync_ff1 <= RESET_VAL;
            sync_ff2 <= RESET_VAL;
            sync_ff3 <= RESET_VAL;
        end
        else begin
            sync_ff1 <= async_in;
            sync_ff2 <= sync_ff1;
            sync_ff3 <= sync_ff2;
        end
    end
    assign sync_out = sync_ff3;
endmodule