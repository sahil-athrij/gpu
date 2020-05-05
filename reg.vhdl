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
           OUTP : out std_logic_vector (15 downto 0);

           mode : IN STD_LOGIC; -- shift rotate mode (1) or read/write mode (0)
           SH   : IN std_logic; -- arithmetic (0) or logical (1)
           );
end reg;

architecture Behavioral of reg is

begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if (mode = '0') then    -- read/write mode
                if (IEN = '0') then
                    temp <= INP;    
                end if;
                if (OEN = '0') and (IEN = '0') then
                    OUTP <= INP;
                elsif (OEN = '0') then
                    OUTP <= temp;
                else
                    OUTP <= (others => 'Z');
                end if; 
            end if;
            
            if (mode = '1') then    -- shift/rotate mode
                if (IEN = '0') then
                    if (SH = '0') and (OEN = '0') then
                        temp <= shift_right (signed(temp), 1); -- arithmetic right shift
                    end if;
                    if (SH = '0') and (OEN = '1') then
                        temp <= shift_left (signed(temp), 1); -- arithmetic left shift
                    end if;        
                    if (SH = '1') and (OEN = '0') then
                        temp <= shift_right (unsigned(temp), 1); -- logical right shift
                    end if;
                    if (SH = '1') and (OEN = '1') then
                        temp <= shift_left (unsigned(temp), 1); -- logical left shift
                    end if;
                end if;
                if (IEN = '1') then
                    if (OEN = '0') then
                        temp <= rotate_right (temp, 1);
                    end if;
                    if (OEN = '1') then
                        temp <= rotate_left (temp, 1);
                    end if;
                end if;
            end if;        
                  
        end if;
    end process;
end Behavioral;