module history_buffer #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH      = 4
)(
    input                            clk,
    input                            rst,
    input                            push,
    input      [DATA_WIDTH-1:0]      sample_in,
    output     [DATA_WIDTH-1:0]      latest_sample,
    output     [DATA_WIDTH-1:0]      oldest_sample,
    output     [DATA_WIDTH*DEPTH-1:0] history_flat
);
    // Write your RTL here 
    reg [DATA_WIDTH*DEPTH-1:0] history_temp;
    always @(posedge clk) begin
        if (rst) begin
            history_temp <= {DATA_WIDTH*DEPTH{1'b0}};
        end
        else begin
            history_temp <= push? {history_temp[DATA_WIDTH*DEPTH-DATA_WIDTH-1:0],sample_in}:history_temp;
        end
    end
    assign latest_sample = history_temp[DATA_WIDTH-1:0];
    assign oldest_sample = history_temp[DATA_WIDTH*DEPTH-1:DATA_WIDTH*DEPTH-DATA_WIDTH];
    assign history_flat = history_temp;
endmodule