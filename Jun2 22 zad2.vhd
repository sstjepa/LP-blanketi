library ieee;
use ieee.std_logic_1164.all;

entity fsm1_behaviaroal is
	port(clock, reset : in std_logic;
		Din : in std_logic;
		Dout : in std_logic);
end entity;

architecture fsm1_behaviaroal_arch of fsm1_behaviaroal is
	subtype State_type  is std_logic_vector(2 downto 0);
	constant Start : State_type := "001";
	constant Midway : State_type := "010";
	constant Done : State_type := "100";
	signal current_state, next_state : State_type;

	begin
	
	STATE_MEMORY : process (clock, reset)
		begin 
			if (reset='0') then current_state <= Start;
			elseif (rising_edge(clock)) then current_state <= next_state;
			end if;	
	end process;
	
	
	NEXT_STATE_LOGIC : process (current_state, Din)
		begin
			case (current_state) is
				when Start => if(Din='1') then next_state <= Midway;
								else then next_state <= Start;
								end if;
				when Midway => next_state <= Done;
				when Done => next_state <= Start;
			end case;
	end process;
	
	
	OUTPUT_LOGIC : process (current_state, Din)
		begin
			case (current_state) is
				when Done => if(Din='1') then Dout <= '1';
							else Dout <= '0';
							end if;
				when others => Dout <= '0';
			end case;
	end process;


end architecture;