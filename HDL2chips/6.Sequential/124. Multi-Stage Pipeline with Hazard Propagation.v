module pipeline_hazard_multistage #(
    parameter DATA_WIDTH = 8
)(
    input                   clk,
    input                   rst,
    input                   stall_stage2,
    input                   flush_stage2,
    input  [DATA_WIDTH-1:0] d,
    output reg [DATA_WIDTH-1:0] stage1_q,
    output reg [DATA_WIDTH-1:0] stage2_q
);
    // Write your RTL here
    always @ (posedge clk) begin
        if (rst) begin
            stage1_q <= {DATA_WIDTH{1'b0}};
            stage2_q <= {DATA_WIDTH{1'b0}};
        end
        else begin
            if (stall_stage2)
                stage1_q <= stage1_q;
            else 
                stage1_q <= d;
            if (flush_stage2)
                stage2_q <= {DATA_WIDTH{1'b0}};
            else 
                stage2_q <= stall_stage2? stage2_q:stage1_q;
        end
    end
endmodule