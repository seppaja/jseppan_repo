Library ieee;
use ieee.std_logic_1164.all;

entity CRC_RX is
	generic (initti: std_logic_vector(7 downto 0):= "00000000");
	port(
		clk, init, serial_in, en_crc, en_ok:in std_logic;
		serial_out, ok:out std_logic
	);
end CRC_RX;

architecture RTL of CRC_RX is
	signal x:std_logic_vector(7 downto 0);
	signal x7,x6,x5,x4,x3,x2,x1,x0:std_logic;
	signal k : std_logic;
	begin
		shift_reg: process(clk, init)
	begin
		if init = '0' then x<=initti;
		elsif rising_edge(clk) then
			x(7)<=x7;
			x(6)<=x6;
			x(5)<=x5;
			x(4)<=x4;
			x(3)<=x3;
			x(2)<=x2;
			x(1)<=x1;
			x(0)<=x0;
			if en_ok = '1' then ok <= k;
			end if;
		end if;
	end process;
	x7<=x(0) xor serial_in when en_crc = '1' else '0';
	x6<=x(7);
	x5<=x7 xor x(6);
	x4<=x7 xor x(5);
	x3<=x7 xor x(4);
	x2<=x(3);
	x1<=x(2);
	x0<=x(1);
	serial_out<=serial_in when en_crc = '1' else x(0);
	k<=not(x(0)or x(1) or x(2) or x(3) or x(4) or x(5) or x(6) or x(7)); 
end architecture;