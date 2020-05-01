entity tri_state_buffer_top is
    Port (
           -- 16 input / output buffer
           CLK  : in  std_logic;
           IEN  : in  std_logic;
           INP  : in  std_logic_vector (15 downto 0);
           OEN  : in  STD_LOGIC;
           OUTP : out std_logic_vector (15 downto 0));
end tri_state_buffer_top;

architecture Behavioral of tri_state_buffer_top is

begin
    process(CLK,IEN,OEN)
    begin
        if (CLK'event and CLK = '1') then
            if (IEN = '0') then
                    -- 16 input/output active low enabled tri-state buffer
                OUTP <= INP when (OEN = '0') else "ZZZZ";
            end if;
        end if;
    end process;                
 


end Behavioral;