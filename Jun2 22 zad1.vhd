entity inv is
	port(A : in bit;
		F : out bit);
end entity;

architecture inv_arch is
	begin
		F <= not A;
end architecture;

entity or1 is
	port(A, B, C, D : in bit;
		F : out bit);
end entity;

architecture or1_arch of or1 is
	begin
		F <= A or B or C or D;
end architecture;

entity and1 is
	port(A, B, C, D : in bit;
		F : out bit);
end entity;

architecture and1_arch of and1 is
	begin
		F <= A and B and C and D;
end architecture;


library ieee;
use ieee.ste_logic_1164.all;


entity SistemI is
end entity;

architecture SistemI_arch of SistemI is
	component inv
		port(A : in bit;
		F : out bit);
	end inv;
	
	component or1
		port(A, B, C, D : in bit;
		F : out bit);	
	end component;
	
	component and1
		port(A, B, C, D : in bit;
		F : out bit);
	end component;
	
	signal m1,m3,m9,m11 : bit;
	signal An,Bn,Cn,Dn : bit;
	
	begin
		U1 : inv port map (A=>A, F=>An);
		U2 : inv port map (A=>B, F=>Bn);
		U3 : inv port map (A=>C, F=>Cn);
		U4 : inv port map (A=>D, F=>Dn);
		
		U5 : and1 port map (A=>An, B=>Bn, C=>Cn, D=>D, F=>m1);
		U6 : and1 port map (A=>An, B=>Bn, C=>C, D=>D, F=>m3);
		U7 : and1 port map (A=>A, B=>Bn, C=>Cn, D=>Dn, F=>m9);
		U8 : and1 port map (A=>A, B=>Bn, C=>C, D=>Dn, F=>m11);
		
		U9 : or1 port map (A=>m1, B=>m3, C=>m9, D=>m11, F=>F);
		
end architecture;
