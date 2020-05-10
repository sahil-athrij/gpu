library IEEE;
use IEEE.std_logic_1164.all;

entity t_c_l_addr is
end t_c_l_addr;

architecture t_behaviour of t_c_l_addr is
    component c_l_addr is
        port(
             x_in      :  IN   STD_LOGIC_VECTOR(15 DOWNTO 0);
             y_in      :  IN   STD_LOGIC_VECTOR(15 DOWNTO 0);
             carry_in  :  IN   STD_LOGIC;
             sum       :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
             carry_out :  OUT  STD_LOGIC;
             aos       :  IN   STD_LOGIC;
             en        :  IN   STD_LOGIC

        );
    end component c_l_addr;
    signal x_in_t      :    STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal y_in_t      :    STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal carry_in_t  :    STD_LOGIC;
    signal sum_t       :    STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal carry_out_t :    STD_LOGIC;
    signal aos_t       :    STD_LOGIC;
    signal en_t        :    STD_LOGIC;
    begin
        module_reg: c_l_addr
        port map(
            x_in => x_in_t,
            y_in  => y_in_t,
            carry_in  => carry_in_t,
            sum  => sum_t,
            carry_out  => carry_out_t,
            aos   => aos_t,
            en   => en_t
        );
        en_process : process
        begin
            en_t <='0';
            aos_t <='0';
            carry_in_t <='0';
            x_in_t <="1111000011110000";
            y_in_t <="0000111100001111";
            wait for 20 ms;
            en_t<='1';
            wait for 20 ms;
            en_t<='0';
            x_in_t <="0000000011100000";
            y_in_t <="0000000011110000";
            wait for 20 ms;
            aos_t <='1';
            wait for 20 ms;
            en_t <='1';
            wait for 20 ms;
            wait;
        end process;



end t_behaviour;

