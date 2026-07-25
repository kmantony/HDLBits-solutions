module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire carry;
    reg [31:0] bin; 
    always @(*) begin
        if (sub) begin
            bin = ~b;
        end else begin
            bin = b;
        end
    end
    add16 instance1( .a(a[15:0]), .b(bin[15:0]), .cin(sub), .sum(sum[15:0]), .cout(carry));
    add16 instance2( .a(a[31:16]), .b(bin[31:16]), .cin(carry), .sum(sum[31:16]), .cout());
endmodule