module fifo_ptr_gray_sync #(
    parameter ADDR_WIDTH = 4
)(
    input                  src_clk,
    input                  src_rst,
    input                  src_incr,
    input                  dest_clk,
    input                  dest_rst,
    output reg	[ADDR_WIDTH:0]  src_ptr_gray,
    output reg	[ADDR_WIDTH:0]  dest_ptr_gray_sync
);
    // Write your RTL here
    wire [ADDR_WIDTH:0] incremented_gray;
    reg [ADDR_WIDTH:0] sum_gray, ff1;
    assign incremented_gray = sum_gray + src_incr;
    always @(posedge src_clk) begin
        if (src_rst) begin
            sum_gray <= {(ADDR_WIDTH+1){1'b0}};
            src_ptr_gray <= {(ADDR_WIDTH+1){1'b0}};
        end
        else begin
            sum_gray <= incremented_gray;
            src_ptr_gray <= incremented_gray ^ {1'b0, incremented_gray[ADDR_WIDTH:1]};  //CONVERTION TO GRAY CODE
        end
    end
    always @(posedge dest_clk) begin
        if (dest_rst) begin
            ff1 <= {(ADDR_WIDTH+1){1'b0}};
            dest_ptr_gray_sync <= {(ADDR_WIDTH+1){1'b0}};
        end
        else begin
            ff1 <= src_ptr_gray; 
            dest_ptr_gray_sync <= ff1;
        end
    end 
endmodule
