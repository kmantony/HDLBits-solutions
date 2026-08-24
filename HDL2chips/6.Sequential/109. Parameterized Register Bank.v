module reg_bank #(
    parameter NUM_REGS = 4,
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = $clog2(NUM_REGS)
)(
    input                      clk,
    input                      rst,
    input                      w_en,
    input     [ADDR_WIDTH-1:0] w_addr,
    input    [DATA_WIDTH-1:0] w_data,
    input     [ADDR_WIDTH-1:0] r_addr,
    output   [DATA_WIDTH-1:0] r_data
);
    // Write your RTL here
	integer i;
    reg [DATA_WIDTH-1:0] temp_reg [NUM_REGS-1:0];
    always @ (posedge clk) begin
        if (rst) begin
            for (i=0; i<NUM_REGS; i++) begin
                temp_reg[i] <= {DATA_WIDTH{1'b0}};
            end
        end
        else if (w_en) 
            temp_reg[w_addr] <= w_data;
    end
    assign r_data = temp_reg[r_addr];
endmodule