library ieee; 
  use ieee.std_logic_1164.all; 
  use ieee.math_real.all; 
  use ieee.numeric_std.all; 
  -- Include here your own packages if needed! 
  
 -- simulate for 13 us 
 -- unsigned type assumed for signal "count" 
  
 entity crc_tx_tb is 
  generic (period: time := 20 ns); 
  -- Period is used for clock generation. 
 end entity crc_tx_tb; 
  
 architecture functionality of crc_tx_tb is 
 signal clk, init, serial_in, en_crc : std_logic;
 signal serial_out: std_logic;

 begin
 initial: process
 begin
 init <= '0';
 wait for 10 ns;
 init <= '1'; 
 wait; 
 end process;  
   
   manage_serial_in: process is 
   begin
   serial_in <= '0';
   wait for 10 ns;
   serial_in <= '1'; 
   wait for period; 
   serial_in <= '0'; 
   wait for period; 
   serial_in <= '1'; 
   wait for period; 
   serial_in <= '1'; 
   wait for period; 
   serial_in <= '0'; 
   wait for period; 
   serial_in <= '1'; 
   wait for period; 
   serial_in <= '1'; 
   wait for period; 
   serial_in <= '0'; 
   wait for period; 
   serial_in <= '0'; 
   wait for period; 
   serial_in <= '1'; 
   wait for period; 
   serial_in <= '1'; 
   wait for period; 
   serial_in <= '0'; 
   wait for period; 
   serial_in <= '1'; 
   wait for period; 
   serial_in <= '1'; 
   wait for period; 
   serial_in <= '0';
   wait for period; 
   serial_in <= '0';
   wait for period; 
   serial_in <= '0';
   wait for period; 
   serial_in <= '0';
   wait for period; 
   serial_in <= '0';
   wait for period; 
   serial_in <= '0';
   wait for period; 
   serial_in <= '0';
   wait for period; 
   serial_in <= '0';  
   wait; 
   end process; 
  
  manage_en_crc: process is 
   begin 
   en_crc <= '0'; 
   wait for 10 ns; 
   en_crc <= '1'; 
   wait for 14*period;
   en_crc <= '0';
   wait for 8*period;
   en_crc <= '1';
   wait; 
  end process; 

  DUT00: entity work.CRC_TX(RTL) 
   port map(clk, init, serial_in, en_crc, serial_out); 
   -- mapping based on order of signals 
   
 -- alternative instantiation, more detailed. At left component port signal, at right this level signal. 
 -- DUT01: entity work.dt2_12_assign1(rtl) 
 -- port map( 
 -- clk => clk, 
 -- reset => reset, 
 -- clear => clear, 
 -- run_en => run_en, 
 -- data_in => data_in, 
 -- count => count, 
 -- edge => edge, 
 -- serial_out => serial_out); 
  
  clock: process 
   begin 
   clk <= '0'; 
   wait for period/2; 
   clk <= '1'; 
   wait for period/2; 
  end process; 
  
 end architecture functionality; 