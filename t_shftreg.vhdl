library IEEE;
use IEEE.std_logic_1164.all;

entity t_pipo is
end t_pipo;

architecture t_behaviour of t_pipo is
    component pipo is 
        port(
            clk : in std_logic;
            en : in std_logic;
            D: in std_logic_vector(7 downto 0);
            Q: out std_logic_vector(7 downto 0)
            
        );
    end component pipo;

    signal clk_t :  std_logic;
    signal en_t  :  std_logic;
    signal D_t   :  std_logic_vector(7 downto 0);
    signal Q_t   :  std_logic_vector(7 downto 0);

    begin
        module_pipo: pipo
        port map(
            clk => clk_t,
            en  => en_t,
            D   => D_t,
            Q   => Q_t
        );
       clk_process : process
        begin
            clk_t <= '0';
            wait for 100 ms;
            clk_t <= '1';
            wait for 100 ms;
        end process;


        en_process : process
        begin
            en_t <= '1';
            wait for 10 ms;
            en_t <= '0';
            wait for 10 ms;
        end process;

        test_process : process
        begin
            D_t <= "00001000";
            wait for 20 ms;
            D_t <= "00001010";
            wait for 20 ms;
        end process;



end t_behaviour;

