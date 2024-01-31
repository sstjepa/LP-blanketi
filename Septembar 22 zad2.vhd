library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

entity rw_4x4_async is
	port(address : in std_logic_vector(1 downto 0);
		data_in : in std_logic_vector(3 downto 0);
		we : in std_logic;
		data_out : out std_logic_vector(3 downto 0));
end entity;

architecture rw_4x4_async_arch of rw_4x4_async is
	type RW_type is array (0 to 3) of std_logic_vector(3 downto 0);
	signal RW : RW_type;
	
	begin
	MEMORY : process (address, data_in, we)
		begin
			if (we='1') then RW(to_integer(unsigned(address))) <= data_in;
			else data_out <= RW(to_integer(unsigned(address)));
			end if;
	end process;

end architecture;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

entity rw_4x4_async_tb is
end entity;

architecture rw_4x4_async_tb_arch of rw_4x4_async_tb is
	component rw_4x4_async
		port(address : in std_logic_vector(1 downto 0);
			data_in : in std_logic_vector(3 downto 0);
			we : in std_logic;
			data_out : out std_logic_vector(3 downto 0));
	end component;
	
	signal address_tb : std_logic_vector(1 downto 0);
	signal data_in_tb : std_logic_vector(3 downto 0);
	signal we_tb : std_logic;
	signal data_out_tb : std_logic_vector(3 downto 0);
	
	begin
	DUT1 : rw_4x4_async port map (address=>address_tb, data_in=>data_in_tb, we=>we_tb, data_out=>data_out_tb);
	
	STIMULUS : process
		begin
			we_tb <= '1';
			for i in 0 to 3 loop
				address_tb <= std_logic_vector(to_unsigned(i,2));
				data_in_tb <= std_logic_vector(to_unsigned(i,4));
			end loop;
			wait for 120ns;
			
			we_tb <= '0';
			for i in 0 to 3 loop
				report "adress= " & to_string(address_tb) &
						"data_out= " & to_string(data_out_tb);
			end loop;
			wait for 120ns;
	
	end process;

end architecture;