module fsm_param_states #(
    parameter NUM_STATES = 4
)(
    input  wire clk,
    input  wire rst_n,
    input  wire in,
    output reg  out
);
    localparam STATE_WIDTH = $clog2(NUM_STATES);

    reg [STATE_WIDTH-1:0] state, next_state;

    // Implement Parameterized FSM
    always @(*) begin
        if (state == {STATE_WIDTH{1'b0}}) begin                            //STATE 0
            next_state = in?{{STATE_WIDTH-1{1'b0}},1'b1}:{STATE_WIDTH{1'b0}};
            out = 1'b0;
        end
        else if (state == (NUM_STATES-1)) begin                         //FINAL STATE
            next_state = in?NUM_STATES-1:{STATE_WIDTH{1'b0}};
            out = 1'b1;
        end
        else if (state < (NUM_STATES-1)) begin               //STATES 1 to NUM_STATES-2
            next_state = state + 1; 
            out = 1'b0;
        end
        else begin                                       //DEFAULT
            next_state = {STATE_WIDTH{1'b0}};
            out = 1'b0;
        end
    end
            
    always @(posedge clk, negedge rst_n) begin
        if (!rst_n)
            state <= {STATE_WIDTH{1'b0}};
        else
            state <= next_state;
    end
endmodule