module edge_detect_dual (
    input  clk,
    input  rst,
    input  in,
    output reg f_edge,
    output reg any_edge
);
    // Write your RTL here
    reg previous_in;
    always @ (posedge clk) begin
        previous_in <= in;
        if (rst) begin
            f_edge <= 1'b0;
            any_edge<= 1'b0;
            previous_in <= 1'b0;
        end
        else begin
            f_edge <= (in==1'b0) && (previous_in==1'b1);
            any_edge <= (in != previous_in);
            previous_in <= in;
        end
    end
endmodule