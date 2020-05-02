library ieee;
use ieee.std_logic_1164.all;

entity DEMUX is
    port(
            I : IN STD_LOGIC;
            S : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Y : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '1')
        );
end DEMUX;

architecture Behavioral of DEMUX is
    begin
        process(I,S)
        begin
            Y<= (others => '1');
            if (S = "0000") then
                Y(0) <= I;
            elsif (S = "0001") then
                Y(1) <= I;
            elsif (s = "0010") then
                Y(2) <= I;
            elsif (S = "0011") then
                Y(3) <= I;
            elsif (S = "0100") then
                Y(4) <= I;
            elsif (S = "0101") then
                Y(5) <= I;
            elsif (S = "0110") then
                Y(6) <= I;
            elsif (S = "0111") then
                Y(7) <= I;
            elsif (S = "1000") then
                Y(8) <= I;
            elsif (S = "1001") then
                Y(9) <= I;
            elsif (S = "1010") then
                Y(10) <= I;
            elsif (S = "1011") then
                Y(11) <= I;
            elsif (S = "1100") then
                Y(12) <= I;
            elsif (S = "1101") then
                Y(13) <= I;
            elsif (S = "1110") then
                Y(14) <= I;
            elsif (S = "1111") then
                Y(15) <= I;
            end if;
        end process;
    end Behavioral;

