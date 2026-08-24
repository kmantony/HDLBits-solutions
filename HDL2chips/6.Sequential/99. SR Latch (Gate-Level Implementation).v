module sr_latch(
    input  s,
    input  r,
    output wire q,
    output wire q_bar
);
    // Write your gate-level RTL here
    // Model the two cross-coupled NOR gates using assign statements
    assign q = ~(q_bar|r);
    assign q_bar = ~(q|s);
endmodule