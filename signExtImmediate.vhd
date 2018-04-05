library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY signExtImmediate IS
	PORT ( input	: IN STD_LOGIC_VECTOR ( 15 DOWNTO 0 );
			 output 	: OUT STD_LOGIC_VECTOR ( 31 DOWNTO 0 )
			);
END signExtImmediate;

ARCHITECTURE arc OF signExtImmediate IS
	SIGNAL leading	: STD_LOGIC_VECTOR ( 15 DOWNTO 0 );
BEGIN
	PROCESS ( input, leading )
		BEGIN
		FOR i IN 0 TO 15 LOOP
		
			leading( i ) <= input( 15 );
			
		END LOOP;
		
		output <= leading & input; --casting
		
	END PROCESS;
END arc;
		