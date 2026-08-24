module reg_self_clear #(
    parameter DATA_WIDTH   = 8,
    parameter CLEAR_CYCLES = 4
)(
    input                       clk,
    input                       rst,
    input                       load,
    input  [DATA_WIDTH-1:0]     d,
    output reg [DATA_WIDTH-1:0] q,
    output reg                  active
);
    // Write your RTL here
    reg [$clog2(CLEAR_CYCLES):0] COUNT_clk;
    always @(posedge clk) begin
        if (rst) begin
            q <= {DATA_WIDTH{1'b0}};
            active <= 1'b0;
            COUNT_clk <= {$clog2(CLEAR_CYCLES){1'b0}};
        end
        else if (load) begin
            q <= d;
            if (d != {DATA_WIDTH{1'b0}})
                active <= 1'b1;
            else
                active <= 1'b0;
        end
        else if (active) begin
            if (COUNT_clk == CLEAR_CYCLES-1) begin
                q <= {DATA_WIDTH{1'b0}};
                active <= 1'b0;
                COUNT_clk <= {$clog2(CLEAR_CYCLES){1'b0}};
            end
            else
                COUNT_clk <= COUNT_clk + 1'b1;
        end 
    end
endmodule