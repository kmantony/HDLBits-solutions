module reg_majority_vote #(
    parameter DATA_WIDTH = 8
)(
    input                   clk,
    input                   rst,
    input                   en,
    input  [DATA_WIDTH-1:0] in_a,
    input  [DATA_WIDTH-1:0] in_b,
    input  [DATA_WIDTH-1:0] in_c,
    output reg [DATA_WIDTH-1:0] q,
    output reg              fault_detected
);
    // Write your RTL here
    always @(posedge clk) begin
        if (rst) begin
            q <= 0;
            fault_detected <= 0; 
        end
        else begin
            if (en) begin
                q <= (in_a & in_b) | (in_b & in_c) | (in_a & in_c);
                fault_detected <= ((in_a != in_b) || (in_b != in_c) || (in_a != in_c))? 1:0;
            end
            else begin
                q <= q;
                fault_detected <= fault_detected;
            end
        end
        end
endmodule