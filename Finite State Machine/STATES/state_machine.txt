LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.FF_package.ALL;

ENTITY state_machine IS
	PORT(
			clock, reset, W : IN STD_LOGIC;
			Z : OUT STD_LOGIC
	);
END state_machine;

ARCHITECTURE behavioral OF state_machine IS
	TYPE STATE_TYPE IS (A, B, C, D, E, F, G, H, I, J, K, R);
	SIGNAL state : STATE_TYPE;

	BEGIN
		PROCESS(clock)
			BEGIN 
				IF reset = '1' THEN
					state <= R;
				ELSIF clock'EVENT AND clock = '1' THEN --RISING EDGE
					CASE state IS
						WHEN R =>
							IF W = '0' THEN
								state <= A;
							ELSE
								state <= E;
							END IF;
						WHEN A =>
							IF W = '0' THEN
								state <= B;
							ELSE
								state <= A;
							END IF;
						WHEN B =>
							IF W = '0' THEN
								state <= A;
							ELSE
								state <= C;
							END IF;
						WHEN C =>
							IF W = '0' THEN
								state <= F;
							ELSE
								state <= D;
							END IF;
						WHEN D =>
							IF W = '0' THEN
								state <= F;
							ELSE
								state <= J;
							END IF;
						WHEN E =>
							IF W = '0' THEN
								state <= F;
							ELSE
								state <= I;
							END IF;
						WHEN F =>
							IF W = '0' THEN
								state <= G;
							ELSE
								state <= E;
							END IF;
						WHEN G =>
							IF W = '0' THEN
								state <= B;
							ELSE
								state <= H;
							END IF;
						WHEN H =>
							IF W = '0' THEN
								state <= F;
							ELSE
								state <= D;
							END IF;
						WHEN I =>
							IF W = '0' THEN
								state <= F;
							ELSE
								state <= J;
							END IF;
						WHEN J =>
							IF W = '0' THEN
								state <= F;
							ELSE
								state <= K;
							END IF;
						WHEN K =>
							IF W = '0' THEN
								state <= F;
							ELSE
								state <= K;
							END IF;
					END CASE;
				END IF;
		END PROCESS;
		
	Z <= '1' WHEN state = D OR state = H OR state = K ELSE '0';
END behavioral;