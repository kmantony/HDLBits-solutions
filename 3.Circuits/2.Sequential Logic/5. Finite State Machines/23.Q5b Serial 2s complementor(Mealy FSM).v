module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A=0, B=1;
    reg state, next_state;
    always @(*) begin
        case (state)
            A: begin
                if (x) begin
                    next_state = B;
                    z = 1'b1;
                end
                else begin
                    next_state = A;
                    z = 1'b0;
                end
            end
            B: begin
                if (x) begin
                    next_state = B;
                    z = 1'b0;
                end
                else begin
                    next_state = B;
                    z = 1'b1;
                end
            end
        endcase
    end
    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
endmodule
