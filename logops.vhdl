LIBRARY ieee;
USE ieee.std_logic_1164.ALL

ENTITY logops IS
PORT(
    en      : IN STD_LOGIC;
    x_in    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    y_in    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    o_op    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    mode    : IN STD_LOGIC_VECTOR( 2 DOWNTO 0);
);
END logops;

ARCHITECTURE behavioral OF logops is
    begin

        PROCESS ( en, mode)
        begin
            if ( en = '1') then

                   if ( mode = '000') then
                    o_op <= x_in AND y_in;
                elsif ( mode = '001') then
                    o_op <= x_in OR y_in;
                elsif ( mode = '010') then
                    o_op <= x_in NOT y_in;
                elsif ( mode = '011') then
                    o_op <= x_in XOR y_in;
                elsif ( mode = '100') then
                    o_op <= x_in NAND y_in;        
                elsif ( mode = '101') then
                    o_op <= x_in NOR y_in;
                elsif ( mode = '110') then
                    o_op <= x_in XNOR y_in;                    
                else
                    o_op <= (others => 'Z');    
            end if;

        END PROCESS;

END behavioral;                


