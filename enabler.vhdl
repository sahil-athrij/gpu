LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY enabler is
    PORT(
        X   : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
        Y   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        E   : IN  STD_LOGIC
    );
END enabler;

ARCHITECTURE behavioural of enabler is
    begin
        process(X,E)
            begin
                if (E = '1') then
                    Y <= X;
                end if;
                if (E <= '0') then
                    Y <= "0000000000000000";     
        end process;
    end behavioural;                    




