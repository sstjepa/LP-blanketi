library ieee;
use ieee.std_logic_1164.all;

entity fsm2 is
	port(Clock, Reset : in std_logic;
		Din : in std_logic;
		Dout : out std_logic);
end entity;

architecture fsm2_arch of fsm2 is
	subtype State_Type is std_logic_vector(3 donwto 0);
	constant s0 : State_Type := '0001';
	constant s1 : State_Type := '0010';
	constant s2 : State_Type := '0100';
	constant s3 : State_Type := '1000';
	signal current_state, next_state : State_Type;
	
	begin
		STATE_MEMORY : process (Clock, Reset)
			begin
				if (Reset='0') then current_state <= Start;
				elseif (rising_edge(Clock)) then current_state <= next_state;
				end if;
		end process;
		
		NEXT_STATE_LOGIC : process (current_state, Din)
			begin
				case (current_state) is
					when s0 => if (Din='0') then next_state <= s0;
								else next_state <= s1;
								end if;
					when s1 => if (Din='0') then next_state <= s2;
								else next_state <= s3;
								end if;
					when s2 => if (Din='0') then next_state <= s0;
								else next_state <= s3;
								end if;
					when s3 => if (Din='0') then next_state <= s3;
								else next_state <= s0;
								end if;				
				end case;
		end process;
		
		OUTPUT_LOGIC : process (current_state, Din)
			begin
				case (current_state) is
					when s1 => if (Din='0') then Dout <= '1';
								else Dout <= '0';
								end if;
					when others => if (Din='1') then Dout <= '1';
									else Dout <= '0';
									end if;				
				end case;
		end process;
end architecture;