library IEEE;
use IEEE.std_logic_1164.all;

entity t_tri_state_buffer_top is
end t_tri_state_buffer_top;

architecture t_behaviour of t_tri_state_buffer_top is
    component reg is
        port(
           CLK  : in  std_logic;
           IEN  : in  std_logic; -- input enable; shift (0) rotate (1)
           INP  : in  std_logic_vector (15 downto 0);
           OEN  : in  STD_LOGIC; -- output enable; right(0) left (1)
           OUTP : out std_logic_vector (15 downto 0);
           mode : IN STD_LOGIC; -- shift rotate mode (1) or read/write mode (0)
           SH   : IN std_logic; -- arithmetic (0) or logical (1)

        );
    end component reg;

    signal clk_t :  std_logic;
    signal mode  :  std_logic;
    signal sh  :  std_logic;
    signal ien_t  :  std_logic;
    signal oen_t  :  std_logic;
    signal D_t   :  std_logic_vector(15 downto 0);
    signal Q_t   :  std_logic_vector(15 downto 0);

    begin
        module_reg: reg
        port map(
            CLK => clk_t,
            IEN  => ien_t,
            OEN  => oen_t,
            INP   => D_t,
            OUTP   => Q_t
        );
       clk_process : process
        begin
            clk_t <= '0';
            wait for 10 ms;
            clk_t <= '1';
            wait for 10 ms;
            if NOW > 500 ms then
                wait;
            end if;
        end process;


        en_process : process
        begin
            ien_t <= '1';
            wait for 20 ms;
            ien_t <= '0';
            wait for 20 ms;
            if NOW > 500 ms then
                wait;
            end if;
        end process;


        op_process : process
        begin
            oen_t <= '1';
            wait for 40 ms;
            oen_t <= '0';
            wait for 40 ms;
            if NOW > 500 ms then
                wait;
            end if;
        end process;

        test_process : process
        begin
            D_t <= "1111000011110000";
            wait for 80 ms;
            D_t <= "0000111100001111";
            wait for 80 ms;
            if NOW > 500 ms then
                wait;
            end if;
        end process;



end t_behaviour;

