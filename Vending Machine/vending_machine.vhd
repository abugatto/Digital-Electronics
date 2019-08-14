LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY vending_machine IS
	PORT(
			clock, reset: IN STD_LOGIC;
			w : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			z : OUT STD_LOGIC
	);
END vending_machine;

ARCHITECTURE behavioral OF vending_machine IS
	TYPE STATE_TYPE IS(A,B,C,D,E,F,G,S);
	SIGNAL state : STATE_TYPE;
	
BEGIN
	PROCESS(clock)
	BEGIN
		IF RESET = '1' THEN
			state <= S;
		ELSIF clock'event AND clock = '1' THEN
			CASE state IS
				WHEN S =>
					IF w(1) = '1' AND w(0) = '1' THEN
						state <= A;
					ELSIF w(1) = '1' AND w(0) = '0' THEN
						state <= B;
					ELSIF w(1) = '0' AND w(0) = '1' THEN
						state <= E;
					ELSIF w(1) = '0' AND w(0) = '0' THEN
						state <= S;
					END IF; 
				WHEN A =>
					IF w(1) = '1' AND w(0) = '1' THEN
						state <= B;
					ELSIF w(1) = '1' AND w(0) = '0' THEN
						state <= C;
					ELSIF w(1) = '0' AND w(0) = '1' THEN
						state <= F;
					ELSIF w(1) = '0' AND w(0) = '0' THEN
						state <= A;
					END IF; 
				WHEN B =>
					IF w(1) = '1' AND w(0) = '1' THEN
						state <= C;
					ELSIF w(1) = '1' AND w(0) = '0' THEN
						state <= D;
					ELSIF w(1) = '0' AND w(0) = '1' THEN
						state <= G;
					ELSIF w(1) = '0' AND w(0) = '0' THEN
						state <= B;
					END IF; 
				WHEN C =>
					IF w(1) = '1' AND w(0) = '1' THEN
						state <= D;
					ELSIF w(1) = '1' AND w(0) = '0' THEN
						state <= E;
					ELSIF w(1) = '0' AND w(0) = '1' THEN
						state <= G;
					ELSIF w(1) = '0' AND w(0) = '0' THEN
						state <= C;
					END IF; 
				WHEN D =>
					IF w(1) = '1' AND w(0) = '1' THEN
						state <= E;
					ELSIF w(1) = '1' AND w(0) = '0' THEN
						state <= F;
					ELSIF w(1) = '0' AND w(0) = '1' THEN
						state <= G;
					ELSIF w(1) = '0' AND w(0) = '0' THEN
						state <= D;
					END IF; 
				WHEN E =>
					IF w(1) = '1' AND w(0) = '1' THEN
						state <= F;
					ELSIF w(1) = '1' AND w(0) = '0' THEN
						state <= G;
					ELSIF w(1) = '0' AND w(0) = '1' THEN
						state <= G;
					ELSIF w(1) = '0' AND w(0) = '0' THEN
						state <= E;
					END IF; 
				WHEN F =>
					IF w(1) = '1' AND w(0) = '1' THEN
						state <= G;
					ELSIF w(1) = '1' AND w(0) = '0' THEN
						state <= G;
					ELSIF w(1) = '0' AND w(0) = '1' THEN
						state <= G;
					ELSIF w(1) = '0' AND w(0) = '0' THEN
						state <= F;
					END IF; 
				WHEN G =>
					IF w(1) = '1' AND w(0) = '1' THEN
						state <= S;
					ELSIF w(1) = '1' AND w(0) = '0' THEN
						state <= S;
					ELSIF w(1) = '0' AND w(0) = '1' THEN
						state <= S;
					ELSIF w(1) = '0' AND w(0) = '0' THEN
						state <= G;
					END IF; 
			END CASE;
		END IF;
	END PROCESS;
	
	z <= '1' WHEN state = G ELSE '0';
END behavioral;