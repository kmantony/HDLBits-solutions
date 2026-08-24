module skid_buffer #(
    parameter DATA_WIDTH = 8
)(
    input                   clk,
    input                   rst,
    // Producer (Slave) Interface
    input                   s_valid,
    output                  s_ready,
    input  [DATA_WIDTH-1:0] s_data,
    // Consumer (Master) Interface
    output                  m_valid,
    input                   m_ready,
    output [DATA_WIDTH-1:0] m_data
);
    // Write your RTL here
    reg [DATA_WIDTH-1:0] main_data, skid_data;
    reg main_valid, skid_valid;
    always @(posedge clk) begin
        if (rst) begin
            main_data <= {DATA_WIDTH{1'b0}};
            skid_data <= {DATA_WIDTH{1'b0}};
            main_valid <= 1'b0;
            skid_valid <= 1'b0;
        end
        else begin
            if (m_ready && s_valid) begin
                main_data <= s_data;
                main_valid <= 1'b1;
                skid_valid <= 1'b0;
            end
            else if (m_ready && skid_valid) begin
                main_data <= skid_data;
                main_valid <= 1'b1;
                skid_valid <= 1'b0;
            end
            else if (!m_ready && s_valid && main_valid && s_ready) begin
                skid_data <= s_data;
                skid_valid <= 1'b1;
            end
            else if (m_ready) begin
                main_valid <= 1'b0;
                skid_valid <= 1'b0;
            end
        end
    end
    assign s_ready = ~skid_valid;
    assign m_valid = main_valid;
    assign m_data = main_data;
endmodule