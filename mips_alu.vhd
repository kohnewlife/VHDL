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
			WHEN X"2" =>		-- increment
				result <= inputA + X"00000001";
			WHEN X"3" =>		-- decrement
				result <= inputA - X"00000001";
			WHEN X"4" =>		-- 1's complement
				result <= NOT inputA;
			WHEN X"5" =>		-- and
				result <= inputA AND inputB;
			WHEN X"6" =>		-- or
				result <= inputA OR inputB;
			WHEN X"7" =>		-- nor
				result <= inputA NOR inputB;
			WHEN X"8" =>		-- xor
				result <= inputA XOR inputB;
			WHEN X"9" =>		-- slt
				IF (inputA < inputB) THEN
					result <= X"00000001";
				ELSE 
					result <= X"00000000";
				END IF;
			WHEN X"A" =>		-- sltu
				IF (inputA < inputB) THEN
					result <= X"00000001";
				ELSE 
					result <= X"00000000";
				END IF;
			WHEN X"B" =>		-- sll
				result <= inputB << shamt;
			WHEN X"C" =>		-- sllv
				result <= inputB << inputA;
			WHEN X"D" =>		-- srl
				result <= inputB >> shamt;
			WHEN X"E" =>		-- srlv
				result <= inputB >> inputA;
			WHEN X"F" =>		
				-- TODO: fix this
			WHEN OTHERS => NULL;
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
				
		
	