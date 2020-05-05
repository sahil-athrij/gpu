library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder is 
port (
    A       : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    B       : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    CIN     : IN STD_LOGIC;
    S       : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
    COUT    : OUT STD_LOGIC;
);
end adder;

architecture behavioural of adder is

    component full_adder is
        port(
            A       : IN STD_LOGIC;
            B       : IN STD_LOGIC;
            CIN     : IN STD_LOGIC;
            S       : OUT STD_LOGIC;
            COUT    : OUT STD_LOGIC;
        );
    end component;
    
    signal C : STD_LOGIC_VECTOR (15 DOWNTO 0);
  

    begin
        gen : for i in 0 to 15 generate
            UUT : full_adder port map (A => A(i), B => B(i), CIN => C(i), S => S(i), COUT => C(i+1));
        end generate;
        
        C(0)  <= CIN;
        C(15) <= COUT;
        
    end behavioural;    

       

        
