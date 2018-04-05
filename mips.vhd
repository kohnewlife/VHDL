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
	COMPONENT mux21 PORT( a0,a1,s0 : IN STD_LOGIC;
 y : OUT STD_LOGIC); END COMPONENT;
 
BEGIN
	PROCESS ( input, leading )
		BEGIN
	END PROCESS;
END arc;
		