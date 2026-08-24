module reg_forwarding_bypass #(
    parameter DATA_WIDTH = 8
)(
    input                   clk,
    input                   rst,
    input                   write_en,
    input                   bypass_en,
    input  [DATA_WIDTH-1:0] d,
    input  [DATA_WIDTH-1:0] bypass_data,
    output [DATA_WIDTH-1:0] q
);
    // Write your RTL here
    reg [DATA_WIDTH-1:0] reg_q;
    always @ (posedge clk) begin
        if (rst)
            reg_q <= {DATA_WIDTH{1'b0}};
        else if (write_en)
            reg_q <= d;
    end
    assign q = bypass_en? bypass_data : reg_q;
endmodule