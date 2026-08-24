module edge_detect_rising (
    input  clk,
    input  rst,
    input  in,
    output reg p_edge
);
    // Write your RTL here
    reg previous_in;
    always @ (posedge clk) begin
        previous_in <= in;
        if (rst) 
            p_edge <= 1'b0;
        else 
            p_edge <= (previous_in==1'b0) && (in==1'b1);
    end
endmodule