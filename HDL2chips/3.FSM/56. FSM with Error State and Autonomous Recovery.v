module fsm_error_recovery (
    input  wire clk,
    input  wire rst_n,
    input  wire in,
    input  wire err_in,
    output reg  out,
    output reg  err_flag
);
    localparam S0    = 2'b00;
    localparam S1    = 2'b01;
    localparam S2    = 2'b10;
    localparam S_ERR = 2'b11;

    reg [1:0] state, next_state;

    // Implement Error Recovery FSM
    always @(*) begin
        case (state)
            S0: begin
                if (err_in)
                    next_state = S_ERR;
                else
                    next_state = in?S1:S0;
                out = 1'b0;
                err_flag = 1'b0;
            end
            S1: begin
                if (err_in)
                    next_state = S_ERR;
                else
                    next_state = in?S2:S0;
                out = 1'b0;
                err_flag = 1'b0;
            end
            S2:begin
                if (err_in)
                    next_state = S_ERR;
                else
                    next_state = in?S2:S0;
                out = 1'b1;
                err_flag = 1'b0;
            end
            S_ERR: begin
                next_state = S0;
                out = 1'b0;
                err_flag = 1'b1;
            end
            default: begin
                next_state = S0;
                out = 2'b0;
                err_flag = 2'b0;
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