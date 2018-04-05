LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY lab7 IS
	PORT (INBUS : IN STD_LOGIC_VECTOR(31 downTO 0);
			clk, reset	: IN STD_LOGIC;
			OUTBUS  : OUT STD_LOGIC_VECTOR(31 downTO 0));
END lab7;

ARCHITECTURE arch OF lab7 IS 

BEGIN 
		
		PROCESS (clk, reset)
		BEGIN
		IF reset = '0' THEN
			OUTBUS <= X"00400000";
		ELSIF rising_edge(clk) THEN
				OUTBUS <=  INBUS;
		END IF;
 		END PROCESS;
END arch;