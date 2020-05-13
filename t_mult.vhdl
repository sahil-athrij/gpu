library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity t_mult is
end t_mult;

architecture t_rtl of t_mult is
    component mult is
        port (
            a,b : in  std_logic_vector(15 downto 0);
            c   : out std_logic_vector(31 downto 0);
            s   : in std_logic
    
        );
        
    end component mult;
    
    signal a_t : std_logic_vector(15 downto 0);
    signal b_t : std_logic_vector(15 downto 0);
    signal c_t : std_logic_vector(31 downto 0);
    signal s_t : std_logic;

    begin
        module_mult: MULT
        port map (
            a => a_t,
            b => b_t,
            c => c_t,
            s => s_t
        );

        test_process : process
        begin
            a_t <= "1111000011110000";
            b_t <= "0000111100001111";
            s_t <= '0';
            wait for 20 ms;

            a_t <= "0000000011100000";
            b_t <= "0000000011110000";
            s_t <= '0';
            wait for 20 ms;

            a_t <= "1111000011110000";
            b_t <= "0000111100001111";
            s_t <= '1';
            wait for 20 ms;


            a_t <= "0000000011100000";
            b_t <= "0000000011110000";
            s_t <= '1';
            wait for 20 ms;

            wait;
        end process;   

end t_rtl;    