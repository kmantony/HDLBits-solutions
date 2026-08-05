module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    //PARAMETERS
    parameter S0=0, S1=1, S2=3;
    reg [1:0] state, next_state;
    
    //STATE TRANSITION
    always @(*) begin
        case (state)
            S0: 
                begin
                    next_state = x?S1:S0;
                    z = 1'b0;
                end
            S1:
                begin
                    next_state = x? S1:S2;
                    z = 1'b0;
                end
            S2: 
                begin
                    if (x) begin
                        next_state = S1;
                        z = 1'b1;
                    end
                    else begin
                        next_state = S0;
                        z = 1'b0;
                    end
                end
        endcase
    end
    
    //FLIPFLOP
    always @(posedge clk, negedge aresetn) begin  //ASYNCHRONOUS
        if (~aresetn)                             //ACTIVE LOW
            state <= S0;
        else
            state <= next_state;
    end
endmodule