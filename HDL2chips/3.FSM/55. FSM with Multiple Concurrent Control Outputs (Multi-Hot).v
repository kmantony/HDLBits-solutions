module fsm_multi_outputs (
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    output reg  busy,
    output reg  rd_en,
    output reg  wr_en
);
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    localparam S3 = 2'b11;

    reg [1:0] state, next_state;

    // Implement Multi-Output FSM
    always @(*) begin
        case (state) 
            S0: begin
                next_state = start?S1:S0;
                busy = 1'b0;
                rd_en = 1'b0;
                wr_en = 1'b0;
            end
            S1: begin
                next_state = S2;
                busy = 1'b1;
                rd_en = 1'b1;
                wr_en = 1'b0;
            end
            S2: begin
                next_state = S3;
                busy = 1'b1;
                rd_en = 1'b0;
                wr_en = 1'b0;
            end
            S3: begin
                next_state = S0;
                busy = 1'b1;
                rd_en = 1'b0;
                wr_en = 1'b1;
            end
            default: begin
                next_state = S0;
                busy = 1'b0;
                rd_en = 1'b0;
                wr_en = 1'b0;
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