library ieee;
use ieee.std_logic_1164.all;
 
entity pipo is
 port(
 clk : in std_logic;
 op : in std_logic;
 en : in std_logic;
 D: in std_logic_vector(7 downto 0);
 Q: out std_logic_vector(7 downto 0)
 );
end pipo;
 
architecture arch of pipo is
 
begin
 
 process (clk,en)
 signal temp   :  std_logic_vector(7 downto 0);
 begin
 if (CLK'event and CLK='1') then
    If (en ='1') then
        temp <= D;
    end if;

    If (op ='1') then
        Q <= temp;
    end if;
 end if;
 end process;
 
end arch;