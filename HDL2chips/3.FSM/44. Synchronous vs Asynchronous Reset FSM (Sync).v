module fsm_reset_sync (
    input  wire clk,
    input  wire rst,
    input  wire in,
    output reg  out
);
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;

    reg [1:0] state, next_state;

    // Implement FSM with Synchronous Reset
    //STATE TRANSITION
    always @(*) begin
        case (state)
            S0: begin
                out = 1'b0;
                next_state = in?S1:S0;
            end
            S1: begin
                out = 1'b0;
                next_state = in?S2:S0;
            end
            S2: begin
                out = 1'b1;
                next_state = in?S2:S0;
            end
        endcase
    end
    
    //FLIPFLOP
    always @(posedge clk) begin
        if (rst) 
            state <= S0;
        else 
            state <= next_state;
    end
endmodule