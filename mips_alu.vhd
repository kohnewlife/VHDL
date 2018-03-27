library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mips_alu IS
	PORT(	ALUControl			: IN	STD_LOGIC_VECTOR( 3 DOWNTO 0);
			inputA, inputB		: IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
			shamt					: IN	STD_LOGIC_VECTOR( 4 DOWNTO 0);
			Zero					: OUT	STD_LOGIC;
			ALU_Result  		: OUT	STD_LOGIC_VECTOR(31 DOWNTO 0) );
END mips_alu;

ARCHITECTURE arch OF mips_alu IS 
	SIGNAL result: STD_LOGIC_VECTOR(31 DOWNTO 0);
	
BEGIN
	PROCESS(ALUControl, inputA, inputB, shamt)
	BEGIN
		CASE ALUControl IS
			WHEN X"0" =>		-- add
				result <= inputA + inputB;
			WHEN X"1" =>		-- sub
				result <= inputA - inputB;
			WHEN X"2" =>		-- and
				result <= inputA AND inputB;
			WHEN X"3" =>		-- or
				result <= inputA OR inputB;
			WHEN X"4" =>		
				IF (inputA < inputB) THEN
					result <= X"00000001";
				ELSE 
					result <= X"00000000";
				END IF;
			WHEN OTHERS =>
				result <= inputA + inputB;		-- add
		END CASE;
	END PROCESS;
	-- Zero
	IF (result = X"00000000") THEN
		Zero <= '1';
	ELSE
		Zero <= '0';
	END IF;
	ALU_Result <= result;
END arch;
				
		
	