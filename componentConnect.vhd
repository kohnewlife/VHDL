LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

Entity componentconnect IS
	PORT( reset										:IN STD_LOGIC;
			slow_clock, fast_clock				:IN STD_LOGIC;
			PC_OUT,INSTRUCTION_OUT				:OUT STD_LOGIC;
			Read_reg1_out, Read_reg2_out		:	OUT STD_LOGIC_VECTOR(4  DOWNTO 0);
			Write_reg_out							:	OUT STD_LOGIC_VECTOR(4  DOWNTO 0);
			Read_data1_out, Read_data2_out	:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			Write_data_out							:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END componentconnect;


ARCHITECTURE arc of componentconnect IS
				SIGNAL PCout					:	STD_LOGIC_VECTOR(31 downto 0);
				SIGNAL PC_in					:	STD_LOGIC_VECTOR(31 downto 0);
				SIGNAL RegDstSig,MemtoRegSig, ALUSrcSig, JumpSig, JalSig, JrSig, BeqSig, BneSig, MemReadSig, MemWriteSig, RegWriteSig : STD_LOGIC;
				SIGNAL ALUControlSig			:	STD_LOGIC_VECTOR( 3 DOWNTO 0);
				SIGNAL WriteRegister, WriteRegisterAfterJal	:	STD_LOGIC_VECTOR(4 downto 0);
				SIGNAL SignExtended			:	STD_LOGIC_VECTOR(31 downto 0);
				SIGNAL ALULower				:	STD_LOGIC_VECTOR(31 downto 0);
				SIGNAL PCnoJr					:	STD_LOGIC_VECTOR(31 downto 0);
				SIGNAL ALUZero					:	STD_LOGIC;
				SIGNAL ALUResult				:	STD_LOGIC_VECTOR(31 downto 0);
				SIGNAL memOutput				:	STD_LOGIC_VECTOR(31 downto 0);
				SIGNAL PCplusFour				:	STD_LOGIC_VECTOR(31 downto 0);
				SIGNAL JumpAddress1			:	STD_LOGIC_VECTOR(27 downto 0);
				SIGNAL MemReadOut				:	STD_LOGIC_VECTOR(31 downto 0);
				SIGNAL ShiftedImmed			:	STD_LOGIC_VECTOR(31 downto 0);
				SIGNAL BranchAddress			:	STD_LOGIC_VECTOR(31 downto 0);
				SIGNAL BranchEqualSig		:	STD_LOGIC;
				SIGNAL BranchNotEqualSig	:	STD_LOGIC;
				SIGNAL BranchSig				:	STD_LOGIC;
				SIGNAL BranchTaken			:	STD_LOGIC_VECTOR(31 downto 0);
				SIGNAL ReadReg1, ReadReg2	:	STD_LOGIC_VECTOR(4 downto 0);
				SIGNAL ReadData1, ReadData2, WriteData			:	STD_LOGIC_VECTOR(31 downto 0);
				SIGNAL instruction 			:	STD_LOGIC_VECTOR(31 downto 0);
				SIGNAL ALUNotZero				:	STD_LOGIC;
				SIGNAL BOThJumpSig			:	STD_LOGIC;
				SIGNAL IOWrite					: 	STD_LOGIC;
				SIGNAL MemWriteNew			: 	STD_LOGIC;
				SIGNAL ReadDataOutIO			: 	STD_LOGIC_VECTOR(31 DOWNTO 0);
				SIGNAL TEMPinOUT				: 	STD_LOGIC_VECTOR(31 DOWNTO 0);


														
		COMPONENT clk_div 		PORT 		(	clock_48Mhz					: IN	STD_LOGIC;
														clock_1MHz					: OUT	STD_LOGIC;
														clock_100KHz				: OUT	STD_LOGIC;
														clock_10KHz					: OUT	STD_LOGIC;
														clock_1KHz					: OUT	STD_LOGIC;
														clock_100Hz					: OUT	STD_LOGIC;
														clock_10Hz					: OUT	STD_LOGIC;
														clock_1Hz					: OUT	STD_LOGIC);
														END COMPONENT;
														

													
	
		
														
		COMPONENT mips_alu 				PORT (	ALUControl					: IN	STD_LOGIC_VECTOR( 3 DOWNTO 0);
														inputA, inputB				: IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
														shamt							: IN	STD_LOGIC_VECTOR( 4 DOWNTO 0);
														Zero							: OUT	STD_LOGIC;
														ALU_Result  				: OUT	STD_LOGIC_VECTOR(31 DOWNTO 0) );
														END COMPONENT;

										

		COMPONENT rom						PORT (address						: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
														clock							: IN STD_LOGIC  := '1';
														q								: OUT STD_LOGIC_VECTOR (31 DOWNTO 0) );
														END COMPONENT;
														
		COMPONENT lab7 	PORT (				INBUS : IN STD_LOGIC_VECTOR(31 downTO 0);
														clk, reset	: IN STD_LOGIC;
														OUTBUS  : OUT STD_LOGIC_VECTOR(31 downTO 0));
														
														
														END COMPONENT;
		COMPONENT signExtImmediate 	PORT ( 	input							: IN STD_LOGIC_VECTOR ( 15 DOWNTO 0 );
														output 						: OUT STD_LOGIC_VECTOR ( 31 DOWNTO 0 ) );
														
														
														END COMPONENT;
		COMPONENT mipsControl			PORT (opcode					:	IN	STD_LOGIC_VECTOR(5 DOWNTO 0);
														funct							:	IN STD_LOGIC_VECTOR(5 DOWNTO 0);
														RegDst, ALUSrc				:	OUT STD_LOGIC;
														Jump, jal, Jr				:	OUT STD_LOGIC;
														Beq, Bne						:	OUT STD_LOGIC;
														MemRead, MemWrite			:	OUT STD_LOGIC;
														RegWrite, MemtoReg		:	OUT STD_LOGIC;
														ALUControl					:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0)	);
														END COMPONENT;
														

														
		COMPONENT ram 						PORT (	address						: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
														clock							: IN STD_LOGIC  := '1';
														data							: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
														wren							: IN STD_LOGIC ;
														q								: OUT STD_LOGIC_VECTOR (31 DOWNTO 0) );
														END COMPONENT;		
		COMPONENT mips_register_file	PORT (	clock, reset, RegWrite	: IN	STD_LOGIC;
														read_reg1, read_reg2		: IN	STD_LOGIC_VECTOR( 4 DOWNTO 0);
														write_reg					: IN	STD_LOGIC_VECTOR( 4 DOWNTO 0);
														write_data					: IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
														read_data1, read_data2  : OUT	STD_LOGIC_VECTOR(31 DOWNTO 0) );
														END COMPONENT;
																		
		BEGIN	
		mipsy: mips_register_file PORT MAP(clock => slow_clock,
														reset => reset,
														RegWrite => RegWriteSig,
														read_reg1 => instruction(25 downtO 21) ,	
														read_reg2 => instruction(20 downTO 16),
														write_reg => writeRegister, --or after jal idk
														write_data => writeData,
														read_data1 => readData1,
														read_data2 => readData2);
														
			--lab7 is our program counter
		PC1: 		lab7 PORT MAP(		clk => slow_clock, 
											reset => reset, 
											INBUS => PC_in, 
											OUTBUS => PCout);
