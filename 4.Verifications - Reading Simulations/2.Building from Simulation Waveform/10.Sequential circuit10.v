module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    always @(posedge clk) 
        state <= (a==b)?(a|b):state;
    assign q = (a==b)?state:~state;  //q is combinational since it changes immediatly after clock
endmodule