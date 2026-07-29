module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    // parameter LEFT, RIGHT, FALL
    parameter LEFT = 0, RIGHT =1, FALL_L =2, FALL_R =3, DIG_L =4, DIG_R =5, SPLAT =6;
    reg [2:0] state, next_state;
    integer i;

    always @(*) begin
        // State transition logic
        case (state)
            LEFT: next_state = ground? (dig? DIG_L :(bump_left? RIGHT:LEFT)) :FALL_L;       
            RIGHT: next_state = ground? (dig? DIG_R :(bump_right? LEFT:RIGHT)) :FALL_R; 
            FALL_L: next_state = ground? (i >= 20? SPLAT: LEFT) :FALL_L;         
            FALL_R: next_state = ground? (i >= 20? SPLAT: RIGHT): FALL_R;
            DIG_L:  next_state = ground? DIG_L :FALL_L;
            DIG_R:  next_state = ground? DIG_R :FALL_R;
            SPLAT: next_state = SPLAT;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) begin 
            state <= LEFT;
        end
        else if (state == FALL_L || state == FALL_R) begin
            state <= next_state;
            i <= i+1;
        end
        else begin
            state <= next_state;
            i <= 0;
        end
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign digging = ((state == DIG_R) || (state == DIG_L) ); 
    assign aaah = ((state == FALL_R) || (state == FALL_L) );
 
endmodule