module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); 
    genvar i;
    generate
        for (i=0; i<=3; i=i+1) begin: DFF
            if (i == 3) 
                MUXDFF inst(KEY[0], KEY[3], SW[3], KEY[1], KEY[2], LEDR[3]);
            else 
                MUXDFF inst(KEY[0], LEDR[i+1], SW[i], KEY[1], KEY[2], LEDR[i]);
        end
    endgenerate
endmodule

module MUXDFF (input clk, w, R, E, L, 
               output Q);
    always @(posedge clk)
        Q<= E?(L?R:w):(L?R:Q);
endmodule