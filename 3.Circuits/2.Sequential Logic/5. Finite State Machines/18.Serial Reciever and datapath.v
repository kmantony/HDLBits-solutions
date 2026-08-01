module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //PARAMETERS
    parameter idle=0, start=1, data1=2, data2=3, data3=4, data4=5, data5=6, data6=7, data7=8, data8=9, waitstop=10, stop=11;
    reg [3:0] i, next_state, state;

    // Use FSM from Fsm_serial
        //STATE TRANSITIOON LOGIC
    always @(*) begin
        case (state)
            idle: next_state = in? idle:start;
            start: next_state = data1;
            data1: next_state = data2;
            data2: next_state = data3;
            data3: next_state = data4;
            data4: next_state = data5;
            data5: next_state = data6;
            data6: next_state = data7;
            data7: next_state = data8;
            data8: next_state = in? stop:waitstop;
            waitstop: next_state = in? idle:waitstop;
            stop: next_state = in? idle:start;
        endcase
    end
    
	//FLIP FLOP 
    always @(posedge clk)begin
        state <= reset? idle:next_state;
    end
    
    //OUTPUT LOGIC
    assign done = (state == stop);

    // New: Datapath to latch input bits.
    always @(posedge clk) begin
        if (reset) begin
            out_byte <= 8'b0;
        end
        else begin
            case (next_state)
                data1: out_byte[0] <= in;
                data2: out_byte[1] <= in;
                data3: out_byte[2] <= in;
                data4: out_byte[3] <= in;
                data5: out_byte[4] <= in;
                data6: out_byte[5] <= in;
                data7: out_byte[6] <= in;
                data8: out_byte[7] <= in;
            endcase
        end
    end
endmodule