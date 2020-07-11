// This is the parent module for Quartus programing purposes
module ALU_pv (input [3:0] aluin_a, OPCODE, input Cin, output reg [3:0] alu_out, output reg Cout, output OF);

wire [3:0] aluin_b;
assign aluin_b = 4'b0011;
wire [3:0]alu_out1;
wire Cout1;

   always @(*) begin // This allows us to connect the output ports of ALU_pv and ALU.
      Cout = Cout1;
      alu_out = alu_out1;
   end

ALU A1 (aluin_a,aluin_b,OPCODE,Cin,alu_out1,Cout1,OF); // Instantiate ALU to feed inputs and outputs to the rest of our program.

endmodule
// This is the parent module
module ALU (input [3:0] aluin_a, aluin_b, OPCODE, input Cin, output reg [3:0] alu_out, output reg Cout, output OF);

wire [3:0] Sum, Bn;
wire Co;
reg [3:0] Bin;

RA RA_1 (aluin_a, Bin, Cin, Sum, Co, OF); // We need the ripple adder module to perform addition and subtraction.
Twos Twos_1 (aluin_b, Bn); // We need the twos complement module to perform subtraction.

   always @ (*) begin

    // Initialize the ports with zeros
    Bin = 4'b0000; alu_out = 4'b0000; Cout = 1'b0;

    case (OPCODE) // These OPCODEs trigger the ALU to perform a specific operation.

	4'b1000: // Adds aluin_a + aluin_b
	begin
	   Bin = aluin_b; alu_out = Sum; Cout = Co;
	end
	4'b1001: // Adds aluin_a + aluin_b + Cin
	begin
	   Bin = aluin_b; alu_out = Sum; Cout = Co;
	end
	4'b1010: // Subtracts aluin_b from aluin_a
	begin
	   Bin = Bn; alu_out = Sum; Cout = Co;
	end
	4'b0000: // bitwise NAND
	begin
	   alu_out = ~(aluin_a&aluin_b);
	end
	4'b0001: // bitise NOR
	begin
	   alu_out = ~(aluin_a|aluin_b);
	end
	4'b0010: // bitwise XOR
	begin
	   alu_out = aluin_a^aluin_b;
	end
	4'b0100: // bitwise NOT
	begin
	   alu_out = ~aluin_a;
	end
	4'b0101: // logical shift right
	begin
	   alu_out = aluin_a >>1;
	end
	default : alu_out = 4'b0000;
    endcase
   end
endmodule

// Child that turns a number into it's twos complement.
module Twos (input [3:0] B, output [3:0] Bn);
wire [3:0] Bn1;
wire OF;
assign Bn1 = ~B;
RA RA_2 (Bn1,4'b0000,1'b1,Bn,Cout,OF);
endmodule

// Child 4'b Ripple Adder containing 4 instances of the 1'b Full Adder
module RA (input [3:0] A, B, input Cin, output [3:0] Sum, output Cout, OF);
   FA F_1 (A[0], B[0], Cin,    Sum[0], Cout_1);
   FA F_2 (A[1], B[1], Cout_1, Sum[1], Cout_2);
   FA F_3 (A[2], B[2], Cout_2, Sum[2], Cout_3);
   FA F_4 (A[3], B[3], Cout_3, Sum[3], Cout);
   xor XOR_1 (OF, Cout_3, Cout);
endmodule

// Child 1'b Full Adder containing two instances of the 1'b half adder
module FA (input A,B,C_in, output Sum, Cout);
wire Sum_1, Cout_1, Cout_2;
   HA ha_1 (A, B, Sum_1, Cout_1);
   HA ha_2 (Sum_1, C_in, Sum, Cout_2);
   or O_1 (Cout, Cout_1, Cout_2);
endmodule

// Child 1'b Half Adder
module HA (input A,B, output Sum, Cout);
assign Sum = A^B;
assign Cout = A&B;
endmodule


