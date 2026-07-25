module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    integer row, col, count, N, E, S, W;
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            // q[256] -> 16 rows x 16 cols 
            for (row = 0; row <= 15; row++) begin
                for (col = 0; col <= 15; col++) begin
                    N = (row == 0)? 15 : row -1;
                    S = (row == 15)? 0 : row +1;
                    W = (col == 0)? 15 : col -1;
                    E = (col == 15) ? 0 : col + 1;
                    //q[row,col] = q[row*16 +col]
                    count = q[N*16 +W] +q[N*16 +col] +q[N*16 +E] +q[row*16 +W] +q[row*16 +E] + q[S*16 +W] +q[S*16 +col] +q[S*16 +E]; 
                    if (count < 2)
                        q[row*16 +col] <= 1'b0;
                    else if (count == 2)
                        q[row*16 +col] <= q[row*16 +col];
                    else if (count == 3)
                        q[row*16 +col] <= 1'b1;
                    else
                        q[row*16 +col] <= 1'b0;
                end
            end
        end
    end
endmodule