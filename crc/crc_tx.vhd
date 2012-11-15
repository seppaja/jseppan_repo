Library ieee;
use ieee.std_logic_1164.all;

entity CRC_TX is
	generic (initti: std_logic_vector(7 downto 0):= "00000000");
	port(
		clk, init, serial_in, en_crc:in std_logic;
		serial_out:out std_logic
	);
end CRC_TX;

architecture RTL of CRC_TX is
	signal x:std_logic_vector(7 downto 0);
	signal x7,x6,x5,x4,x3,x2,x1,x0:std_logic;
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
end architecture;