library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

entity rw_8x2_sync is
	port(clock : in std_logic;
		address : in std_logic_vector(2 downto 0);
		data_in : in std_logic_vector(1 downto 0);
		we : in std_logic;
		data_out : out std_logic_vector(1 downto 0));
end entity;

architecture rw_8x2_sync_arch of rw_8x2_sync is
	type RW_type is array (0 to 8) of std_logic_vector(1 downto 0);
	signal RW : RW_type;
	
	begin
		MEMORY : process(clock)
			begin
				if (rising_edge(clock)) then
					if (we='1') then RW(to_integer(unsigned(address))) <= data_in;
					else data_out <= RW(to_integer(unsigned(address)));
					end if;
				end if;
		end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

entity rw_8x2_sync_tb is
end entity;

architecture rw_8x2_sync_tb_arch of rw_8x2_sync_tb is
	component rw_8x2_sync 
		port (clock : in std_logic;
			address : in std_logic_vector(2 downto 0);
			data_in : in std_logic_vector(1 downto 0);
			we : in std_logic;
			data_out : out std_logic_vector(1 downto 0));
	end component;
	
	signal clock_tb : std_logic;
	signal address_tb : std_logic_vector(2 downto 0);
	signal data_in_tb : std_logic_vector(1 downto 0);
	signal we_tb : std_logic;
	signal data_out_tb : std_logic_vector(1 downto 0);
	
	begin
	DUT1 : rw_8x2_sync port map (clock=>clock_tb, address=>address_tb, data_in=>data_in_tb, we=>we_tb, data_out=>data_out_tb);
	
	CLOCK : process
	begin
		clock_tb <= '0'; wait for 4ns;
		clock_tb <= '1'; wait for 4ns;
	end process;
	
	STIMULUS : process
	begin
		we_tb <= '1';
		for i in 0 to 7 loop
			wait until rising_edge(clock_tb);
			address_tb <= std_logic_vector(to_unsigned(i,3));
			wait until rising_edge(clock_tb);
			data_in_tb <= "00";
		end loop;
		wait for 200ns;
		
		we_tb <= '0';
		for i in 0 to 7 loop
			wait until rising_edge(clock_tb);
			address_tb <= std_logic_vector(to_unsigned(i,3));
			wait until rising_edge(clock_tb);
			report "address= " & to_string(address_tb) &
				"data_out= " & to_string(data_out_tb);
		end loop;

	end process;

end architecture;
