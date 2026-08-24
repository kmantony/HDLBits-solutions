module dff_scan(
    input  clk,
    input  rst,
    input  scan_en,
    input  d,
    input  scan_in,
    output reg q
);
    // Write your RTL here
    always @ (posedge clk) begin
        if (rst) 
            q <= 0;
        else 
            q <= scan_en? scan_in:d;
    end
endmodule