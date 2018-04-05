library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 

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
			WHEN "0000" =>		-- and
				result <= inputA AND inputB;
			WHEN "0001" =>		-- or
				result <= inputA OR inputB;
			WHEN "0010" =>		-- add
				result <= inputA + inputB;
			WHEN "0110" =>		-- subtract
				result <= inputA - inputB;
			WHEN "0111" =>		-- slt
				IF (inputA < inputB) THEN
					result <= X"00000001";
				ELSE 
					result <= X"00000000";
				END IF;
			WHEN "1000" =>		-- sll
				result <= conv_std_logic_vector((CONV_INTEGER( inputB ) * (2 * CONV_INTEGER( shamt ))) , 32);
			WHEN "1001" =>		-- srl
				result <= conv_std_logic_vector((CONV_INTEGER( inputB ) / (2 * CONV_INTEGER( shamt ))) , 32);
			WHEN "1010" =>		-- sllv
				result <= conv_std_logic_vector((CONV_INTEGER( inputB ) * (2 * CONV_INTEGER( inputA ))) , 32);
			WHEN "1011" =>		-- srlv
				result <= conv_std_logic_vector((CONV_INTEGER( inputB ) / (2 * CONV_INTEGER( inputA ))) , 32);
			WHEN "1100" =>		-- nor
				result <= inputA NOR inputB;
			WHEN "1101" =>		-- Lui
				result <= conv_std_logic_vector((CONV_INTEGER( inputA ) * 65536) , 32);
			WHEN OTHERS => NULL;
		END CASE;
		IF (result = X"00000000") THEN
			Zero <= '1';
		ELSE
			Zero <= '0';
		END IF;
	END PROCESS;
	-- Zero
	ALU_Result <= result;
END arch;
				
		
	