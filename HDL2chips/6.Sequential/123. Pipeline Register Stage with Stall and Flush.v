module pipeline_stage_stall_flush #(
    parameter DATA_WIDTH = 8
)(
    input                   clk,
    input                   rst,
    input                   stall,
    input                   flush,
    input  [DATA_WIDTH-1:0] d,
    output reg [DATA_WIDTH-1:0] q
);
    // Write your RTL here
    always @(posedge clk) begin
        if (rst) 
            q <= {DATA_WIDTH{1'b0}};
        else if (flush)
            q <= {DATA_WIDTH{1'b0}};
        else if (stall)
            q <= q;
        else 
            q <= d;
    end
endmodule