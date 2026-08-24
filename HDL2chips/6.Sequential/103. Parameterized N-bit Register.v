module reg_nbit #(
    parameter DATA_WIDTH = 8
)(
    input                     clk,
    input                     rst,
    input                     en,
    input  [DATA_WIDTH-1:0]   d,
    output reg [DATA_WIDTH-1:0] q
);
    // Write your RTL here
    // Remember: rst > en (synchronous reset at posedge clk)
    always @ (posedge clk) begin
        if (rst)
            q <= {DATA_WIDTH{1'b0}};
        else 
            q <= en? d:q;
    end
endmodule