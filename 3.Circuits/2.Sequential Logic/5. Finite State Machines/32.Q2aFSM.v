module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    //PARAMETERS
    parameter A=0, B=1, C=2, D=3;
    reg [1:0] state, next_state;
    
    //STATE TRANSITION
    always @(*) begin
        case (state)
            A: next_state = (r==3'b000)? A:((r==3'b100)?D:(({r[2],r[1]}==2'b10)?C:(r[1]?B:A))); 
            B: next_state = r[1]? B:A;
            C: next_state = r[2]? C:A;
            D: next_state = r[3]? D:A;
            default: next_state = A;
        endcase
    end
    //FLIPFLOP
    always @(posedge clk) begin
        state <= resetn? next_state:A;
    end
    //OUTPUT
    assign g[1] = (state==B);
    assign g[2] = (state==C);
    assign g[3] = (state==D);
endmodule