`timescale 1ns/1ps

module HA (
    output logic c,
    output logic s,
    input logic a,
    input logic b
);

assign s = a ^ b ;
assign c = a & b ;
    
endmodule

module FA (
    output logic c,
    output logic s,
    input logic a,
    input logic b,
    input logic cin
);

assign s = a ^ b ^cin;
assign c = (a & b) | (b & cin) | (a & cin) ;
    
endmodule