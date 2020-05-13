library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mult is

    port (
        a,b : in  signed(15 downto 0);
        c   : out signed(31 downto 0)
    );

end mult;

architecture rtl of mult is
begin
  
    c <= a * b;
  
end architecture rtl;