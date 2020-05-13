library IEEE;
use IEEE.std_logic_1164.all;

entity t_logops is
end t_logops;

architecture t_behaviour of t_logops is
    component logops is
        port(
            en      : IN STD_LOGIC;
            x_in    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            y_in    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            o_op    : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            mode    : IN STD_LOGIC_VECTOR( 2 DOWNTO 0)

        );
    end component logops;
    signal x_in_t      :    STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal y_in_t      :    STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal sum_t       :    STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal mode_t      :    STD_LOGIC_VECTOR( 2 DOWNTO 0);
    signal en_t        :    STD_LOGIC;
    begin
        module_reg: logops
        port map(
            x_in => x_in_t,
            y_in  => y_in_t,

            o_op  => sum_t,
            mode   => mode_t,
            en   => en_t
        );
        en_process : process
        begin
            en_t <='0';
            x_in_t <="1111000011110000";
            y_in_t <="0000111100001111";


            wait for 20 ms;
            mode_t <= "000";
            wait for 20 ms;
            mode_t <= "001";
            wait for 20 ms;
            mode_t <= "010";
            wait for 20 ms;
            mode_t <= "011";
            wait for 20 ms;
            mode_t <= "100";
            wait for 20 ms;
            mode_t <= "101";
            wait for 20 ms;
            mode_t <= "110";
            wait for 20 ms;


            x_in_t <="0000000011100000";
            y_in_t <="0000000011110000";

            wait for 20 ms;
            mode_t <= "000";
            wait for 20 ms;
            mode_t <= "001";
            wait for 20 ms;
            mode_t <= "010";
            wait for 20 ms;
            mode_t <= "011";
            wait for 20 ms;
            mode_t <= "100";
            wait for 20 ms;
            mode_t <= "101";
            wait for 20 ms;
            mode_t <= "110";
            wait for 20 ms;


            wait;
        end process;



end t_behaviour;

