module top_module (
    input clock,
    input a,
    output p,
    output q );
    assign p = clock?a:p;    //combinational since p changes clock is high.
    always @(negedge clock)
        q <= p;
endmodule