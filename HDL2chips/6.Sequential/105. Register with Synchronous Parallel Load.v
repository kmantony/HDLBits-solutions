module reg_parallel_load #(
    parameter DATA_WIDTH = 8
)(
    input                     clk,
    input                     rst,
    input                     load,
    input  [DATA_WIDTH-1:0]   d,
    output reg [DATA_WIDTH-1:0] q
);
    // Write your RTL here
    // Remember: rst > load (synchronous reset at posedge clk)
    always @ (posedge clk) begin
        if (rst) 
            q <= {DATA_WIDTH{1'b0}};
        else 
            q <= load? d:q;
    end
endmodule