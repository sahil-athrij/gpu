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

        MODE : IN STD_LOGIC;
        SH : IN STD_LOGIC;

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
           CLK  : in  std_logic;
           IEN  : in  std_logic;                        -- input enable; shift (0) rotate (1)
           INP  : in  std_logic_vector (15 downto 0);
           OEN  : in  STD_LOGIC;                        -- output enable; right(0) left (1)
           OUTP : out std_logic_vector (15 downto 0);
           mode : IN STD_LOGIC;                         -- shift rotate mode (1) or read/write mode (0)
           SH   : IN std_logic;                         -- arithmetic (0) or logical (1)
        );
    end component;


    signal INP_select : STD_LOGIC_VECTOR(15 DOWNTO 0);  -- INPUT ENABLE DEMUX OP
    signal OUT_select : STD_LOGIC_VECTOR(15 DOWNTO 0);  -- OUTPUT ENABLE DEMUX OP


    begin

        inpmux : DEMUX port map (I => '0', S => INPUT_SELECT, Y => INP_select);
        outmux : DEMUX port map (I => '0', S => OUTPUT_SELECT, Y => OUT_select);

        gen: for i in 0 to 15 generate
            UUT: reg port map (CLK => CLK,
            IEN => INP_select(i) or INPUT_ENABLE ,
            OEN => OUT_select(i) or OUTPUT_ENABLE,
             OUTP => D,
             INP => D,
             mode => MODE or INPUT_ENABLE,
             sh => SH or INPUT_ENABLE ,  );
        end generate gen;
    end Behavioral;