module fsm_output_override (
    input  wire clk,
    input  wire rst_n,
    input  wire in,
    input  wire override,
    output reg  out
);
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;

    reg [1:0] state, next_state;

    // Implement Output Override FSM
    always @(*) begin
        case (state)
            S0: begin
                next_state = in?S1:S0;
                out = override?1'b1:1'b0;
            end
            S1: begin
                next_state = in?S2:S0;
                out = override?1'b1:1'b0;
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
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end
endmodule