module fsm_output_coded (
    input  wire clk,
    input  wire rst_n,
    input  wire in,
    output wire out_a,
    output wire out_b
);
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;

    reg [1:0] state, next_state;

    // Implement Output-Coded FSM
    always @(*) begin
        case (state) 
            S0: next_state = in?S1:S0;
            S1: next_state = in?S2:S0;
            S2: next_state = in?S2:S0;
            default: next_state = S1;
        endcase
    end
    
    always @ (posedge clk, negedge rst_n) begin
        if (rst_n)
            state <= next_state;
        else
            state <= S0;
    end
    
    assign out_a = (state==S1);
    assign out_b = (state==S2);
endmodule