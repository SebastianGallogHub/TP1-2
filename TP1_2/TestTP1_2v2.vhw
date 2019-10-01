--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.2i
--  \   \         Application : ISE
--  /   /         Filename : TestTP1_2v2.vhw
-- /___/   /\     Timestamp : Tue Oct 01 16:28:55 2019
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: TestTP1_2v2
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY TestTP1_2v2 IS
END TestTP1_2v2;

ARCHITECTURE testbench_arch OF TestTP1_2v2 IS
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

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 100 ns;

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
                -- -------------  Current Time:  100ns
                WAIT FOR 100 ns;
                R <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  185ns
                WAIT FOR 85 ns;
                R <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  385ns
                WAIT FOR 200 ns;
                P1 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  585ns
                WAIT FOR 200 ns;
                P1 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  985ns
                WAIT FOR 400 ns;
                P1 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  1185ns
                WAIT FOR 200 ns;
                P1 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1585ns
                WAIT FOR 400 ns;
                P2 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  1785ns
                WAIT FOR 200 ns;
                P2 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1985ns
                WAIT FOR 200 ns;
                P2 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  2185ns
                WAIT FOR 200 ns;
                P1 <= '1';
                P2 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  2385ns
                WAIT FOR 200 ns;
                P1 <= '0';
                P2 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  2585ns
                WAIT FOR 200 ns;
                P2 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  3385ns
                WAIT FOR 800 ns;
                P2 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  3585ns
                WAIT FOR 200 ns;
                P2 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  4185ns
                WAIT FOR 600 ns;
                P1 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  6585ns
                WAIT FOR 2400 ns;
                P1 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  7185ns
                WAIT FOR 600 ns;
                P1 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  7385ns
                WAIT FOR 200 ns;
                P1 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  7585ns
                WAIT FOR 200 ns;
                P1 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  7785ns
                WAIT FOR 200 ns;
                P1 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  8785ns
                WAIT FOR 1000 ns;
                P2 <= '1';
                -- -------------------------------------
                WAIT FOR 1415 ns;

            END PROCESS;

    END testbench_arch;

