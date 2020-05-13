library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mult is

    port (
        a,b : in  std_logic_vector(15 downto 0);
        c   : out std_logic_vector(31 downto 0);
        s   : in  std_logic_vector( 1 downto 0);

    );

end mult;

architecture rtl of mult is

begin
PROCESS ( a,b,s)
            begin
        if (s = '00') then
            c <= std_logic_vector(unsigned(a) * unsigned(b));
        elsif (s = '01') then
            c <= std_logic_vector(signed(a) * signed(b));
        elsif (s = '10') then
            c <= std_logic_vector(unsigned(a) / unsigned(b));
        elsif (s = '11') then
            c <= std_logic_vector(signed(a) / signed(b));        
        else
            c <= (others => 'Z');
        end if;
        end process;
    
end architecture rtl;