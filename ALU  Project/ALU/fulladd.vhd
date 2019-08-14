LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY fulladd IS
	PORT(
			cin, x, y : IN STD_LOGIC;
			s, cout : OUT STD_LOGIC
		);
END fulladd;

ARCHITECTURE logicfunc OF fulladd IS
	BEGIN
		s <= x XOR y XOR cin;
		cout <= (x AND y) OR (cin AND x) OR (cin AND y);
END logicfunc;

--declare package
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE fulladd_package IS
	COMPONENT fulladd 
		PORT(
				cin, x, y : IN STD_LOGIC;
				s, cout : OUT STD_LOGIC
			);
	END COMPONENT;
END fulladd_package;
