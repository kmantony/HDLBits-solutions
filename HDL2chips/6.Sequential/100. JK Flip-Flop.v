module jk_flipflop(
    input  clk,
    input  rst,
    input  j,
    input  k,
    output reg q
);
    // Write your RTL here
    // Remember: rst is SYNCHRONOUS and has priority over j/k
    always @ (posedge clk) begin
        if (rst) begin
            q <= 0;
        end
        else begin
            case ({j,k})
                2'b00: q <= q;
                2'b01: q <= 0;
                2'b10: q <= 1;
                2'b11: q <= ~q;
            endcase
        end
    end
endmodule