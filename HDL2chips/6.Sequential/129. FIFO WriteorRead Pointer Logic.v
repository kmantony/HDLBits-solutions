module fifo_pointer_logic #(
    parameter ADDR_WIDTH = 4
)(
    input                   clk,
    input                   rst,
    input                   wr_en,
    input                   rd_en,
    output [ADDR_WIDTH-1:0] waddr,
    output [ADDR_WIDTH-1:0] raddr,
    output                  full,
    output                  empty
);
    // Write your RTL here
    reg [ADDR_WIDTH:0] wptr, rptr;
    always @(posedge clk) begin
        if (rst) begin
            wptr <= {(ADDR_WIDTH+1){1'b0}};
            rptr <= {(ADDR_WIDTH+1){1'b0}};
        end
        else begin
            wptr <= (wr_en && ~full)? wptr+1:wptr;
            rptr <= (rd_en && ~empty)? rptr+1:rptr;
        end
    end
    assign waddr = wptr[ADDR_WIDTH-1:0];
    assign raddr = rptr[ADDR_WIDTH-1:0];
    assign empty = (wptr==rptr);
    assign full = (wptr[ADDR_WIDTH-1:0]==rptr[ADDR_WIDTH-1:0]) && (wptr[ADDR_WIDTH]!=rptr[ADDR_WIDTH]); 
endmodule