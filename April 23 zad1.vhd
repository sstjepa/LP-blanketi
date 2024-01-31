library ieee;

entity encoder_8to3_binary is
	port(A : in bit_vector(7 downto 0);
		F : out bit_vector(2 downto 0));
end entity;

architecture encoder_8to3_binary_arch of encoder_8to3_binary is
	begin
	with (A) select
		F<= "000" when "00000001",
			"001" when "00000010",
			"010" when "00000100",
			"011" when "00001000",
			"100" when "00010000",
			"101" when "00100000",
			"110" when "01000000",
			"111" when "10000000";
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity encoder_8to3_binary_tb is
end entity;

architecture encoder_8to3_binary_tb_arch of encoder_8to3_binary_tb is
	component encoder_8to3_binary
		port(A : in bit_vector(7 downto 0);
			F : out bit_vector(2 downto 0));
	end component;
	
	signal A_tb : bit_vector(7 downto 0);
	signal F_tb : bit_vector(2 downto 0);
	
	begin
	DUT1 : encoder_8to3_binary port map (A => A_tb, F => F_tb);
	
	STIMULUS : process
		file Fout : TEXT open WRITE_MODE is "izlaz.txt";
		file Fin : TEXT open READ_MODE is "ulaz.txt";
		variable current_wline : line;
		variable current_rline : line;
		variable current_a : bit_vector(7 downto 0);
		
		begin
			for i in 0 to 7 loop
				readline(Fin, current_rline);
				read(current_rline, current_a);
				
				A_tb <= current_a;
				wait for 120ns;
				
				write(current_wline, string'("A= "));
				write(current_wline, A_tb);
				write(current_wline, string'("F= "));
				write(current_wline, F_tb);
				writeline(Fout, current_wline);
			end loop;
			wait;
			
	end process;

end architecture;