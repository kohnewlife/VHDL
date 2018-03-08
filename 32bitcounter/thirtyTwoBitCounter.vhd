library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY thirtyTwoBitCounter IS
	PORT	(	Clk, Reset:	IN		STD_LOGIC;
				input		 : IN 	STD_LOGIC_VECTOR(31 downto 0);
				counter	 : OUT 	STD_LOGIC_VECTOR(31 downto 0)
			);
END thirtyTwoBitCounter;

ARCHITECTURE Behavior OF thirtyTwoBitCounter IS
	SIGNAL count_up	 : 		STD_LOGIC_VECTOR(31 downto 0);
	BEGIN
		PROCESS(Clk, Reset)
		BEGIN
			IF(RISING_EDGE(Clk)) THEN
				IF(Reset = '0') THEN
					count_up <= X"00400000";
				ELSE
					count_up <= count_up + "1";
				END IF;
			END IF;
		END PROCESS;
		counter <= count_up;
END Behavior;