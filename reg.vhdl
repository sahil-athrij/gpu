library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg is
    Port (
           -- 16 input / output buffer with one enable
           CLK  : in  std_logic;
           IEN  : in  std_logic;
           INP  : in  std_logic_vector (15 downto 0);
           OEN  : in  STD_LOGIC;
           OUTP : out std_logic_vector (15 downto 0);
           SHL  : IN std_logic; --shift left
           SHR  : IN STD_LOGIC; -- shift right
           SOR  : IN STD_LOGIC; --shift (0) or rotate (1)
           AOL  : IN STD_LOGIC; --arithmetic (0) or logical shift (1)
           mode : IN STD_LOGIC; -- shift rotate mode (1) or read/write mode (0)
           RR   : IN STD_LOGIC; -- rotate right
           RL   : IN STD_LOGIC; --rotate left
           );
end reg;

architecture Behavioral of reg is
    signal temp : std_logic_vector (15 downto 0);
    signal rs_shift : signed (15 downto 0);
    signal ls_shift : signed (15 downto 0);
    signal ru_shift : unsigned (15 downto 0);
    signal lu_shift : unsigned (15 downto 0);
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
                if (SOR = '0') and (AOL = '0') then
                    if (SHR = '0') then
                        temp <= shift_right (signed(temp), 1); -- arithmetic right shift
                    end if;
                    if (SHL = '0') then
                        temp <= shift_left (signed(temp), 1); -- arithmetic left shift
                    end if;        
                elsif (SOR = '0') and (AOL = '1') then
                    if (SHR = '0') then
                        temp <= shift_right (unsigned(temp), 1); -- logical right shift
                    end if;
                    if (SHL = '0') then
                        temp <= shift_left (unsigned(temp), 1); -- logical left shift
                    end if;  
                elsif (SOR = '1') then
                    if (RR = '0') then
                        temp <= rotate_right (temp, 1);
                    end if;
                    if (RL = '0') then
                        temp <= rotate_left (temp, 1);    
            end if;        
                  
        end if;
    end process;
end Behavioral;