library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity t_mult is
end t_mult;

architecture t_rtl of t_mult is
    component mult is
        port (
            a,b : in  signed(15 downto 0);
            c   : out signed(31 downto 0)
        );
    end component mult;
    
    signal a_t : signed(15 downto 0);
    signal b_t : signed(15 downto 0);
    signal c_t : signed(31 downto 0);

    begin
        module_mult: MULT
        port map (
            a => a_t,
            b => b_t,
            c => c_t
        );

        test_process : process
        begin
            a_t <= "1111000011110000";
            b_t <= "0000111100001111";
            wait for 20 ms;

            a_t <= "0000000011100000";
            b_t <= "0000000011110000";
            wait for 20 ms;

            wait;
        end process;   

end t_rtl;    