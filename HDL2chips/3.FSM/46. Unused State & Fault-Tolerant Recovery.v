module fsm_unused_states (
    input  wire clk,
    input  wire rst_n,
    input  wire in,
    output reg  out
);
    localparam S0 = 3'b001;
    localparam S1 = 3'b010;
    localparam S2 = 3'b100;

    reg [2:0] state, next_state;

    // Implement One-Hot FSM
    always @(*) begin
        case (state)
            S0: begin 
                next_state = in?S1:S0;
                out = 1'b0;
            end
            S1: begin
                next_state = in?S2:S0;
                out = 1'b0;
            end
            S2: begin 
                next_state = in?S2:S0;
                out = 1'b1;
            end
            default: begin
                next_state = S0;
                out = 1'b0;
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