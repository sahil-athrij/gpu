library ieee;
use ieee.std_logic_1164.all;

entity regbank is
    Port(
        CLK : IN STD_LOGIC;
        D   : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        INPUT_ENABLE : IN STD_LOGIC;
        INPUT_SELECT : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        OUTPUT_ENABLE : IN STD_LOGIC;
        OUTPUT_SELECT : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
end regbank;

architecture Behavioral of regbank is

    component DEMUX is
        port(
            I : IN STD_LOGIC;
            S : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Y : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    end component;

    component reg is
        port(
            CLK  : in  STD_LOGIC;
            IEN  : in  STD_LOGIC;
            INP  : in  STD_LOGIC_VECTOR (15 downto 0);
            OEN  : in  STD_LOGIC;
            OUTP : out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;

    signal INP_select : STD_LOGIC_VECTOR(15 DOWNTO 0); -- INPUT ENABLE DEMUX OP
    signal OUT_select : STD_LOGIC_VECTOR(15 DOWNTO 0); -- OUTPUT ENABLE DEMUX OP


    begin

        inpmux : DEMUX port map (I => INPUT_ENABLE, S => INPUT_SELECT, Y => INP_select);
        outmux : DEMUX port map (I => OUTPUT_ENABLE, S => OUTPUT_SELECT, Y => OUT_select);

        gen: for i in 0 to 15 generate
            UUT: reg port map (CLK => CLK, IEN => INP_select(i), OEN => OUT_select(i), OUTP => D,INP => D);
        end generate gen;
    end Behavioral;