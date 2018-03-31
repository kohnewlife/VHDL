module SignExtender ( BusImm , Imm16 , Ctrl ) ;
	output [ 31 : 0 ] BusImm ;
	input [ 1 5 : 0 ] Imm16 ;
	input Ctrl ;
	
	wire extBit = ( Ctrl ? 0 : Imm16 [ 0 ] ) ;
	assign BusImm = { { 16{ extBit } } , Imm16 } ;
endmodule