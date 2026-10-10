module moore_3proc (
    input  wire clk,
    input  wire rst_n,
    input  wire in,
    output reg  out
);
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;

    reg [1:0] state, next_state;


    // Process 1: Next State Logic (Combinational)
    always @(*) begin
        case (state)
            S0: next_state = in?S1:S0;
            S1: next_state = in?S2:S0;
            S2: next_state = in?S2:S0;
            default: next_state = S0;
        endcase
    end
    
    // Process 2: State Register (Sequential)
    always @(posedge clk, negedge rst_n) begin
        if (rst_n)
            state <= next_state;
        else
            state <= S0;
    end
    
    // Process 3: Output Logic (Combinational)
    always @ (*) begin
        if (state == S2)
            out = 1'b1;
        else 
            out = 1'b0;
    end
endmodule