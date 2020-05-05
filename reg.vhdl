library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg is
    Port (
           -- 16 input / output buffer
           CLK  : in  std_logic;
           IEN  : in  std_logic; -- input enable; shift (0) rotate (1)
           INP  : in  std_logic_vector (15 downto 0);
           OEN  : in  STD_LOGIC; -- output enable; right(0) left (1)
           OUTP : out std_logic_vector (15 downto 0)
           );
end reg;

architecture Behavioral of reg is
signal temp : std_logic_vector(15 downto 0);
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if (IEN = '0') then
                temp <= INP;
            end if;
            if (OEN = '0') then
                OUTP <= temp;
            else
                OUTP <= (others => 'Z');
            end if;
        end if;
    end process;
end Behavioral;