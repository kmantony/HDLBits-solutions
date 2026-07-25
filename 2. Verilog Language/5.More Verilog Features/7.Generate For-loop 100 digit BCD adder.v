module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    wire [100:0] w;
    genvar i; 
    generate
        assign w[0] = cin;
        for (i=0; i<=99; i=i+1) begin: BCD_Adder
            bcd_fadd inst(.a(a[i*4+3:i*4]), .b(b[i*4+3:i*4]), .cin(w[i]), .sum(sum[i*4+3:i*4]), .cout(w[i+1]));
        end
        assign cout = w[100];
    endgenerate
endmodule