module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
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

    // New: Datapath to store incoming bytes.
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
        end
        else begin
            case (state)
                byte1: out_bytes[23:16] <= in;
                byte2: out_bytes[15:8] <= in;
                byte3: out_bytes[7:0] <= in;
                DONE: out_bytes[23:16] <= (in[3])? in:out_bytes[23:16];
            endcase
        end
    end 
endmodule