library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CRC_TX is
	port(
		sys_clk, reset, sel_crc, en_bitrate, path_IN:in std_logic;
		path_OUT: OUT std_logic
	);
end entity;

architecture rtl of CRC_TX is
signal Q, QIN: std_logic_vector(7 downto 0);
begin
  REG8: process(sys_clk, reset, en_bitrate, QIN, Q)
  begin
      if reset = '1' then Q <= "00000000";
      elsif rising_edge(sys_clk) 
          then if(en_bitrate = '1')
            then Q <= QIN;
          else Q <= Q;
          end if;
      end if;
  end process REG8;

  Polynom: process(Q, sel_crc, path_IN)
  begin
    case sel_crc is
     when '0' => QIN(0) <= '0'; 
      when '1' => QIN(0) <= Q(7) xor path_IN;
      when others => QIN(0)<='0';
    end case;
  end process;

  QIN(1) <= Q(0);
  QIN(2) <= Q(0)xor Q(1);
  QIN(3) <= Q(0)xor Q(2);
  QIN(4) <= Q(0)xor Q(3);
  QIN(5) <= Q(4);
  QIN(6) <= Q(5);
  QIN(7) <= Q(6);

  MUX: process(Q, sel_crc, path_IN)
  begin
    case sel_crc is
      when '0' => path_OUT <= Q(7); 
      when '1' => path_OUT <= path_IN;
      when others => path_OUT <='0';
    end case;
  end process;
end architecture rtl;