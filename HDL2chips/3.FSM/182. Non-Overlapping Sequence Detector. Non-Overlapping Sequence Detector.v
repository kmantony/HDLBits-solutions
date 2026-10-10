module seq_det_1101_noverlap (
    input  wire clk,
    input  wire rst_n,
    input  wire in,
    output reg  out
);
    // Design your own states and transitions to detect 1101 with
    // NO overlap allowed: after a full match, restart the search
    // from scratch. out must be registered (Moore-style), asserted
    // for one cycle per match.
    reg [2:0] state, next_state;
    
    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100;
    
    always @(*) begin
        case (state)
            S0: next_state = in?S1:S0;
            S1: next_state = in?S2:S0;
            S2: next_state = in?S2:S3;
            S3: next_state = in?S4:S0;
            S4: next_state = in?S1:S0;
            default: next_state = S0;
        endcase
    end
    
    always @(posedge clk, negedge rst_n) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end
    
    always @(*) begin
        if (state == S4)
            out = 1'b1;
        else
            out = 1'b0;
    end
    
endmodule