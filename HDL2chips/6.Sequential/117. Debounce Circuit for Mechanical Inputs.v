module debounce_filter #(
    parameter STABLE_CYCLES = 4
)(
    input      clk,
    input      rst,
    input      btn_in,
    output reg btn_out
);
    // Write your RTL here
    reg previous_btn_in;
    reg [$clog2(STABLE_CYCLES):0] counter;
    always @(posedge clk) begin
        previous_btn_in <= btn_in;
        if (rst) begin
            btn_out <= 1'b0;
            counter <= {$clog2(STABLE_CYCLES){1'b0}};
        end
        else begin
            if (btn_in != btn_out) begin
                if (counter == STABLE_CYCLES-1) begin
                    btn_out <= btn_in;
                    counter <= {$clog2(STABLE_CYCLES){1'b0}};
                end
                else 
                    counter <= counter + 1'b1;
            end
            else 
                counter <= {$clog2(STABLE_CYCLES){1'b0}};
        end
    end
endmodule