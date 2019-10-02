----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:27:52 09/28/2019 
-- Design Name: 
-- Module Name:    TP1_2 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TP1_2 is
    Port ( L : out  STD_LOGIC;
           P1 : in  STD_LOGIC;
           P2 : in  STD_LOGIC;
			  Clk : in STD_LOGIC;
			  R : in STD_LOGIC);
end TP1_2;

architecture Behavioral of TP1_2 is
	Signal TR01 ,TR02 ,TR03 ,TR04 ,TR05 ,TR06 ,TR07 ,TR08 ,TR09 ,TR10 : STD_LOGIC;
	Signal TR11 ,TR12 ,TR13 ,TR14 ,TR15 ,TR16 ,TR17 ,TR18 ,TR19 ,TR20 : STD_LOGIC;
	
	Signal Q01 ,Q02 ,Q03 ,Q04 ,Q05 ,Q06 ,Q07 ,Q08 ,Q09 ,Q10 ,Q11 ,Q12 ,Q13 : STD_LOGIC;
	
	Signal CT2, FT2 : STD_LOGIC;	
	Signal cuenta : integer;
	
	begin
		TR01 <= Q01 and P1 and (not P2);
		TR02 <= Q02 and (not P1);
		TR03 <= Q04 and P1 and (not P2);
		TR04 <= Q06 and (not P1);
		TR05 <= Q08 and (P1 or P2);
		TR06 <= Q09 and (not P1) and (not P2); 
		TR07 <= Q06 and FT2;
		TR08 <= Q12 and (not P1);
		TR09 <= Q04 and FT2;
		TR10 <= Q02 and FT2;
		TR11 <= Q10 and (not P1);
		TR12 <= Q01 and P2 and (not P1);
		TR13 <= Q03 and (not P2);
		TR14 <= Q05 and P2 and (not P1);
		TR15 <= Q07 and (not P2);
		TR16 <= Q07 and FT2;
		TR17 <= Q13 and (not P2);
		TR18 <= Q05 and FT2;
		TR19 <= Q03 and FT2;
		TR20 <= Q11 and (not P2);

		process (R, Clk)
		begin
			if (R = '1') then 
				Q01 <= '1'; Q02 <= '0'; Q03 <= '0'; Q04 <= '0'; Q05 <= '0'; Q06 <= '0'; Q07 <= '0';
				Q08 <= '0'; Q09 <= '0'; Q10 <= '0'; Q11 <= '0'; Q12 <= '0'; Q13 <= '0';
			elsif (Clk = '1' and Clk'event) then 
				if TR01 = '1' then Q02 <= '1'; Q01 <= '0'; end if;
				if TR02 = '1' then Q04 <= '1'; Q02 <= '0'; end if;
				if TR03 = '1' then Q06 <= '1'; Q04 <= '0'; end if;
				if TR04 = '1' then Q08 <= '1'; Q06 <= '0'; end if;
				if TR05 = '1' then Q09 <= '1'; Q08 <= '0'; end if;
				if TR06 = '1' then Q01 <= '1'; Q09 <= '0'; end if;
				if TR07 = '1' then Q12 <= '1'; Q06 <= '0'; end if;
				if TR08 = '1' then Q01 <= '1'; Q12 <= '0'; end if;
				if TR09 = '1' then Q01 <= '1'; Q04 <= '0'; end if;
				if TR10 = '1' then Q10 <= '1'; Q02 <= '0'; end if;
				if TR11 = '1' then Q01 <= '1'; Q10 <= '0'; end if;
				if TR12 = '1' then Q03 <= '1'; Q01 <= '0'; end if; 
				if TR13 = '1' then Q05 <= '1'; Q03 <= '0'; end if;
				if TR14 = '1' then Q07 <= '1'; Q05 <= '0'; end if;
				if TR15 = '1' then Q08 <= '1'; Q07 <= '0'; end if;
				if TR16 = '1' then Q13 <= '1'; Q07 <= '0'; end if;
				if TR17 = '1' then Q01 <= '1'; Q13 <= '0'; end if;
				if TR18 = '1' then Q01 <= '1'; Q05 <= '0'; end if;
				if TR19 = '1' then Q11 <= '1'; Q03 <= '0'; end if;
				if TR20 = '1' then Q01 <= '1'; Q11 <= '0'; end if;
			end if;
		end process;
		
		L <= Q08;
		CT2 <= Q02 or Q03 or Q04 or Q05 or Q06 or Q07;
		
		process (R, Clk)
		begin
			if R = '1' then 
				FT2 <= '0';
			elsif (Clk'event and Clk = '1') then 
				if CT2 = '1' then 
					if cuenta < 2 then --Se consideran 2 bit-time, 1 seg
						cuenta <= cuenta +1; FT2 <= '0';
					else
						FT2 <= '1';
					end if;
				else 
					cuenta <= 0;
				end if;
			end if;
		end process;
		
end Behavioral;

