module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
	//PARAMETERS
    parameter byte1=0, byte2=1, byte3=2, DONE=3;
    reg [1:0] next_state, state;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            byte1: next_state = in[3]? byte2:byte1;
            byte2: next_state = byte3;
            byte3: next_state = DONE;
            DONE: next_state = in[3]? byte2:byte1;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        state <= reset? byte1:next_state;
    end
            
    // Output logic
    assign done = (state == DONE);

endmodule