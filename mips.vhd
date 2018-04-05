ENTITY mips IS
	PORT(	reset										:	IN	STD_LOGIC;
			slow_clock, fast_clock				:	IN	STD_LOGIC;
			PC_out, Instruction_out				:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			Read_reg1_out, Read_reg2_out		:	OUT STD_LOGIC_VECTOR(4  DOWNTO 0);
			Write_reg_out							:	OUT STD_LOGIC_VECTOR(4  DOWNTO 0);
			Read_data1_out, Read_data2_out	:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			Write_data_out							:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END mips;

ARCHITECTURE arc OF signExtImmediate IS
	SIGNAL leading	: STD_LOGIC_VECTOR ( 15 DOWNTO 0 );
	BEGIN
	COMPONENT lab7 					PORT (	INBUS : IN STD_LOGIC_VECTOR(31 downTO 0);
														clk, reset	: IN STD_LOGIC;
														OUTBUS  : OUT STD_LOGIC_VECTOR(31 downTO 0));
														END COMPONENT;
														
	COMPONENT clk_div 				PORT (	clock_48Mhz					: IN	STD_LOGIC;
														clock_1MHz					: OUT	STD_LOGIC;
														clock_100KHz				: OUT	STD_LOGIC;
														clock_10KHz					: OUT	STD_LOGIC;
														clock_1KHz					: OUT	STD_LOGIC;
														clock_100Hz					: OUT	STD_LOGIC;
														clock_10Hz					: OUT	STD_LOGIC;
														clock_1Hz					: OUT	STD_LOGIC);
														END COMPONENT;
														
	COMPONENT mipsControl			PORT (	opcode						:	IN	STD_LOGIC_VECTOR(5 DOWNTO 0);
														funct							:	IN STD_LOGIC_VECTOR(5 DOWNTO 0);
														RegDst, ALUSrc				:	OUT STD_LOGIC;
														Jump, jal, Jr				:	OUT STD_LOGIC;
														Beq, Bne						:	OUT STD_LOGIC;
														MemRead, MemWrite			:	OUT STD_LOGIC;
														RegWrite, MemtoReg		:	OUT STD_LOGIC;
														ALUControl					:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0)	);
														END COMPONENT;
													
	COMPONENT mips_register_file	PORT (	clock, reset, RegWrite	: IN	STD_LOGIC;
														read_reg1, read_reg2		: IN	STD_LOGIC_VECTOR( 4 DOWNTO 0);
														write_reg					: IN	STD_LOGIC_VECTOR( 4 DOWNTO 0);
														write_data					: IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
														read_data1, read_data2  : OUT	STD_LOGIC_VECTOR(31 DOWNTO 0) );
														END COMPONENT;
														
	COMPONENT signExtImmediate 	PORT ( 	input							: IN STD_LOGIC_VECTOR ( 15 DOWNTO 0 );
														output 						: OUT STD_LOGIC_VECTOR ( 31 DOWNTO 0 ) );
														END COMPONENT;
														
	COMPONENT mips_alu 				PORT (	ALUControl					: IN	STD_LOGIC_VECTOR( 3 DOWNTO 0);
														inputA, inputB				: IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
														shamt							: IN	STD_LOGIC_VECTOR( 4 DOWNTO 0);
														Zero							: OUT	STD_LOGIC;
														ALU_Result  				: OUT	STD_LOGIC_VECTOR(31 DOWNTO 0) );
														END COMPONENT;

	COMPONENT ram 						PORT (	address						: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
														clock							: IN STD_LOGIC  := '1';
														data							: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
														wren							: IN STD_LOGIC ;
														q								: OUT STD_LOGIC_VECTOR (31 DOWNTO 0) );
														END COMPONENT;												

	COMPONENT rom						PORT (	address						: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
														clock							: IN STD_LOGIC  := '1';
														q								: OUT STD_LOGIC_VECTOR (31 DOWNTO 0) );
														END COMPONENT;		
	BEGIN 	
	
	U1 : mux21 PORT MAP(a0 => a_input,
		 a1 => b_input,
		 s0 => sel(0),
		 y => temp0);
	END signExtImmediate
BEGIN
	PROCESS ( input, leading )
		BEGIN
	END PROCESS;
END arc;
		