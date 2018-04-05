library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mipsControl IS
	PORT(	opcode					:	IN	STD_LOGIC_VECTOR(5 DOWNTO 0);
			funct						:	IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			RegDst, ALUSrc			:	OUT STD_LOGIC;
			Jump, jal, Jr			:	OUT STD_LOGIC;
			Beq, Bne					:	OUT STD_LOGIC;
			MemRead, MemWrite		:	OUT STD_LOGIC;
			RegWrite, MemtoReg	:	OUT STD_LOGIC;
			ALUControl				:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0)	);
END mipsControl;

ARCHITECTURE Behavior OF mipsControl IS

BEGIN 
	PROCESS(opcode, funct)
		BEGIN
		IF opcode = "000000" THEN
			RegDst <= '1';
			ALUSrc <= '0';
			Beq <= '0';
			Bne <= '0';
			MemRead <= '0';
			MemWrite <= '0';
			RegWrite <= '1';
			MemtoReg <= '0';
			Jump <= '0';
			jal <= '0';
			
			CASE funct IS		-- Jump or not
				WHEN "001000" =>		--jr
					Jr <= '1';
				WHEN "100000" =>		--add 20
					ALUControl <= X"2";
					Jr <= '0';
				WHEN "100001" =>		--addu 21
					ALUControl <= X"2";
					Jr <= '0';
				WHEN "100100" =>		--and 24
					ALUControl <= X"0";
					Jr <= '0';
				WHEN "100111" =>		--nor 27
					ALUControl <= X"C";
					Jr <= '0';
				WHEN "100101" =>		--or 25
					ALUControl <= X"1";
					Jr <= '0';
				WHEN "101010" =>		--slt 2a
					ALUControl <= X"7";
					Jr <= '0';
				WHEN "000000" =>		--sll 00
					ALUControl <= X"8";
					Jr <= '0';
				WHEN "000010" =>		--srl 02
					ALUControl <= X"9";
					Jr <= '0';
				WHEN "000100" =>		--sllv 04
					ALUControl <= X"A";
					Jr <= '0';
				WHEN "000110" =>		--srlv 06
					ALUControl <= X"B";
					Jr <= '0';
				WHEN "100010" =>		--sub 22
					ALUControl <= X"6";
					Jr <= '0';
				WHEN "100011" =>		--subu 23
					ALUControl <= X"6";
					Jr <= '0';
				WHEN OTHERS =>		--jr
					ALUControl <= "----";
			END CASE;
			 ------------------------------------------------------------------------END OF R TYPE
		ELSE
		
		CASE opCode is
			WHEN "000100" =>		--beq  04
				ALUControl <= X"6";
				RegDst <= '-'; 
				ALUSrc <='-';
				Jump <='0';
				jal <='0';
				Jr <='0';
				Beq <='1';
				Bne <='0';
				MemRead <='0';
				MemWrite <='0';
				RegWrite <='0';
				MemtoReg <='-';
			WHEN "000101" =>		--bne 05
				ALUControl <= X"6";
				RegDst <= '-'; 
				ALUSrc <='-';
				Jump <='0';
				jal <='0';
				Jr <='0';
				Beq <='0';
				Bne <='1';
				MemRead <='0';
				MemWrite <='0';
				RegWrite <='0';
				MemtoReg <='-';
			WHEN "001000" => --addi 08
				ALUControl <= X"2";
				RegDst <= '0'; 
				ALUSrc <='1';
				Jump <='0';
				jal <='0';
				Jr <='0';
				Beq <='0';
				Bne <='0';
				MemRead <='0';
				MemWrite <='0';
				RegWrite <='1';
				MemtoReg <='0';
			WHEN "001001" => --addiu 09
				ALUControl <= X"2";
				RegDst <= '0'; 
				ALUSrc <= '1'; 
				Jump <='0';
				jal <='0';
				Jr <='0';
				Beq <='0';
				Bne <='0';
				MemRead <='0';
				MemWrite <='0';
				RegWrite <='1';
				MemtoReg <= '0';
			WHEN "001010" => --slti 0a
				ALUControl <= X"7";
				RegDst <= '0'; 
				ALUSrc <= '1'; 
				Jump <='0';
				jal <='0';
				Jr <='0';
				Beq <='0';
				Bne <='0';
				MemRead <='0';
				MemWrite <='0';
				RegWrite <='1';
				MemtoReg <= '0';
			WHEN "001100" => --andi 0c
				ALUControl <= X"0";
				RegDst <= '0'; 
				ALUSrc <= '1'; 
				Jump <='0';
				jal <='0';
				Jr <='0';
				Beq <='0';
				Bne <='0';
				MemRead <='0';
				MemWrite <='0';
				RegWrite <='1';
				MemtoReg <= '0';
			WHEN "001101" => --ori 0d
				ALUControl <= X"1";
				RegDst <= '0'; 
				ALUSrc <= '1'; 
				Jump <='0';
				jal <='0';
				Jr <='0';
				Beq <='0';
				Bne <='0';
				MemRead <='0';
				MemWrite <='0';
				RegWrite <='1';
				MemtoReg <= '0';
			WHEN "001111" => --lui 0fs
				RegDst <= '-'; 
				ALUSrc <= '1'; 
				Jump <='0';
				jal <='0';
				Jr <='0';
				Beq <='0';
				Bne <='0';
				MemRead <='1';
				MemWrite <='0';
				RegWrite <='1';
				MemtoReg <= '1';
			WHEN "000010" =>		--j 02
				RegDst <= '-'; 
				ALUSrc <= '-'; 
				Jump <='1';
				jal <='0';
				Jr <='0';
				Beq <='0';
				Bne <='0';
				MemRead <='0';
				MemWrite <='0';
				RegWrite <='0';
				MemtoReg <= '-';
			WHEN "000011" =>		--jal 03
				RegDst <= '1'; 
				ALUSrc <= '-';
				Jump <= '0';
				jal <='1';
				Jr <=	'0';
				Beq <='0';
				Bne <='0';
				MemRead <='0';
				MemWrite <='0';
				RegWrite <='1'; 
				MemtoReg <='-'; 
			WHEN "100011" =>		--lw 23
				RegDst <='0'; 
				ALUSrc <='1';
				Jump <='0';
				jal <='0';
				Jr <='0';
				Beq <='0';
				Bne <='0';
				MemRead <='1';
				MemWrite <='0';
				RegWrite <='1';
				MemtoReg <='1';
			WHEN "101011" =>		--sw 2b
				RegDst <= '-'; 
				ALUSrc <='1';
				Jump <='0';
				jal <='0';
				Jr <='0';
				Beq <='0';
				Bne <='0';
				MemRead <='0';
				MemWrite <='1';
				RegWrite <='0';
				MemtoReg <= '0';
			WHEN OTHERS =>
				RegDst <= '0';
				ALUSrc <= '1';
				Jump <= '0';
				Jal <= '0';
				Jr <= '0';
				Beq <= '0';
				Bne <= '0';
				MemRead <= '0';
				MemWrite <= '0';
				RegWrite <= '1';
				MemtoReg <= '0';
		END CASE;
		END IF;
	END PROCESS;
END Behavior;