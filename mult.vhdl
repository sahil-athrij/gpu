library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mult is

    port (
        a,b : in  std_logic_vector(15 downto 0);
        c   : out std_logic_vector(31 downto 0);
        s   : in std_logic

    );

end mult;

architecture rtl of mult is
    signal tempu : unsigned(31 downto 0);
    signal temps :   signed(31 downto 0);
begin
PROCESS ( a, b,s)
            begin
        if (s = '0') then

            tempu <= unsigned(a) * unsigned(b);
            c <= std_logic_vector(tempu);
        elsif (s = '1') then
            temps <= signed(a) * signed(b);
            c <= std_logic_vector(temps);
        else
            c <= (others => 'Z');
        end if;
        end process;
    
end architecture rtl;