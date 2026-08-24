module reg_alu_output #(
    parameter DATA_WIDTH = 8
)(
    input                   clk,
    input                   rst,
    input                   en,
    input  [1:0]            op,
    input  [DATA_WIDTH-1:0] a,
    input  [DATA_WIDTH-1:0] b,
    output reg [DATA_WIDTH-1:0] result,
    output reg              overflow
);
    // Write your RTL here
    reg [DATA_WIDTH:0] reg_result;
    always @(*) begin
        case (op)
            2'b00 : reg_result = a+b;
            2'b01 : reg_result = a-b;
            2'b10 : reg_result = a&b;
            2'b11 : reg_result = a|b;
        endcase
    end
    always @ (posedge clk) begin
        if (rst) begin
            result <= {DATA_WIDTH{1'b0}};
            overflow <= 1'b0;
        end
        else if (en) begin
            result <= reg_result[DATA_WIDTH-1:0];
            overflow = reg_result [DATA_WIDTH];
        end
    end
endmodule