--										PC_out <= PCout;

		
		ramsy: ram PORT MAP(address => --?????? pix later
								clock => fast_clock,
								data => readData1,-- or it might be readdata2 ask
								wren => MemWriteNew,
								q => memOutput);
								
								
		MIPSALU: mips_alu PORT MAP(
											ALUControl => ALUControlSig,
											inputA 	=> readData1,
											inputB	=> readData2,
											shamt => instruction(10 downTO 6),
											Zero => AluZero,
											ALU_Result => ALUResult);

		

		signEXTy: signExtImmediate PORT MAP(input => instruction(15 downTO 0),
														output => signExtended);
														
		ControlMips: mipsControl PORT MAP(opcode => instruction(31 dowNTO 26),
													funct => 	instruction(5 downTO 0),
													RegDst => RegDstSig,
													ALUSrc => ALUSrcSig,
													Jump => JumpSig,
													jal => jalSig,
													Jr	=> JRsig,		
													Beq => BeqSig,
													Bne => BneSig,						
													MemRead => MemReadSig,
													MemWrite => MemWriteSig,
													RegWrite => RegWriteSig,
													MemtoReg	=>	MemtoRegSig,
													ALUControl => ALUControlSig);
													
														
		instructo: rom PORT MAP(
										address => PCout(12 downto 1), 		--check later
										clock => fast_clock,
										q => instruction);
		
		
----------------------------begin muxes for all the jump type instructions----------------------------------
PCplusFour <= pcout + "0100";	
JumpAddress1 <= instruction(25 downTO 0);

PROCESS(JumpAddress1, jumpSig, PCout)
		CASE jumpSig is												 --jump
			WHEN '1' =>
				PCout <= jumpAddress1;
			WHEN OTHERS =>
				PCout <= PCout;
		END CASE;
END PROCESS;

PROCESS(JumpAddress1, JALSig, WriteRegister)
			CASE JALSig is
				WHEN '1' => 
						WriteRegisterafterJal <= "11111"; 			--write regist after jal is ra which is 31
				WHEN others =>
						WriteRegisterAfterJal <= "00000";			--if(0) {then its nothing}
			END CASE;
END PROCESS;

PROCESS(JumpAddress1, JRsig, WriteRegister)						--jr 
			CASE JRsig is
				WHEN '1' =>													--not sure if instruction
					WriteRegister <= instruction(25 downto 21); 	
				WHEN OTHERS =>
					WriteRegister <= instruction(20 downto 16);  --got to put it somewhere
			END CASE;
END PROCESS;

		
--------------------------------------------stuff for write reg----------------------------------------------		
		PROCESS(instruction, RegDstSig, WriteRegister)
		BEGIN
			CASE REGDstSig is -- reg dst for I type
				WHEN '0' =>
					WriteRegister <= instruction(20 downto 16);
				When OTHERS =>
					WriteRegister <= instruction(15 downto 11);
			END CASE;
		END PROCESS;
		
	
		END ARC;