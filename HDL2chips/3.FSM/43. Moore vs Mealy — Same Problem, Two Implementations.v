module moore_vs_mealy (
    input  wire clk,
    input  wire rst_n,
    input  wire in,
    output reg  moore_out,
    output reg  mealy_out
);
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;

    reg [1:0] state, next_state;

    // Implement Moore vs Mealy FSM
	//STATE TRANSITION
    always @ (*) begin
        case (state)
            S0:
                begin
                    next_state = in?S1:S0;
                    mealy_out = 1'b0;
                    moore_out = 1'b0;
                end
            S1:
                begin
                    next_state = in?S2:S0;
                    mealy_out = in;
                    moore_out = 1'b0;
                end
            S2:
                begin
                    next_state = in?S1:S0;
                    mealy_out = 1'b0;
                    moore_out = 1'b1;
                end
            default:
                begin
                    next_state = S0;
                    mealy_out = 1'b0;
                    moore_out = 1'b0;
                end
        endcase
    end
    
    //FLIPFLOP
    always @(posedge clk) begin
        if (rst_n)
            state <= next_state;
        else
            state <= S0;
    end

endmodule