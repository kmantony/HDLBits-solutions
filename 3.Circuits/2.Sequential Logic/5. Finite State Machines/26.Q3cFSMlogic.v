module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    parameter A=0, B=1, C=2,D=3, E=4;
    reg [3:0] next_state;
    always @(*) begin
        case (y)
            A: next_state = x? B:A;
            B: next_state = x? E:B;
            C: next_state = x? B:C;
            D: next_state = x? C:B;
            E: next_state = x? E:D;
            default: next_state = A;
        endcase
    end
        
    assign Y0 = next_state[0];
    assign z = (y==D) || (y==E);

endmodule
