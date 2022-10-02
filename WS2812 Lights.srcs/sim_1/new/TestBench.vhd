library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TestBench is
    port (
        MyLutGPIO       :  in std_logic_vector(31 downto 0) := (others => '0');
        MyCntGPIO       :  in std_logic_vector(31 downto 0) := (others => '1'));
end TestBench;

architecture Behavioral of TestBench is
    component WS2812 is
        Port (
            Clk_In      :  in std_logic := '0';
            Go_In       :  in std_logic := '1';
            Color_In    :  in std_logic_vector(23 downto 0) := x"BEDEAD";
            Data_Out    : out std_logic := '0';
            Next_Out    : out std_logic := '0');
    end component;
 
    component ColorLUT is
        Port (
            Clk_In      : in  std_logic := '0';
            GPIO_In     : in  std_logic_vector (31 downto 0) := (others => '0');
            Next_In     : in  std_logic := '0';
            Next_Out    : out std_logic := '0';
            Color_Out   : out std_logic_vector (23 downto 0));
    end component;

    signal MyClock      : std_logic := '0';
    signal ColorCnt     : integer range 0 to 7 := 0;
    signal MyColor      : std_logic_vector(23 downto 0) := (others => '0');
    signal MyReset      : std_logic := '0';
    signal MyData       : std_logic := '0';
    signal MyNext       : std_logic := '0';
    signal MyGo         : std_logic := '0';

    begin

    MyClock <= not MyClock after 5ns;

    WS2812_0    : WS2812 port map(
        Clk_In      => MyClock,
        Go_In       => MyGo,
        Color_In    => MyColor,
        Data_Out    => MyData,
        Next_Out    => MyNext);

    LUT_0       : ColorLUT port map(
        Clk_In      => MyClock,
        GPIO_In     => MyLutGPIO,
        Next_In     => MyNext,
        Next_Out    => MyGo,
        Color_Out   => MyColor);

end Behavioral;
