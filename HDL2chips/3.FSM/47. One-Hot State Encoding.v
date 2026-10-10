module fsm_onehot_3state #(
    parameter STATE_WIDTH = 2
)(
    input  wire clk,
    input  wire rst_n,
    input  wire in,
    output reg  out
);
    localparam [STATE_WIDTH-1:0] S0 = 2'b00;
    localparam [STATE_WIDTH-1:0] S1 = 2'b01;
    localparam [STATE_WIDTH-1:0] S2 = 2'b10;

    reg [STATE_WIDTH-1:0] state, next_state;

    // Implement Parameterized Binary FSM
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
                next_state = in? S2:S0;
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
            state <=S0;
    end
endmodule