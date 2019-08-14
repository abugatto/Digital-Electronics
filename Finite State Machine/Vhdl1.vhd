LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.FF_package.ALL;

ENTITY vhdl1 IS
	PORT(
			clock, W : IN STD_LOGIC;
			Z : OUT STD_LOGIC
	);
END vhdl1;

ARCHITECTURE structural OF vhdl1 IS
	SIGNAL PRES : STD_LOGIC_VECTOR(3 DOWNTO 0); --Y
	SIGNAL NXT : STD_LOGIC_VECTOR(3 DOWNTO 0); --y

	BEGIN
		-- Y(0) = y(1)y(2)'W + y(1)y(3)W + y(0)y(3)W + y(0)y(2)W
		PRES(0) <= (NXT(1) AND NOT NXT(2) AND W) OR (NXT(1) AND NXT(3) AND W) OR (NXT(0) AND NXT(3) AND W) OR (NXT(0) AND NXT(2) AND W);
		
		-- Y(1) = y(0)W' + y(1)y(2)'W' + y(1)y(2)y(3)' + y(0)y(2)'y(3)' + y(0)'y(1)'y(2)y(3)
		PRES(1) <= (NXT(0) AND NOT W) OR (NXT(1) AND NOT NXT(2) AND NOT W) OR (NXT(0) AND NOT NXT(2) AND NOT NXT(3)) OR (NOT NXT(0) AND NOT NXT(1) AND NXT(2) AND NXT(3));
		
		-- Y(2) = y(1)W' + y(3)W' + y(0)y(3) + y(0)W' + y(1)'y(2)y(3)'W + y(0)'y(2)'y(3)'W
		PRES(2) <= (NXT(1) AND NOT W) OR (NXT(3) AND NOT W) OR (NXT(0) AND NXT(3)) OR (NXT(0) AND NOT W) OR (NOT NXT(1) AND NXT(2) AND NXT(3) AND NOT W) 
					OR (NOT NXT(0) AND NOT NXT(2) AND NOT NXT(3) AND W);
		
		-- Y(3) = y(0)'y(2)y(3)' + y(0)y(2)W + y(0)'y(1)'y(3)'W' + y(0)'y(2)'y(3)W
		PRES(3) <= (NOT NXT(0) AND NXT(2) AND NOT NXT(3)) OR (NXT(0) AND NXT(2) AND W) OR (NOT NXT(0) AND NOT NXT(1) AND NOT NXT(2) AND NXT(3) AND W);
		
		DFF_0: DFF PORT MAP(clock, PRES(0), NXT(0));
		DFF_1: DFF PORT MAP(clock, PRES(1), NXT(1));
		DFF_2: DFF PORT MAP(clock, PRES(2), NXT(2)); 
		DFF_3: DFF PORT MAP(clock, PRES(3), NXT(3));
		
		-- Z = y(1)y(2)'y(3)' + y(0)y(2)'y(3)' + y(0)y(2)y(3)
		Z <= (NXT(1) AND NOT NXT(2) AND NOT NXT(3)) OR (NXT(0) AND NOT NXT(2) AND NOT NXT(3)) OR (NXT(0) AND NXT(2) AND NXT(3));
END structural;