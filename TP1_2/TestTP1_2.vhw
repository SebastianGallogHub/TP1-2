--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.2i
--  \   \         Application : ISE
--  /   /         Filename : TestTP1_2.vhw
-- /___/   /\     Timestamp : Wed Oct 02 17:30:18 2019
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: TestTP1_2
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY TestTP1_2 IS
END TestTP1_2;

ARCHITECTURE testbench_arch OF TestTP1_2 IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT TP1_2
        PORT (
            L : Out std_logic;
            P1 : In std_logic;
            P2 : In std_logic;
            Clk : In std_logic;
            R : In std_logic
        );
    END COMPONENT;

    SIGNAL L : std_logic := '0';
    SIGNAL P1 : std_logic := '0';
    SIGNAL P2 : std_logic := '0';
    SIGNAL Clk : std_logic := '0';
    SIGNAL R : std_logic := '0';

    constant PERIOD : time := 250 ms;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 1 ms;

    BEGIN
        UUT : TP1_2
        PORT MAP (
            L => L,
            P1 => P1,
            P2 => P2,
            Clk => Clk,
            R => R
        );

        PROCESS    -- clock process for Clk
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                Clk <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                Clk <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS
            BEGIN
                -- -------------  Current Time:  1ms
                WAIT FOR 1 ms;
                R <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  125ms
                WAIT FOR 124 ms;
                R <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  375ms
                WAIT FOR 250 ms;
                P1 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  625ms
                WAIT FOR 250 ms;
                P1 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  875ms
                WAIT FOR 250 ms;
                P2 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  1125ms
                WAIT FOR 250 ms;
                P2 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1375ms
                WAIT FOR 250 ms;
                P1 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  1625ms
                WAIT FOR 250 ms;
                P1 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  2375ms
                WAIT FOR 750 ms;
                P2 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  2875ms
                WAIT FOR 500 ms;
                P2 <= '0';
                -- -------------------------------------
                WAIT FOR 2375 ms;

            END PROCESS;

    END testbench_arch;

