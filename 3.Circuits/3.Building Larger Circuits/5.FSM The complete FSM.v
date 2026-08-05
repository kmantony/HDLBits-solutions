module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    //PARAMETERS
    parameter data1=0, data2=1, data3=2, data4=3, SENA1=4, SENA2=5, SENA3=6, SENA4=7, COUNTING=8, DONE=9;
    reg [3:0] state, next_state;
    //STATE TRANSITION
    always @(*) begin
        case (state)
            data1: next_state = data?data2:data1;
            data2: next_state = data?data3:data1;
            data3: next_state = data?data3:data4;
            data4: next_state = data?SENA1:data1;
            SENA1: next_state = SENA2;
            SENA2: next_state = SENA3;
            SENA3: next_state = SENA4;
            SENA4: next_state = COUNTING;
            COUNTING: next_state = done_counting?DONE:COUNTING;
            DONE: next_state = ack?data1:DONE;
            default: next_state = data1;
        endcase
    end
    //FLIP-FLOP
    always @(posedge clk) begin
        if (reset)
            state <= data1;
        else
            state <= next_state;
    end
    //OUTPUT
    assign shift_ena = (state==SENA1) || (state==SENA2) || (state==SENA3) || (state==SENA4);
    assign counting = (state == COUNTING);
    assign done = (state==DONE);

endmodule