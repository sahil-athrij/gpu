library ieee;
use ieee.std_logic_1164.all;

entity t_DEMUX is
end t_DEMUX;

architecture t_behaviour of t_DEMUX is
    component DEMUX is
        port(
            I : IN STD_LOGIC;
            S : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Y : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '1')
        );
    end component DEMUX;
    
    signal I_t : STD_LOGIC;
    signal S_t : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal Y_t : STD_LOGIC_VECTOR(15 DOWNTO 0);

    begin
        module_DEMUX : DEMUX
        port map(
            I => I_t,
            S => S_t,
            Y => Y_t
        );
        a_process : process
        begin
            I_t <= '0';
            S_t <= "0000";
            wait for 10 ms;

            I_t <= '0';
            S_t <= "0010";
            wait for 10 ms;

            I_t <= '0';
            S_t <= "0100";
            wait for 10 ms;

            I_t <= '0';
            S_t <= "1111";
            wait for 10 ms;
            wait;
        end process;
        end t_behaviour;             
