module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    //PARAMETERS
    parameter A=0, monitorx=2, x1=3, x2=4, x3=5, monitory=6, y0=7, y1=8, y2=9;
    reg [3:0] state, next_state;
    //STATE TRANSITION
    always @(*) begin
        case (state) 
            A: next_state = monitorx;
            monitorx: next_state = x1;
            x1:next_state = x?x2:x1;
            x2:next_state = x?x2:x3;
            x3:next_state = x?monitory:x1;
            monitory:next_state = y?y1:y0;
            y0:next_state = y?y1:y2;
            y1:next_state = y1;
            y2:next_state = y2;
            default: next_state = A;
        endcase
    end
    //FLIPFLOP
    always @(posedge clk) begin
        if (resetn)
            state <= next_state;
        else
            state <= A;
    end
    //OUTPUT
    assign f = (state==monitorx);
    assign g = (state==monitory) || (state==y1) || (state==y0);          
endmodule