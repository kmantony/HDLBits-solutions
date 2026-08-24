module reg_byte_enable #(
    parameter BYTES = 4
)(
    input                      clk,
    input                      rst,
    input      [BYTES-1:0]     byte_en,
    input      [(8*BYTES)-1:0] d,
    output reg [(8*BYTES)-1:0] q
);
    // Write your RTL here
    // Remember: byte_en[i] enables write to byte slice q[8*i +: 8]
    integer i;
    always @(posedge clk) begin
        if (rst)
            q <= {(8*BYTES)-1{1'b0}};
        else begin
            for (i=0; i<=(8*BYTES)-1; i++) begin
                if (byte_en[i])
                    q[8*i +:8] <= d[8*i +:8];  //when (i=0)=>[7:0];(i=1)=>[8:15];(i=2)=>[23:16];...
            end
        end
    end
endmodule