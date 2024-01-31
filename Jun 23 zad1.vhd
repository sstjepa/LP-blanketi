entity inv is
	port(A : in bit;
		F : out bit);
end entity;

architecture inv_arch of inv is
	begin
		F <= not A;
end architecture;

entity or1 is
	port(A,B,C,D : in bit;
		F : out bit);
end entity;

architecture or1_arch of or1 is
	begin
		F <= A or B or C or D;
	
end architecture;

entity and1 is
	port(A,B,C,D : in bit;
		F : out bit);
end entity;

architecture and1_arch of and1 id
	begin
		F <= A and B and C and D;

end architecture;

entity SistemI is
	port(A,B,C,D : in bit;
		F : out bit);
end entity;

architecture SistemI_arch of SistemI is
	component inv1
		port(A : in bit;
		F : out bit);
	end component;
	
	component or1
		port(A,B,C,D : in bit;
		F : out bit);
	end component;
	
	component and1
		port(A,B,C,D : in bit;
		F : out bit);
	end component;
	
	signal An, Bn, Cn, Dn : bit;
	signal m1, m2, m3, m4 : bit;
	
	begin
	
	U1 : inv port map (A=>A, F=>An);
	U2 : inv port map (A=>B, F=>Bn);
	U3 : inv port map (A=>C, F=>Cn);
	U4 : inv port map (A=>D, F=>Dn);
	
	U5 : and1 port map (A=>An, B=>Bn, C=>Cn, D=>D, F=>m1);
	U6 : and1 port map (A=>An, B=>Bn, C=>C, D=>D, F=>m2);
	U7 : and1 port map (A=>A, B=>Bn, C=>Cn, D=>D, F=>m3);
	U8 : and1 port map (A=>A, B=>Bn, C=>C, D=>D, F=>m4);
	
	U9 : or1 port map (A=>m1, B=>m2, C=>m3, D=>m4, F=>F);
	
end architecture;