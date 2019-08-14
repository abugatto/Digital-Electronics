LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY DFF IS
	PORT(
			CLK, D : IN STD_LOGIC;
			Q : OUT STD_LOGIC
	);
END DFF;

ARCHITECTURE behavior OF DFF IS
	BEGIN
		PROCESS(CLK)
			BEGIN
				IF CLK'EVENT AND CLK = '1' THEN --rising edge
					Q <= D;
				END IF;
		END PROCESS;
END behavior;

--declare package
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE FF_package IS
	COMPONENT DFF 
		PORT(
				CLK, D : IN STD_LOGIC;
				Q : OUT STD_LOGIC
		);
	END COMPONENT;
END FF_package;