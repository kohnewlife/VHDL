library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY thirtyTwoBitCounter IS
	PORT	(	Clk, Reset:	IN STD_LOGIC;
				input		 : IN STD_LOGIC_VECTOR(31 downto 0);
				counter	 : OUT STD_LOGIC_VECTOR(31 downto 0)
			);
END thirtyTwoBitCounter;

ARCHITECTURE Behavior OF thirtyTwoBitCounter IS
	BEGIN
		PROCESS(Clk, Reset)
		BEGIN
			IF(RISING_EDGE(Clk)) THEN
				IF(Reset = '0') THEN
					input <= X"00400000";
				ELSE
					input <= input + "1";
				END IF;
			END IF;
		END PROCESS;
		counter <- input;
END Behavior;