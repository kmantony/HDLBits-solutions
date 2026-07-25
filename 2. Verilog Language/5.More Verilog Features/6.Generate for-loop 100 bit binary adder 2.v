module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum 
);
    genvar i; 
    generate
        for (i=0; i<=99; i=i+1) begin: Full_Adder
            if (i == 0) 
                FA_ADD inst(.a(a[i]), .b(b[i]), .cin(cin), .sum(sum[i]), .cout(cout[i]));
            else 
                FA_ADD inst(.a(a[i]), .b(b[i]), .cin(cout[i-1]), .sum(sum[i]), .cout(cout[i]));
        end
    endgenerate
endmodule

module FA_ADD( input a, b, cin, output cout, sum );
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule
