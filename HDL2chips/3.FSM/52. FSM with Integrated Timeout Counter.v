module fsm_timeout_counter (
    input  wire clk,
    input  wire rst_n,
    input  wire in,
    output reg  out,
    output reg  timeout
);
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;

    reg [1:0] state, next_state;
    reg [1:0] cnt;
    
    // Implement FSM with Integrated Timeout Counter
    always @(*) begin
        case (state)
            S0: begin
                next_state = in?S1:S0;
                out = 1'b0;
                timeout = 1'b0;
            end
            S1: begin
                if (in)
                    next_state = (cnt==2'b10)? S2:S1;
                else 
                    next_state = S0;
				out = 1'b1;
                timeout = 1'b0;
            end
            S2: begin
                next_state = S0;
                out = 1'b0;
                timeout = 1'b1;
            end
            default: begin
                next_state = S0;
                out = 1'b0;
                timeout = 1'b0;
            end
        endcase
    end
    
    always @ (posedge clk, negedge rst_n) begin
        if (!rst_n) begin
			state <= S0;
			cnt <= 2'b00;
        end
        else begin
            state <= next_state;
            if (state == S1)
                cnt <= cnt + 1'b1;
            else 
                cnt <= 2'b00;
        end      
    end
endmodule