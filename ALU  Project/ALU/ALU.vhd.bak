LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.decoder_package.ALL;
USE work.ripple_carry_package.ALL;
USE work.mux2_package.ALL;
USE work.mux4_package.ALL;
USE work.FF_package.ALL;

--ALU Structure
ENTITY ALU IS
	PORT(
			clock : IN STD_LOGIC;
			s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			cin : IN STD_LOGIC;
			output : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			cout : OUT STD_LOGIC
	);
END ALU;

ARCHITECTURE structure OF ALU IS
	SIGNAL c : STD_LOGIC_VECTOR(2 DOWNTO 0); --inner mux selects
	SIGNAL outtemp, carry_in, carry_out, mux_carry_out : STD_LOGIC;
	SIGNAL SEL, ctemp, outemp1, outemp2, outemp3, outemp4, outemp5 : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL At, Bt, btemp1, btemp2, btemp3, btemp4, Bout, Carith, Clogic, Ct : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	BEGIN
		--DFF input (high clock)
		DFF_sel0: DFF PORT MAP(clock, s(0), SEL(0));
		DFF_sel1: DFF PORT MAP(clock, s(1), SEL(1));
		
		DFF_cin: DFF PORT MAP(clock, NOT cin, carry_in);
		
		DFF_A0: DFF PORT MAP(clock, a(0), At(0));
		DFF_A1: DFF PORT MAP(clock, a(1), At(1));
		DFF_A2: DFF PORT MAP(clock, a(2), At(2)); 
		DFF_A3: DFF PORT MAP(clock, a(3), At(3));
		
		DFF_B0: DFF PORT MAP(clock, b(0), Bt(0));
		DFF_B1: DFF PORT MAP(clock, b(1), Bt(1));
		DFF_B2: DFF PORT MAP(clock, b(2), Bt(2));
		DFF_B3: DFF PORT MAP(clock, b(3), Bt(3));
		
		--decode select bits
		DECODE: decoder PORT MAP(SEL, c);
		
		--mux the arithmetic operarions
		ctemp(0) <= c(0);
		ctemp(1) <= c(1);
		
		btemp1(0) <= Bt(0);
		btemp1(1) <= NOT Bt(0);
		btemp1(2) <= '0';
		btemp1(3) <= '0';
		ARITHMUX0: mux4 PORT MAP(btemp1, ctemp, Bout(0));
		
		btemp2(0) <= Bt(1);
		btemp2(1) <= NOT Bt(1);
		btemp2(2) <= '0';
		btemp2(3) <= '0';
		ARITHMUX1: mux4 PORT MAP(btemp2, ctemp, Bout(1));
		
		btemp3(0) <= Bt(2);
		btemp3(1) <= NOT Bt(2);
		btemp3(2) <= '0';
		btemp3(3) <= '0';
		ARITHMUX2: mux4 PORT MAP(btemp3, ctemp, Bout(2));
		
		btemp4(0) <= Bt(3);
		btemp4(1) <= NOT Bt(3);
		btemp4(2) <= '0';
		btemp4(3) <= '0';
		ARITHMUX3: mux4 PORT MAP(btemp4, ctemp, Bout(3));
		
		--ripple carry adder
		ADDER: ripple_carry PORT MAP(carry_in, At, Bout, Carith, carry_out);
		
		--XOR
		Clogic(0) <= At(0) XOR Bt(0);
		Clogic(1) <= At(1) XOR Bt(1);
		Clogic(2) <= At(2) XOR Bt(2);
		Clogic(3) <= At(3) XOR Bt(3);
		
		--Output mux
		outemp1(0) <= Carith(0);
		outemp1(1) <= Clogic(0);
		MUX0: mux2 PORT MAP(outemp1, c(2), Ct(0));
		
		outemp2(0) <= Carith(1);
		outemp2(1) <= Clogic(1);
		MUX1: mux2 PORT MAP(outemp2, c(2), Ct(1));
		
		outemp3(0) <= Carith(2);
		outemp3(1) <= Clogic(2);
		MUX_2: mux2 PORT MAP(outemp3, c(2), Ct(2));
		
		outemp4(0) <= Carith(3);
		outemp4(1) <= Clogic(3);
		MUX3: mux2 PORT MAP(outemp4, c(2), Ct(3));
		
		outemp5(0) <= carry_out;
		outemp5(1) <= '0';
		MUXCOUT: mux2 PORT MAP(outemp5, c(2), mux_carry_out); --for 
		
		--output DFF (low clock)
		DFF_cout: DFF PORT MAP(NOT clock, carry_out, cout);
		
		DFF_S0: DFF PORT MAP(NOT clock, Ct(0), output(0));
		DFF_S1: DFF PORT MAP(NOT clock, Ct(1), output(1));
		DFF_S2: DFF PORT MAP(NOT clock, Ct(2), output(2)); 
		DFF_S3: DFF PORT MAP(NOT clock, Ct(3), output(3));
END structure;

--ALU decoder
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY decoder IS
	PORT(
			sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			c : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END decoder;

ARCHITECTURE logicfunc OF decoder IS
	BEGIN
		c(2) <= sel(0) AND sel(1);
		c(1) <= sel(0) NOR sel(1);
		c(0) <= NOT sel(0) AND sel(1);
END logicfunc;

--decoder package
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE decoder_package IS
	COMPONENT decoder 
		PORT(
				sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				c : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
		);
	END COMPONENT;
END decoder_package;


