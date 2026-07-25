module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire carry; reg [15:0]out1, out2;
    add16 instance1( a[15:0], b[15:0], 1'b0, sum[15:0], carry);
    add16 instance2( a[31:16], b[31:16], 1'b0, out1[15:0]);
    add16 instance3( a[31:16], b[31:16], 1'b1, out2[15:0]);
    always@(*) begin  
        case(carry)
            1'b0: sum[31:16] = out1[15:0];
            1'b1: sum[31:16] = out2[15:0];
        endcase
    end
endmodule