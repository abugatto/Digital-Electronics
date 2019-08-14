LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.mux2_package.ALL;

ENTITY sev_seg IS
	PORT (
			input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			led, led_carry : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
END sev_seg;

ARCHITECTURE structure OF sev_seg IS
	SIGNAL 	z : STD_LOGIC;
	SIGNAL 	A, t : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	--comparator
	z <= (input(3) AND (input(0) AND input(1)));
	
	--A
	A(1) <= input(3) AND input(2) AND input(1);
	A(2) <= input(3) AND input(2) AND NOT input(1);
	A(3) <= (input(0) AND input(3)) AND (input(1) OR input(2));
	
	--mux
	mux_0: mux2 PORT MAP(input(3), '0', z, t(3));
	mux_1: mux2 PORT MAP(input(2), A(1), z, t(2));
	mux_2: mux2 PORT MAP(input(1), A(2), z, t(1));
	mux_3: mux2 PORT MAP(input(0), A(3), z, t(0));
	
	--B
	led_carry(0) <= NOT z;
	led_carry(1) <= NOT z;
	led_carry(2) <= NOT z;
	led_carry(3) <= NOT z;
	led_carry(4) <= '1';
	led_carry(5) <= '1';
	led_carry(6) <= '0';
	
	--decoder
	led(0) <= t(3) OR t(1) OR (t(2) AND t(0)) OR NOT (t(2) AND t(0));
	led(1) <= NOT t(2) OR (NOT t(1) AND NOT t(0)) OR (t(1) AND t(0));
	led(2) <= t(2) OR NOT t(1) OR t(0);
	led(3) <= (NOT t(0) AND NOT t(2)) OR (t(1) AND NOT t(0)) OR (t(2) AND NOT t(1) AND t(0)) OR (NOT t(2) AND t(1)) OR t(3);
	led(4) <= (NOT t(2) AND NOT t(0)) OR (t(1) AND NOT t(0));
	led(5) <= t(3) OR (NOT t(0) AND NOT t(1)) OR (NOT t(1) OR t(2)) OR (t(2) AND NOT t(0));
	led(6) <= t(3) OR (t(2) AND NOT t(1)) OR (NOT t(2) AND t(1)) OR (t(1) AND NOT t(0));
END structure;

----------------------------------------------------------------------

--MUX
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

--2x1
ENTITY mux2 IS
	PORT(
			in1, in2, sel : IN STD_LOGIC;
			output : OUT STD_LOGIC		
	);
END mux2;

ARCHITECTURE logicfunc OF mux2 IS
	BEGIN
		output <= (in1 AND NOT sel) OR (in2 AND sel);
END logicfunc;

--MUX package
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE mux2_package IS	
	COMPONENT mux2 
		PORT(
				in1, in2, sel : IN STD_LOGIC;
				output : OUT STD_LOGIC
		);
	END COMPONENT;
END mux2_package;