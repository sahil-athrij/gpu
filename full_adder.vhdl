
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is 
port (
    A       : IN STD_LOGIC;
    B       : IN STD_LOGIC;
    CIN     : IN STD_LOGIC;
    S       : OUT STD_LOGIC;
    COUT    : OUT STD_LOGIC;
);
end full_adder;

architecture behavioural of full_adder is

    S    <= A xor B xor CIN;
    COUT <= (A and B) or (CIN and A) or (CIN and B);
    
end behavioural;     