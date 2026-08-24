module reg_output_hold #(
    parameter DATA_WIDTH = 8
)(
    input                   clk,
    input                   rst,
    input                   valid,
    input  [DATA_WIDTH-1:0] d,
    output reg [DATA_WIDTH-1:0] q
);
    // Write your RTL here
    always @(posedge clk) begin
        if (rst)
            q <= 0;
        else 
            q <= valid? d:q;
    end
endmodule