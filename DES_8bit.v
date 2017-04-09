`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:39:10 04/07/2017 
// Design Name: 
// Module Name:    DES_8bit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DES_8bit(
    input CLKI,
    input RSTI,
    input CHIP_BAR_I,
    input [8:1] PLAIN_TEXT_I,
    input [8:1] KEY_I,
    output [8:1] CIPHER_OUT
    );
wire [64:1]CIPHER_OUT_P;
wire [64:1]PLAIN_TEXT_W;
wire [64:1]KEY_W;

BIT8TO64 i1(PLAIN_TEXT_W,KEY_W,PLAIN_TEXT_I,KEY_I);

Des_Top  DES(CLKI,RSTI,CHIP_BAR_I,PLAIN_TEXT_W, CIPHER_OUT_P,KEY_W);

BIT64TO8 i2(CIPHER_OUT,CIPHER_OUT_P);

endmodule


module BIT8TO64(PLAIN_TEXT_T,KEY_T,PLAIN_I,KEY_IO);
input [8:1]PLAIN_I;
input [8:1]KEY_IO;

parameter [57:1]PLAIN_TEXT_P=57'h000000000000;
parameter [57:1]KEY_P=57'h0000000000000;
output [64:1]PLAIN_TEXT_T;
output [64:1]KEY_T;
wire [8:1]PLAIN_I;
wire [8:1]KEY_IO;

assign PLAIN_TEXT_T = {PLAIN_TEXT_P[56:1],PLAIN_I[8:1]};
assign KEY_T={KEY_P[56:1],KEY_IO[8:1]};

endmodule

module BIT64TO8(CIPHER_OUT_T,CIPHER_OUT_P_I);
input [64:1]CIPHER_OUT_P_I;
output [8:1]CIPHER_OUT_T;
wire  [64:1]CIPHER_OUT_P_I;
assign CIPHER_OUT_T={CIPHER_OUT_P_I[8:1]};
endmodule