module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    assign ena[1] = q[3:0] == 4'd9 ;
    assign ena[2] = (q[3:0] == 4'd9) && (q[7:4] == 4'd9);
    assign ena[3] = (q[3:0] == 4'd9) && (q[7:4] == 4'd9) && (q[11:8] == 4'd9);
    BCD_adder instance0 (clk, reset, 1, q[3:0]);
    BCD_adder instance1 (clk, reset, ena[1], q[7:4]);
    BCD_adder instance2 (clk, reset, ena[2], q[11:8]);
    BCD_adder instance3 (clk, reset, ena[3], q[15:12]);
endmodule

module BCD_adder (input clk, input reset,input ena, output [3:0] q);
    always @(posedge clk) begin
        if (reset) begin q <= 0; end
        else begin
            if (ena) begin 
                if (q == 4'd9) begin q <= 0; end
                else begin q++; end
            end
        end
    end
endmodule