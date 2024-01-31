entity encoder_8to3 is
	port(A : in bit_vector(7 downto 0);
		F : out bit_vector(2 downto 0));
end entity;

architecture encoder_8to3_arch of encoder_8to3 is
	begin
	--Selekciona dodela
		with A select
			F <= "000" when "00000001",
				"001" when "00000010",
				"010" when "00000100",
				"011" when "00001000",
				"100" when "00010000",
				"101" when "00100000",
				"110" when "01000000",
				"111" when "10000000";
				
	--Uslovna dodela
		F <= "000" when (A="00000001") else
			"001" when (A="00000010") else
			"010" when (A="00000100") else
			"011" when (A="00001000") else
			"100" when (A="00010000") else
			"101" when (A="00100000") else
			"110" when (A="01000000") else
			"111" when (A="10000000");
			

end architecture;