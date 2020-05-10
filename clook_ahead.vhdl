LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY c_l_addr IS
    PORT
        (
         x_in      :  IN   STD_LOGIC_VECTOR(15 DOWNTO 0);
         y_in      :  IN   STD_LOGIC_VECTOR(15 DOWNTO 0);
         carry_in  :  IN   STD_LOGIC;
         sum       :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
         carry_out :  OUT  STD_LOGIC;
         aos       :  IN   STD_LOGIC;
         en        :  IN   STD_LOGIC
        );
END c_l_addr;

ARCHITECTURE behavioral OF c_l_addr IS

SIGNAL    h_sum              :    STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL    carry_generate     :    STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL    carry_propagate    :    STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL    not_yin           :    STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL    not_carry_in      :    STD_LOGIC;
SIGNAL    carry_in_internal  :    STD_LOGIC_VECTOR(15 DOWNTO 1);

BEGIN

    PROCESS (en, aos, carry_generate, carry_propagate, carry_in_internal)
    BEGIN
        h_sum <= x_in XOR y_in;
        carry_generate <= x_in AND y_in;
        carry_propagate <= x_in OR y_in;
        not_yin         <= NOT y_in;
         not_carry_in <=  carry_in ;

        if (en = '0') then
            if (aos = '1') then
                not_carry_in <= carry_in;
                h_sum <= x_in XOR not_yin;
                carry_generate <= x_in AND not_yin;
                carry_propagate <= x_in OR not_yin;
            end if;

            carry_in_internal(1) <= carry_generate(0) OR (carry_propagate(0) AND not_carry_in);
            inst: FOR i IN 1 TO 14 LOOP
                  carry_in_internal(i+1) <= carry_generate(i) OR (carry_propagate(i) AND carry_in_internal(i));
                  END LOOP;
            carry_out <= carry_generate(15) OR (carry_propagate(15) AND carry_in_internal(15));


        sum(0) <= h_sum(0) XOR not_carry_in;
        sum(15 DOWNTO 1) <= h_sum(15 DOWNTO 1) XOR carry_in_internal(15 DOWNTO 1);

        else
            sum<=(others=>'Z');
        end if;
    END PROCESS;
END behavioral;