module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output reg [3:0] count,
    output counting,
    output done,
    input ack );
    //PARAMETERS
    parameter data0=0, data1=1, data2=2, data3=3, shift1=4, shift2=5, shift3=6, shift4=7, COUNT=8, DONE=9;
    reg [3:0] state, next_state;
    reg [13:0] counter; //count 0 to 1000
    //STATE TRANSITION
    always @(*) begin
        case(state) 
            data0: next_state = data?data1:data0;
            data1: next_state = data?data2:data0;
            data2: next_state = data?data2:data3;
            data3: next_state = data?shift1:data0;
            shift1:next_state=shift2;
            shift2:next_state=shift3;
            shift3:next_state=shift4;
            shift4:next_state=COUNT;
            COUNT:next_state = ((count==0) && (counter==999))?DONE:COUNT; 
            DONE: next_state=ack?data0:DONE;
            default:next_state=data0;
        endcase
    end
    //FLIPFLOP
    always @(posedge clk) begin
        if (reset) begin
            state <= data0;
            counter <= 0;
        end
        else begin
            state <= next_state;
            case(state)
                shift1: count[3]<=data;
                shift2: count[2]<=data;
                shift3: count[1]<=data;
                shift4: count[0]<=data;
                COUNT: begin                            //TIMER
                    if (counter == 999) begin
                        counter <= 0;
                        count <= count -1;
                    end
                    else begin 
                        counter <= counter + 1;
                    end
                end
            endcase
        end 
    end
    //OUTPUT 
    assign counting = (state==COUNT);
    assign done = (state==DONE);
endmodule
