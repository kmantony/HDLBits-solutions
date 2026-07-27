module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter A = 0, //Below S1
    		  B_rise = 1, B_fall = 2, //Between S2 & S1
    		  C_rise = 3, C_fall = 4, //Between S3 & S2
    		  D = 5; //Above S3
    reg [2:0] state, next_state;
    
    //state transition logic
    always @(*) begin
        case (state)
            A: next_state = s[1]? B_rise :A;
            B_rise: next_state = s[2]? C_rise :(s[1]? B_rise :A);
            B_fall: next_state = s[2]? C_rise :(s[1]? B_fall :A);
            C_rise: next_state = s[3]? D :(s[2]? C_rise :B_fall);
            C_fall: next_state = s[3]? D :(s[2]? C_fall :B_fall);
            D: next_state = s[3]? D: C_fall;
        endcase
    end
    
    //flip flop
    always @(posedge clk) begin 
        state <= (reset)? A: next_state;
    end
    
    //output
    always @(*) begin
        case (state)
            A: {fr1, fr2, fr3, dfr} = 4'b1111;
            B_rise: {fr1, fr2, fr3, dfr} = 4'b1100;
            B_fall: {fr1, fr2, fr3, dfr} = 4'b1101;
            C_rise: {fr1, fr2, fr3, dfr} = 4'b1000;
            C_fall: {fr1, fr2, fr3, dfr} = 4'b1001;
            D: {fr1, fr2, fr3, dfr} = 4'b0000;
        endcase
    end
                    
endmodule