module accumulator_saturating #(
    parameter DATA_WIDTH = 8
)(
    input                   clk,
    input                   rst,
    input                   clear,
    input                   en,
    input  [DATA_WIDTH-1:0] d,
    output reg [DATA_WIDTH-1:0] q,
    output reg              saturated
);
    wire [DATA_WIDTH:0] fullsum;
    assign fullsum = q + d;
    // Write your RTL here
    always @ (posedge clk) begin
        if (rst) begin
            q <= {DATA_WIDTH{1'b0}};
            saturated <= 1'b0;
        end
        else if (clear) begin
            q <= {DATA_WIDTH{1'b0}};
            saturated <= 1'b0;
        end        
        else if (en) begin
            if (fullsum[DATA_WIDTH]) begin  
                q <= {DATA_WIDTH{1'b1}};
                saturated <= 1'b1;
            end
            else begin
                q <= q + d;
                saturated <= 1'b0;
            end
        end
    end
endmodule