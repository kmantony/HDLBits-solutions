module seq_det_1101 (
    input  wire clk,
    input  wire rst_n,
    input  wire in,
    output reg  out
);
    // Design your own states and transitions to detect 1101,
    // with overlapping matches allowed. out must be registered
    // (Moore-style), asserted for one cycle per match.
    reg [3:0] state, next_state;
    
    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100;
    
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
                next_state = in?S2:S3;
                out = 1'b0;
            end
            S3: begin
                next_state = in?S4:S0;
                out = 1'b0;
            end
            S4: begin
                next_state = in?S1:S0;
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