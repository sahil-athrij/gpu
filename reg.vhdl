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
           SOR  : IN STD_LOGIC; --shift (0) or rotate (1)
           mode : IN STD_LOGIC; -- shift rotate mode (1) or read/write mode (0)
           RO   : IN STD_LOGIC; -- rotate right(0) left(1)
           SH   : IN std_logic_vector(1 downto 0);
           -- 00 arith right shift
           -- 01 arith left shift
           -- 10 logical right shift
           -- 11 logical left shift
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
                if (SOR = '0') then
                    if (SH = '00') then
                        temp <= shift_right (signed(temp), 1); -- arithmetic right shift
                    end if;
                    if (SH = '01') then
                        temp <= shift_left (signed(temp), 1); -- arithmetic left shift
                    end if;        
                    if (SH = '10') then
                        temp <= shift_right (unsigned(temp), 1); -- logical right shift
                    end if;
                    if (SH = '11') then
                        temp <= shift_left (unsigned(temp), 1); -- logical left shift
                    end if;  
                elsif (SOR = '1') then
                    if (RO = '0') then
                        temp <= rotate_right (temp, 1);
                    end if;
                    if (RO = '1') then
                        temp <= rotate_left (temp, 1);    
            end if;        
                  
        end if;
    end process;
end Behavioral;