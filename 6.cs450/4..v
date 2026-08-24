module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    parameter SNT=2'b00, WNT=2'b01, WT=2'b10, ST=2'b11;
    reg [1:0] next_state, PHT[0:127]; //create 128 2 bit wide array eg: PHT[0], PHT[1], PHT[3],...etc are 2 bit wide
    integer i;
    always @(*) begin
        case (PHT[train_history ^ train_pc])
            SNT: next_state=train_taken?WNT:SNT;
            WNT: next_state=train_taken?WT:SNT;
            WT: next_state=train_taken?ST:WNT;
            ST: next_state=train_taken?ST:WT;  
            default: next_state=WNT;
        endcase
    end
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            predict_history <= 7'b0;
            for (i=0; i<128; i=i+1)
                PHT[i] <= WNT;
        end
        else begin
            PHT[train_pc^train_history] <= train_valid?next_state:PHT[train_pc^train_history];
            if (train_valid && train_mispredicted)
                predict_history <= {train_history[5:0], train_taken};
            else if (predict_valid)
                predict_history <= {predict_history[5:0], predict_taken};
        end
    end
    assign predict_taken = PHT[predict_pc^predict_history][1]; //corresponds to (predict_pc^GHR)th out of 128 PHT's MSB
endmodule