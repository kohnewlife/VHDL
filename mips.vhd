ENTITY mips IS
	PORT(	reset										:	IN	STD_LOGIC;
			slow_clock, fast_clock				:	IN	STD_LOGIC;
			PC_out, Instruction_out				:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			Read_reg1_out, Read_reg2_out		:	OUT STD_LOGIC_VECTOR(4  DOWNTO 0);
			Write_reg_out							:	OUT STD_LOGIC_VECTOR(4  DOWNTO 0);
			Read_data1_out, Read_data2_out	:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			Write_data_out							:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END mips;

ARCHITECTURE arc OF mips IS
	SIGNAL rom2op, rom2funct						: STD_LOGIC_VECTOR ( 5 DOWNTO 0 );		-- rom to opcode
	SIGNAL rom2rr1, rom2rr2, rom2wr, rom2sh			: STD_LOGIC_VECTOR ( 4 DOWNTO 0 );		-- rom to read_reg1, read_reg2, write_reg
	SIGNAL rom2imme									: STD_LOGIC_VECTOR ( 15 DOWNTO 0 );
	
	BEGIN
	COMPONENT clk_div 				PORT (	clock_48Mhz					: IN	STD_LOGIC;
														clock_1MHz					: OUT	STD_LOGIC;
														clock_100KHz				: OUT	STD_LOGIC;
														clock_10KHz					: OUT	STD_LOGIC;
														clock_1KHz					: OUT	STD_LOGIC;
														clock_100Hz					: OUT	STD_LOGIC;
														clock_10Hz					: OUT	STD_LOGIC;
														clock_1Hz					: OUT	STD_LOGIC);
														END COMPONENT;
														
	COMPONENT counter 							PORT (	INBUS : IN STD_LOGIC_VECTOR(31 downTO 0);
														clk, reset	: IN STD_LOGIC;
														OUTBUS  : OUT STD_LOGIC_VECTOR(31 downTO 0));
														END COMPONENT;
	
	COMPONENT rom								PORT (	address						: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
														clock							: IN STD_LOGIC  := '1';
														q								: OUT STD_LOGIC_VECTOR (31 DOWNTO 0) );
														END COMPONENT;	
														
	COMPONENT mipsControl						PORT (	opcode						:	IN	STD_LOGIC_VECTOR(5 DOWNTO 0);
														funct							:	IN STD_LOGIC_VECTOR(5 DOWNTO 0);
														RegDst, ALUSrc				:	OUT STD_LOGIC;
														Jump, jal, Jr				:	OUT STD_LOGIC;
														Beq, Bne						:	OUT STD_LOGIC;
														MemRead, MemWrite			:	OUT STD_LOGIC;
														RegWrite, MemtoReg		:	OUT STD_LOGIC;
														ALUControl					:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0)	);
														END COMPONENT;
													
	COMPONENT mips_register_file				PORT (	clock, reset, RegWrite	: IN	STD_LOGIC;
														read_reg1, read_reg2		: IN	STD_LOGIC_VECTOR( 4 DOWNTO 0);
														write_reg					: IN	STD_LOGIC_VECTOR( 4 DOWNTO 0);
														write_data					: IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
														read_data1, read_data2  : OUT	STD_LOGIC_VECTOR(31 DOWNTO 0) );
														END COMPONENT;
														
	COMPONENT signExtImmediate 					PORT ( 	input							: IN STD_LOGIC_VECTOR ( 15 DOWNTO 0 );
														output 						: OUT STD_LOGIC_VECTOR ( 31 DOWNTO 0 ) );
														END COMPONENT;
														
	COMPONENT mips_alu 							PORT (	ALUControl					: IN	STD_LOGIC_VECTOR( 3 DOWNTO 0);
														inputA, inputB				: IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
														shamt							: IN	STD_LOGIC_VECTOR( 4 DOWNTO 0);
														Zero							: OUT	STD_LOGIC;
														ALU_Result  				: OUT	STD_LOGIC_VECTOR(31 DOWNTO 0) );
														END COMPONENT;

	COMPONENT ram 								PORT (	address						: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
														clock							: IN STD_LOGIC  := '1';
														data							: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
														wren							: IN STD_LOGIC ;
														q								: OUT STD_LOGIC_VECTOR (31 DOWNTO 0) );
														END COMPONENT;												
	
	BEGIN 	
	
	U1 : counter 							PORT MAP (	INBUS => ??? -- how to specify the rom one
														clk =>,
														reset =>,
														OUTBUS =>,
													);
													 
	U2	:	rom								PORT MAP (	address =>
														clock =>
														q(31 DOWNTO 26) => rom2op, 
														q(25 DOWNTO 21) => rom2rr1,
														q(20 DOWNTO 16) => rom2rr2,
														q(15 DOWNTO 0) => rom2imme,
														q(15 DOWNTO 11) => rom2wr,		-- TODO: determine whether rt or rt goes to write register
														q(10 DOWNTO 6) => rom2sh, 		-- goes to shamt????
														q(5 DOWNTO 0) => rom2funct
													);
														
	U3	:	mipsControl						PORT MAP (	opcode => rom2op, 
														funct => rom2funct,
														RegDst =>,
														ALUSrc =>,
														Jump =>,
														jal =>,
														Jr =>,
														Beq =>,
														Bne =>,
														MemRead =>,
														MemWrite =>,
														RegWrite =>,
														MemtoReg =>,
														ALUControl =>);

	U4	:	mips_register_file				PORT MAP (	clock =>, 
														reset =>,
														RegWrite =>,
														read_reg1 => rom2rr1,
														read_reg2 => rom2rr2,
														write_reg => rom2wr,		-- TODO: determine rt or rd
														write_data =>,
														read_data1 =>,
														read_data2 =>);

	U5	:	signExtImmediate				PORT MAP (	input => rom2imme, 
														output => );

	U6	:	mips_alu						PORT MAP (	ALUControl =>, 
														inputA =>,
														inputB =>,
														shamt => rom2sh
														Zero =>,
														ALU_Result =>);
	
	U7	:	ram								PORT MAP (	address =>, 
														clock =>,
														data =>,
														wren =>,
														q =>);
														
	END mips
	
BEGIN
	PROCESS ( input, leading )
		BEGIN
	END PROCESS;
END arc;
		