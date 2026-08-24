module shift_register_param #(
    parameter DEPTH = 8
)(
    input                      clk,
    input                      rst,
    input                      en,
    input                      shift_in,
    output                     shift_out,
    output reg [DEPTH-1:0]     parallel_out
);
    // Write your RTL here
    always @ (posedge clk) begin
        if (rst) begin
            parallel_out <= {DEPTH{1'b0}};
        end
        else begin
            parallel_out <= en?{parallel_out[DEPTH-2:0], shift_in}:parallel_out;
        end
    end
    assign shift_out = parallel_out[DEPTH-1];
endmodule