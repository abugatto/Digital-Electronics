LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

--2x1
ENTITY mux2 IS
	PORT(
			input : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			sel : IN STD_LOGIC;
			output : OUT STD_LOGIC		
	);
END mux2;

ARCHITECTURE logicfunc OF mux2 IS
	BEGIN
		output <= (input(0) AND NOT sel) OR (input(1) AND sel);
END logicfunc;

--MUX package
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE mux2_package IS	
	COMPONENT mux2 
		PORT(
				input : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				sel : IN STD_LOGIC;
				output : OUT STD_LOGIC
		);
	END COMPONENT;
END mux2_package;

--4x1
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.mux2_package.ALL;

ENTITY mux4 IS
	PORT(
			input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			output : OUT STD_LOGIC	
	);
END mux4;

ARCHITECTURE structure OF mux4 IS
	SIGNAL inp1, inp2, temp: STD_LOGIC_VECTOR(1 DOWNTO 0);
	
	BEGIN
		inp1(0) <= input(0);
		inp1(1) <= input(1);
		inp2(0) <= input(2);
		inp2(1) <= input(3);
	
		stage0_0: mux2 PORT MAP(inp1, sel(0), temp(0));
		stage0_1: mux2 PORT MAP(inp2, sel(0), temp(1));
		stage1: mux2 PORT MAP(temp, sel(1), output);
END structure;

--MUX package
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE mux4_package IS	
	COMPONENT mux4 
		PORT(
				input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				output : OUT STD_LOGIC	
		);
	END COMPONENT;
END mux4_package;