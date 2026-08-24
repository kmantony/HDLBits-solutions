module reg_shadow #(
    parameter DATA_WIDTH = 8
)(
    input                   clk,
    input                   rst,
    input                   w_en,
    input                   commit,
    input  [DATA_WIDTH-1:0] d,
    output reg [DATA_WIDTH-1:0] q
);
    // Write your RTL here
    reg [DATA_WIDTH-1:0] staging_reg;
    always @ (posedge clk) begin
        if (rst) begin
            q <= 0;
            staging_reg <= 0;
        end
        else begin
            if (w_en && commit) begin
                q <= staging_reg;
                staging_reg <= d;
            end
            else if (w_en)
                staging_reg <= d;
            else if (commit)
                q <= staging_reg;
        end
    end
endmodule