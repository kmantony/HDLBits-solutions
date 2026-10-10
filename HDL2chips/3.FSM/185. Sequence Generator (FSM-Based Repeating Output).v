module seq_gen (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       en,
    output reg  [3:0] out,
    output reg        start
);
    // Design your own states and transitions to produce the repeating
    // output sequence. out and start must be Moore-style outputs
    // (a function of the current state only).
    reg [2:0] state, next_state;
    
    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100;
    localparam S5 = 3'b101;
    
    always @(*) begin
        case (state)
            S0: begin
                next_state = en?S1:S0;
                start = 1'b1;
                out = 4'b1010;
            end
            S1: begin
                next_state = en?S2:S1;
                start = 1'b0;
                out = 4'b0101;
            end
            S2: begin
                next_state = en?S3:S2;
                start = 1'b0;
                out = 4'b1100;
            end
            S3: begin
                next_state = en?S4:S3;
                start = 1'b0;
                out = 4'b0011;
            end
            S4: begin
                next_state = en?S5:S4;
                start = 1'b0;
                out = 4'b1111;
            end
            S5: begin
                next_state = en?S0:S5;
                start = 1'b0;
                out = 4'b0000;
            end
            default: begin
                next_state = en?S1:S0;
                start = 1'b1;
                out = 4'b1010;
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