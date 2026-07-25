module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    always @(posedge clk)
        Q<= E?(L?R:w):(L?R:Q);
endmodule