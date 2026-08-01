module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A=0, B=1;
    reg state, next_state;
    reg [1:0] value, count;
    
    always @(*) begin
        case (state)
            A: next_state=s?B:A;
            B: next_state=B;
        endcase
    end
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            value=0;
            count=0;
        end
        else begin
            state <= next_state;
            if (state==B) begin
                if (count==3) begin
                    value=0;
                    count=0;
                end
                value=value+w;
                count=count+1;
            end
        end
    end
    assign z=(count==3) && (value==2);

endmodule
