module mealy_fsm (
    input  wire clk,
    input  wire rst_n,
    input  wire in,
    output reg  out
);
    localparam S0 = 1'b0;
    localparam S1 = 1'b1;

    reg state, next_state;

    // Implement Mealy FSM
    always @(*) begin
        case (state)
            S0: begin
                next_state = in?S1:S0;
                out = 1'b0;
            end
            S1: begin
                next_state = in?S1:S0;
                out = in;
            end
        endcase
    end
    
    always @(posedge clk, negedge rst_n) begin
        if (rst_n)
            state <= next_state;
        else
            state <= S0;
    end
endmodule