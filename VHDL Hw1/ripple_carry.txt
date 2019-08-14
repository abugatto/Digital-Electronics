LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.fulladd_package.ALL;

ENTITY ripple_carry IS
	PORT(
		cin : IN STD_LOGIC;
		x, y : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		s : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		cout : OUT STD_LOGIC
	);
END ripple_carry;

ARCHITECTURE structure OF ripple_carry IS
		SIGNAL c : STD_LOGIC_VECTOR(2 DOWNTO 0);
	BEGIN
		stage0: fulladd PORT MAP(cin, x(0), y(0), s(0), c(0));
		stage1: fulladd PORT MAP(c(0), x(1), y(1), s(1), c(1));
		stage2: fulladd PORT MAP(c(1), x(2), y(2), s(2), c(2));
		stage3: fulladd PORT MAP(c(2), x(3), y(3), s(3), cout);
END structure;

--declare package
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE ripple_carry_package IS
	COMPONENT ripple_carry 
		PORT(
				cin : IN STD_LOGIC;
				x, y : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				s : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				cout : OUT STD_LOGIC
			);
	END COMPONENT;
END ripple_carry_package;