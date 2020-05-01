library ieee;
use ieee.std_logic_1164.all;

entity tri_state_buffer_top is
    Port (
           -- 16 input / output buffer with one enable
           CLK  : in  std_logic;
           IEN  : in  std_logic;
           INP  : in  std_logic_vector (15 downto 0);
           OEN  : in  STD_LOGIC;
           OUTP : out std_logic_vector (15 downto 0));
end tri_state_buffer_top;

architecture Behavioral of tri_state_buffer_top is

    signal temp : std_logic_vector (15 downto 0);
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if (IEN = '0') then
                temp <= INP; -- this is a register
            end if;
            if (OEN = '0') and (IEN = '0') then
                OUTP <= INP;
            else if (OEN = '0') then
                OUTP <= temp;
            else
                OUTP <= (others => 'Z');
            end if;
    end process;              
 


end Behavioral;