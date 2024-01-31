library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

entity rom_4x4_async is
	port(address : in std_logic_vector(1 downto 0);
		data_out : out std_logic_vector(3 downto 0));	
end entity;

architecture rom_4x4_async_arch of rom_4x4_async is
	type ROM_type is array (0 to 3) of std_logic_vector(3 downto 0);

	constant ROM: ROM_type := (0 => "1110",
								1 => "0010",
								2 => "1111",
								3 => "0100");
	begin
		data_out <= ROM(to_integer(unsigned(address)));
		
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

entity rom_4x4_async_tb is
end entity;

architecture rom_4x4_async_tb_arch of rom_4x4_async_tb is
	component rom_4x4_async
		port(address : in std_logic_vector(1 downto 0);
			data_out : out std_logic_vector(3 downto 0));
	end component;
	
	signal address_tb : std_logic_vector(1 downto 0);
	signal data_out_tb : std_logic_vector(3 downto 0);
	
	begin
	DUT1 : rom_4x4_async port map(address=>address_tb, data_out=>data_out_tb);
	
	STIMULUS : process
		begin
			for i in 0 to 3 loop
				address_tb <= std_logic_vector(to_unsigned(i,2));
				report "address= " & to_string(address_tb) &
						"data_out= " & to_string(data_out_tb);
			
			end loop;
			wait;
	
	end process;

end architecture;



####### SINHRONI #####



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

entity rom_4x4_sync is
	port(clock : in std_logic;
		address : in std_logic_vector(1 downto 0);
		data_out : out std_logic_vector(3 downto 0));	
end entity;

architecture rom_4x4_sync_arch of rom_4x4_sync is
	type ROM_type is array (0 to 3) of std_logic_vector(3 downto 0);

	constant ROM: ROM_type := (0 => "1110",
								1 => "0010",
								2 => "1111",
								3 => "0100");
	begin
		MEMORY : process(clock)
			begin
				if(rising_edge(clock)) then data_out <= ROM(to_integer(unsigned(address)));
				end if;
		end process;
		
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

entity rom_4x4_sync_tb is
end entity;

architecture rom_4x4_sync_tb_arch of rom_4x4_sync_tb is
	component rom_4x4_sync
		port(clock : in std_logic;
			address : in std_logic_vector(1 downto 0);
			data_out : out std_logic_vector(3 downto 0));
	end component;
	
	signal clock_tb : std_logic;
	signal address_tb : std_logic_vector(1 downto 0);
	signal data_out_tb : std_logic_vector(3 downto 0);
	
	begin
	DUT1 : rom_4x4_sync port map(clock=>clock_tb, address=>address_tb, data_out=>data_out_tb);
	
	CLOCK_PROCESS : process
		begin
			clock_tb <= '0'; wait for 5ns;
			clock_tb <= '1'; wait for 5ns;
	
	end process;
	
	STIMULUS : process
		begin
			for i in 0 to 3 loop
				wait until rising_edge(clock_tb);
				address_tb <= std_logic_vector(to_unsigned(i,2));
				wait until rising_edge(clock_tb);
				report "address= " & to_string(address_tb) &
						"data_out= " & to_string(data_out_tb);
			
			end loop;
			wait;
	
	end process;

end architecture;