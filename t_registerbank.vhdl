library IEEE;
use IEEE.std_logic_1164.all;

entity t_regbank is
end t_regbank;

architecture t_behaviour of t_regbank is
    component regbank is
        port(
            CLK : IN STD_LOGIC;
            D   : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            INPUT_ENABLE : IN STD_LOGIC;
            INPUT_SELECT : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            OUTPUT_ENABLE : IN STD_LOGIC;
            OUTPUT_SELECT : IN STD_LOGIC_VECTOR(3 DOWNTO 0)

        );
    end component regbank;

    signal clk_t  :  std_logic;
    signal D_t    :  std_logic_vector(15 downto 0);
    signal inp_t  :  std_logic;
    signal out_t  :  std_logic;
    signal inps_t :  std_logic_vector(3 downto 0);
    signal outs_t :  std_logic_vector(3 downto 0);

    begin
        module_regbank: regbank
        port map(
            CLK => clk_t,
            D   => D_t,
            INPUT_ENABLE   => inp_t,
            OUTPUT_ENABLE   => out_t,
            INPUT_SELECT   => inps_t,
            OUTPUT_SELECT   => outs_t
        );
       clk_process : process
        begin
            clk_t <= '0';
            wait for 10 ms;
            clk_t <= '1';
            wait for 10 ms;
            if NOW > 1000 ms then
                wait;
            end if;
        end process;


        en_process : process
        begin
            D_t<= (others => 'Z');
            inps_t <= "0000";
            inp_t <='0';
            outs_t <= "0000";
            out_t <='1';

            D_t<= "1010111101010000";
            wait for 60 ms;

            inps_t <= "0001";
            inp_t <='0';
            D_t<= "0000111111110000";
            wait for 60 ms;
            inp_t <='1';
            D_t<= (others => 'Z');



            out_t <='0';
            wait for 60 ms;

            outs_t <= "0001";
            wait for 60 ms;

            out_t <='1';
            wait for 60 ms;
            wait;
        end process;
end t_behaviour;
