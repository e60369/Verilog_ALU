// Test bench used to fully test ALU module.
`timescale 1ns/1ps

module ALU_tb ();

reg [3:0] OPCODE;
reg Cin;
wire Cout,OF;
reg [3:0] aluin_a,aluin_b;
wire [3:0] alu_out;
reg [3:0] interA; // Used to store intermediate results of the given function.
reg [3:0] interB; // Used to store intermediate results of the given function.

initial begin

interA = 4'b0000; interB =4'b0000; //initialize these ports with zeros.

//This tests each of our OPCODES and displays the results.
aluin_a =4'b0110 ; aluin_b =4'b0011; OPCODE = 4'b1000; Cin =0 ; #10;
$display("aluin_a = %b, aluin_b = %b, OPCODE = %b, Cin = %b, alu_out = %b, Cout = %b, OF = %b", aluin_a, aluin_b,OPCODE,Cin,alu_out,Cout,OF);
aluin_a =4'b0111 ; aluin_b =4'b0101; OPCODE = 4'b1001; Cin =1 ; #10;
$display("aluin_a = %b, aluin_b = %b, OPCODE = %b, Cin = %b, alu_out = %b, Cout = %b, OF = %b", aluin_a, aluin_b,OPCODE,Cin,alu_out,Cout,OF);
aluin_a =4'b0111 ; aluin_b =4'b0101; OPCODE = 4'b1010; Cin =0 ; #10;
$display("aluin_a = %b, aluin_b = %b, OPCODE = %b, Cin = %b, alu_out = %b, Cout = %b, OF = %b", aluin_a, aluin_b,OPCODE,Cin,alu_out,Cout,OF);
aluin_a =4'b0110 ; aluin_b =4'b1111; OPCODE = 4'b0000; Cin =0 ; #10;
$display("aluin_a = %b, aluin_b = %b, OPCODE = %b, Cin = %b, alu_out = %b, Cout = %b, OF = %b", aluin_a, aluin_b,OPCODE,Cin,alu_out,Cout,OF);
aluin_a =4'b0110 ; aluin_b =4'b0001; OPCODE = 4'b0001; Cin =0 ; #10;
$display("aluin_a = %b, aluin_b = %b, OPCODE = %b, Cin = %b, alu_out = %b, Cout = %b, OF = %b", aluin_a, aluin_b,OPCODE,Cin,alu_out,Cout,OF);
aluin_a =4'b0101 ; aluin_b =4'b1111; OPCODE = 4'b0010; Cin =0 ; #10;
$display("aluin_a = %b, aluin_b = %b, OPCODE = %b, Cin = %b, alu_out = %b, Cout = %b, OF = %b", aluin_a, aluin_b,OPCODE,Cin,alu_out,Cout,OF);
aluin_a =4'b1101 ; aluin_b =4'b0000; OPCODE = 4'b0100; Cin =0 ; #10;
$display("aluin_a = %b, aluin_b = %b, OPCODE = %b, Cin = %b, alu_out = %b, Cout = %b, OF = %b", aluin_a, aluin_b,OPCODE,Cin,alu_out,Cout,OF);
aluin_a =4'b0101 ; aluin_b =4'b0000; OPCODE = 4'b0101; Cin =0 ; #10;
$display("aluin_a = %b, aluin_b = %b, OPCODE = %b, Cin = %b, alu_out = %b, Cout = %b, OF = %b", aluin_a, aluin_b,OPCODE,Cin,alu_out,Cout,OF);

//This is to implement the function alu_out = (aluin_a^aluin_b)+((~(aluin_a&aluin_b))>>1)
aluin_a =4'b0110 ; aluin_b =4'b0011; OPCODE = 4'b0010; Cin =0; #10; interA = alu_out; #10;
$display("Step#1: aluin_a = %b, aluin_b = %b, OPCODE = %b, Cin = %b, alu_out = %b, interA = %b, Cout = %b, OF = %b", aluin_a, aluin_b,OPCODE,Cin,alu_out,interA,Cout,OF);
aluin_a =4'b0110 ; aluin_b =4'b0011; OPCODE = 4'b0000; Cin =0; #10; interB = alu_out; #10;
$display("Step#2: aluin_a = %b, aluin_b = %b, OPCODE = %b, Cin = %b, alu_out = %b, interB = %b, Cout = %b, OF = %b", aluin_a, aluin_b,OPCODE,Cin,alu_out,interB,Cout,OF);
aluin_a =interB  ; aluin_b =4'b0000; OPCODE = 4'b0101; Cin =0; #10; interB = alu_out; #10;
$display("Step#3: aluin_a = %b, aluin_b = %b, OPCODE = %b, Cin = %b, alu_out = %b, interB = %b, Cout = %b, OF = %b", aluin_a, aluin_b,OPCODE,Cin,alu_out,interB,Cout,OF);
aluin_a =interA  ; aluin_b =interB;  OPCODE = 4'b1000; Cin =0; #10;
$display("Step#4: aluin_a = %b, aluin_b = %b, OPCODE = %b, Cin = %b, alu_out = %b, Cout = %b, OF = %b", aluin_a, aluin_b,OPCODE,Cin,alu_out,Cout,OF);

end

ALU A1 (aluin_a,aluin_b,OPCODE,Cin,alu_out,Cout,OF);
endmodule

