module seq_det_multi (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       in,
    output reg        match,
    output reg  [1:0] pat_id
);
    // Design your own states and transitions so that one shared state
    // machine watches for both patterns at once. match and pat_id must
    // be Moore-style outputs (a function of the current state only).
    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100;
    localparam S5 = 3'b101;
    localparam S6 = 3'b110;
    localparam S7 = 3'b111;
    
    reg [2:0] state, next_state;
    
    always @(*) begin
        case (state)
            S0: begin
                next_state = in?S4:S1;
                match = 1'b0;
                pat_id = 2'b00;
            end
            S1: begin 
                next_state = in?S2:S1;
                match = 1'b0;
                pat_id = 2'b00;
            end
            S2: begin
                next_state = in?S3:S1;
                match = 1'b0;
                pat_id = 2'b00;
            end
            S3: begin                       //pattern B detected
                next_state = in?S4:S5;
                match = 1'b1;
                pat_id = 2'b10;
            end
            S4: begin
                next_state = in?S4:S5;
                match = 1'b0;
                pat_id = 2'b00;
            end
            S5: begin
                next_state = in?S6:S1;
                match = 1'b0;
                pat_id = 2'b00;
            end
            S6: begin
                next_state = in?S7:S5;
                match = 1'b0;
                pat_id = 2'b00;
            end
            S7: begin                      //pattern A detected
                next_state = in?S4:S5;
                match = 1'b1;
                pat_id = 2'b01;
            end
            default: begin
                next_state = S0;
                match = 1'b0;
                pat_id = 2'b00;
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