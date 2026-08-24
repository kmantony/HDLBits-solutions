module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
    reg [9:0] counter;
    always @ (posedge clk) begin
        if (load) begin
            counter <= data;
        end
        else begin
            if (counter==0)
                counter<=0;
            else
                counter<=counter-1;
        end
    end
    assign tc = (counter==9'd0);
endmodule
