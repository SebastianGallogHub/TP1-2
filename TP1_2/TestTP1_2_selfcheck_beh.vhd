--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.2i
--  \   \         Application : ISE
--  /   /         Filename : TestTP1_2_selfcheck.vhw
-- /___/   /\     Timestamp : Sat Sep 28 17:02:46 2019
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: TestTP1_2_selfcheck_beh
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY TestTP1_2_selfcheck_beh IS
END TestTP1_2_selfcheck_beh;

ARCHITECTURE testbench_arch OF TestTP1_2_selfcheck_beh IS
    COMPONENT TP1_2
        PORT (
            L : Out std_logic;
            P1 : In std_logic;
            P2 : In std_logic;
            Clk : In std_logic;
            R : In std_logic
        );
    END COMPONENT;

    SIGNAL L : std_logic := 'U';
    SIGNAL P1 : std_logic := '0';
    SIGNAL P2 : std_logic := '0';
    SIGNAL Clk : std_logic := '0';
    SIGNAL R : std_logic := '0';

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    constant PERIOD : time := 250 ms;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 100 ms;

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
            PROCEDURE CHECK_L(
                next_L : std_logic;
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (L /= next_L) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ms L="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, L);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_L);
                    STD.TEXTIO.write(TX_LOC, string'(" "));
                    TX_STR(TX_LOC.all'range) := TX_LOC.all;
                    STD.TEXTIO.Deallocate(TX_LOC);
                    ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
                    TX_ERROR := TX_ERROR + 1;
                END IF;
            END;
            BEGIN
                -- -------------  Current Time:  210ms
                WAIT FOR 210 ms;
                P1 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  460ms
                WAIT FOR 250 ms;
                P1 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1460ms
                WAIT FOR 1000 ms;
                P1 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  1710ms
                WAIT FOR 250 ms;
                P1 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  2210ms
                WAIT FOR 500 ms;
                P1 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  2460ms
                WAIT FOR 250 ms;
                P1 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  3210ms
                WAIT FOR 750 ms;
                P1 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  3460ms
                WAIT FOR 250 ms;
                P1 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  5460ms
                WAIT FOR 2000 ms;
                P2 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  5710ms
                WAIT FOR 250 ms;
                P2 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  5960ms
                WAIT FOR 250 ms;
                P1 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  6210ms
                WAIT FOR 250 ms;
                P1 <= '0';
                P2 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  6460ms
                WAIT FOR 250 ms;
                P2 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  7210ms
                WAIT FOR 750 ms;
                P2 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  7460ms
                WAIT FOR 250 ms;
                P2 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  7960ms
                WAIT FOR 500 ms;
                R <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  7990ms
                WAIT FOR 30 ms;
                CHECK_L('0', 7990);
                -- -------------------------------------
                -- -------------  Current Time:  8210ms
                WAIT FOR 220 ms;
                R <= '0';
                -- -------------------------------------
                WAIT FOR 2040 ms;

                IF (TX_ERROR = 0) THEN
                    STD.TEXTIO.write(TX_OUT, string'("No errors or warnings"));
                    ASSERT (FALSE) REPORT
                      "Simulation successful (not a failure).  No problems detected."
                      SEVERITY FAILURE;
                ELSE
                    STD.TEXTIO.write(TX_OUT, TX_ERROR);
                    STD.TEXTIO.write(TX_OUT,
                        string'(" errors found in simulation"));
                    ASSERT (FALSE) REPORT "Errors found during simulation"
                         SEVERITY FAILURE;
                END IF;
            END PROCESS;

    END testbench_arch;

