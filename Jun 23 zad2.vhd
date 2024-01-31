library ieee;
use ieee.std_logic_1164.all;

entity krug is
	port(clock, reset : in std_logic;
		Din : in std_logic;
		Dout : out std_logic);
end entity;

architecture krug_arch of krug is
	subtype State_Type is std_logic_vector(3 downto 0);
	constant s0 : State_Type := "0001";
	constant s1 : State_Type := "0010";
	constant s2 : State_Type := "0100";
	constant s3 : State_Type := "1000";
	signal current_state, next_state : State_Type;
	
	begin
	
		STATE_MEMORY : process(clock, reset)
			begin
				if (reset='0') then current_state <= s0;
				elseif (rising_edge(clock)) then current_state <= next_state;
				end if;			
		end process;
		
		NEXT_STATE_LOGIC : process(current_state, Din)
			begin
				case (current_state) is
					when s0 => if(Din='1') then next_state <= s2;
								else next_state <= s1;
								end if;
					when s1 => if(Din='1') then next_state <= s3;
								else next_state <= s0;
								end if;
					when s2 => if(Din='1') then next_state <= s0;
								else next_state <= s3;
								end if;
					when s3 => if(Din='1') then next_state <= s1;
								else next_state <= s2;
								end if;
				end case;
		end process;

		OUTPUT_LOGIC : process(current_state)
			begin
				case (current_state) is
					when s0 => Dout <= '1';
					when others => Dout <= '0';				
				end case;
			
		end process;

end architecture;
