LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY multi is
    PORT(
        A   : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
        B   : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
        S   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);

    );
END multi;

ARCHITECTURE rtl of multi is
    component enabler is
        PORT(
            X   : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
            Y   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            E   : IN  STD_LOGIC
        );
    end component;
    
    component c_l_addr32 IS
    PORT
        (
         x_in      :  IN   STD_LOGIC_VECTOR(31 DOWNTO 0);
         y_in      :  IN   STD_LOGIC_VECTOR(31 DOWNTO 0);
         carry_in  :  IN   STD_LOGIC;
         sum       :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
         carry_out :  OUT  STD_LOGIC;
         aos       :  IN   STD_LOGIC;
         en        :  IN   STD_LOGIC
        );
    end component;   




    signal C : STD_LOGIC_VECTOR (15 DOWNTO 0);
    signal sig1 : STD_LOGIC_VECTOR (15 DOWNTO 0);

    begin
        enabler  port map (X <= A, Y <= sig1, E <= B(0));
        c_l_addr port map (x_in <= sig1, y_in <= shift_right(sig1, 1), carry_in <= '0',  ) 
