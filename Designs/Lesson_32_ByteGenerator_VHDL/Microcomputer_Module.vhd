------------------------------------------------------------
-- Deeds (Digital Electronics Education and Design Suite)
-- VHDL Code generated on (30/12/2020, 16:42:28)
--      by Deeds (Digital Circuit Simulator)(Deeds-DcS)
--      Ver. 2.30.041 (March 3, 2020)
-- Copyright (c) 2002-2020 University of Genoa, Italy
--      Web Site:  https://www.digitalelectronicsdeeds.com
------------------------------------------------------------

--------------------------------------------------------------------
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Microcomputer_Module IS
	PORT(
		CK    : IN std_logic;	-- Actually not "On Board"!
   	nRESET: IN std_logic;		
		--
		nINT  : IN std_logic;	-- In the "old" version, one only interrupt line
		--
		CKOUT : OUT std_logic;
		nRSOUT: OUT std_logic;
		nINTA : OUT std_logic;
		nSYNC : OUT std_logic;	-- PIN 7
		--
		nRA   : OUT std_logic;
		IA0   : IN std_logic;
		IA1   : IN std_logic;
		IA2   : IN std_logic;
		IA3   : IN std_logic;
		IA4   : IN std_logic;
		IA5   : IN std_logic;
		IA6   : IN std_logic;
		IA7   : IN std_logic;	-- PIN 16
		--
		nRB   : OUT std_logic;
		IB0   : IN std_logic;
		IB1   : IN std_logic;
		IB2   : IN std_logic;
		IB3   : IN std_logic;
		IB4   : IN std_logic;
		IB5   : IN std_logic;
		IB6   : IN std_logic;
		IB7   : IN std_logic;	-- PIN 25
		--
		nRC   : OUT std_logic;
		IC0   : IN std_logic;
		IC1   : IN std_logic;
		IC2   : IN std_logic;
		IC3   : IN std_logic;
		IC4   : IN std_logic;
		IC5   : IN std_logic;
		IC6   : IN std_logic;
		IC7   : IN std_logic;	-- PIN 34
		--
		nRD   : OUT std_logic;
		ID0   : IN std_logic;
		ID1   : IN std_logic;
		ID2   : IN std_logic;
		ID3   : IN std_logic;
		ID4   : IN std_logic;
		ID5   : IN std_logic;
		ID6   : IN std_logic;
		ID7   : IN std_logic;	-- PIN 43
		--
		nWA   : OUT std_logic;
		OA0   : OUT std_logic;
		OA1   : OUT std_logic;
		OA2   : OUT std_logic;
		OA3   : OUT std_logic;
		OA4   : OUT std_logic;
		OA5   : OUT std_logic;
		OA6   : OUT std_logic;
		OA7   : OUT std_logic;	-- PIN 52
		--
		nWB   : OUT std_logic;
		OB0   : OUT std_logic;
		OB1   : OUT std_logic;
		OB2   : OUT std_logic;
		OB3   : OUT std_logic;
		OB4   : OUT std_logic;
		OB5   : OUT std_logic;
		OB6   : OUT std_logic;
		OB7   : OUT std_logic;	-- PIN 61
		--
		nWC   : OUT std_logic;
		OC0   : OUT std_logic;
		OC1   : OUT std_logic;
		OC2   : OUT std_logic;
		OC3   : OUT std_logic;
		OC4   : OUT std_logic;
		OC5   : OUT std_logic;
		OC6   : OUT std_logic;
		OC7   : OUT std_logic;	-- PIN 70
		--
		nWD   : OUT std_logic;
		OD0   : OUT std_logic;
		OD1   : OUT std_logic;
		OD2   : OUT std_logic;
		OD3   : OUT std_logic;
		OD4   : OUT std_logic;
		OD5   : OUT std_logic;
		OD6   : OUT std_logic;
		OD7   : OUT std_logic;  -- PIN 79
      --
		NRES  : OUT std_logic;	-- Reset debug output
		STEP  : OUT std_logic;	-- Step by Step output
		S0		: IN	std_logic;	-- CPU register selection (5 bits + nibble)
		S1		: IN	std_logic;
		S2		: IN	std_logic;
		S3		: IN	std_logic;
		S4		: IN	std_logic;
		Ni		: IN	std_logic;
		R0		: OUT std_logic;
		R1		: OUT std_logic;
		R2		: OUT std_logic;
		R3		: OUT std_logic	-- PIN 91
		);
	END Microcomputer_Module;


----------------------------------------------------------------------------------------
ARCHITECTURE structural OF Microcomputer_Module IS


	-- Addresses of the IN/OUT ports, user defined: -------------------------------------
	constant Adr_IA: std_logic_vector(7 downto 0) := "00000000";
	constant Adr_IB: std_logic_vector(7 downto 0) := "00000001";
	constant Adr_IC: std_logic_vector(7 downto 0) := "00000010";
	constant Adr_ID: std_logic_vector(7 downto 0) := "00000011";
	constant Adr_OA: std_logic_vector(7 downto 0) := "00000000";
	constant Adr_OB: std_logic_vector(7 downto 0) := "00000001";
	constant Adr_OC: std_logic_vector(7 downto 0) := "00000010";
	constant Adr_OD: std_logic_vector(7 downto 0) := "00000011";


	-- Memory Array Types ---------------------------------------------------------------
	type RAM_Array is array (0 to 32767) of std_logic_vector(7 downto 0);
	type ROM_Array is array (0 to 381) of std_logic_vector(7 downto 0);


	-- Components -----------------------------------------------------------------------
	COMPONENT DMC8 IS
	port(
		RESET_n		: in std_logic;
		CLK			: in std_logic;
		IRQ0_n		: in std_logic;    -- IRQ0_n, IRQ1_n, IRQ2_n   (instead of INT_n only)
		IRQ1_n		: in std_logic;	 -- 7 interrupt requests, coded as bin number
		IRQ2_n		: in std_logic;
		SYNC_n		: out std_logic;
		MEMREQ_n		: out std_logic;
		IOREQ_n		: out std_logic;
		READ_n		: out std_logic;
		WRITE_n		: out std_logic;
      INTACK_n		: out std_logic;
		Addr			: out std_logic_vector(15 downto 0);
		DataIn		: in std_logic_vector(7 downto 0);
		DataOut		: out std_logic_vector(7 downto 0);
		-- Debug Interface ----------------------------
      oRes_n		: out std_logic;
      oStepSync   : out std_logic;
		S0				: in	std_logic;	-- CPU register selection (5 bits + nibble)
		S1				: in	std_logic;
		S2				: in	std_logic;
		S3				: in	std_logic;
		S4				: in	std_logic;
		Ni				: in	std_logic;
		R0				: out std_logic;
		R1				: out std_logic;
		R2				: out std_logic;
		R3				: out std_logic
		);
	END COMPONENT;


   -- Signals --------------------------------------------------------------------------
	SIGNAL CLK_i		: std_logic;
	
	
	
	SIGNAL nSYNC_i		: std_logic;	
	SIGNAL nINTACK_i	: std_logic;
	SIGNAL nRESCPU_i	: std_logic;
	SIGNAL nMEMREQ_i	: std_logic;
	SIGNAL nIOREQ_i	: std_logic;
	SIGNAL nREAD_i		: std_logic;
	SIGNAL nWRITE_i	: std_logic;
	SIGNAL Addr_i		: std_logic_vector(15 downto 0);
	SIGNAL DI_CPU_i	: std_logic_vector(7 downto 0);
	SIGNAL DO_RAM_i	: std_logic_vector(7 downto 0);
	SIGNAL DO_ROM_i	: std_logic_vector(7 downto 0);
	SIGNAL DO_CPU_i	: std_logic_vector(7 downto 0);
	SIGNAL DO_InIA_i	: std_logic_vector(7 downto 0);
	SIGNAL DO_InIB_i	: std_logic_vector(7 downto 0);
	SIGNAL DO_InIC_i	: std_logic_vector(7 downto 0);
	SIGNAL DO_InID_i	: std_logic_vector(7 downto 0);
	SIGNAL nROM_CS_i	: std_logic;
	SIGNAL nRAM_CS_i	: std_logic;
	SIGNAL EnPort_IA	: std_logic;
	SIGNAL EnPort_IB	: std_logic;
	SIGNAL EnPort_IC	: std_logic;
	SIGNAL EnPort_ID	: std_logic;
	SIGNAL EnPort_OA	: std_logic;
	SIGNAL EnPort_OB	: std_logic;
	SIGNAL EnPort_OC	: std_logic;
	SIGNAL EnPort_OD	: std_logic;

	-- Debug Interface ----------------------------
   SIGNAL xRes_n		: std_logic;
   SIGNAL xStepSync	: std_logic;
   SIGNAL xS0			: std_logic;
   SIGNAL xS1			: std_logic;
   SIGNAL xS2			: std_logic;
   SIGNAL xS3			: std_logic;
   SIGNAL xS4			: std_logic;
   SIGNAL xNi			: std_logic;
   SIGNAL xR0			: std_logic;
   SIGNAL xR1			: std_logic;
   SIGNAL xR2			: std_logic;
   SIGNAL xR3			: std_logic;

	-- RAM Memory Array -----------------------------------------------------------------
	SIGNAL RAM_Bytes: RAM_Array;

	-- ROM Memory Array -----------------------------------------------------------------
	constant ROM_Bytes: ROM_Array:= (
      00000 => "11000011", 00001 => "00000000", 00002 => "00000001", 00003 => "11111111", 00004 => "11111111",
      00005 => "11111111", 00006 => "11111111", 00007 => "11111111", 00008 => "11111111", 00009 => "11111111",
      00010 => "11111111", 00011 => "11111111", 00012 => "11111111", 00013 => "11111111", 00014 => "11111111",
      00015 => "11111111", 00016 => "11111111", 00017 => "11111111", 00018 => "11111111", 00019 => "11111111",
      00020 => "11111111", 00021 => "11111111", 00022 => "11111111", 00023 => "11111111", 00024 => "11111111",
      00025 => "11111111", 00026 => "11111111", 00027 => "11111111", 00028 => "11111111", 00029 => "11111111",
      00030 => "11111111", 00031 => "11111111", 00032 => "11111111", 00033 => "11111111", 00034 => "11111111",
      00035 => "11111111", 00036 => "11111111", 00037 => "11111111", 00038 => "11111111", 00039 => "11111111",
      00040 => "11111111", 00041 => "11111111", 00042 => "11111111", 00043 => "11111111", 00044 => "11111111",
      00045 => "11111111", 00046 => "11111111", 00047 => "11111111", 00048 => "11111111", 00049 => "11111111",
      00050 => "11111111", 00051 => "11111111", 00052 => "11111111", 00053 => "11111111", 00054 => "11111111",
      00055 => "11111111", 00056 => "11111111", 00057 => "11111111", 00058 => "11111111", 00059 => "11111111",
      00060 => "11111111", 00061 => "11111111", 00062 => "11111111", 00063 => "11111111", 00064 => "11111111",
      00065 => "11111111", 00066 => "11111111", 00067 => "11111111", 00068 => "11111111", 00069 => "11111111",
      00070 => "11111111", 00071 => "11111111", 00072 => "11111111", 00073 => "11111111", 00074 => "11111111",
      00075 => "11111111", 00076 => "11111111", 00077 => "11111111", 00078 => "11111111", 00079 => "11111111",
      00080 => "11111111", 00081 => "11111111", 00082 => "11111111", 00083 => "11111111", 00084 => "11111111",
      00085 => "11111111", 00086 => "11111111", 00087 => "11111111", 00088 => "11111111", 00089 => "11111111",
      00090 => "11111111", 00091 => "11111111", 00092 => "11111111", 00093 => "11111111", 00094 => "11111111",
      00095 => "11111111", 00096 => "11111111", 00097 => "11111111", 00098 => "11111111", 00099 => "11111111",
      00100 => "11111111", 00101 => "11111111", 00102 => "11111111", 00103 => "11111111", 00104 => "11111111",
      00105 => "11111111", 00106 => "11111111", 00107 => "11111111", 00108 => "11111111", 00109 => "11111111",
      00110 => "11111111", 00111 => "11111111", 00112 => "11111111", 00113 => "11111111", 00114 => "11111111",
      00115 => "11111111", 00116 => "11111111", 00117 => "11111111", 00118 => "11111111", 00119 => "11111111",
      00120 => "11111111", 00121 => "11111111", 00122 => "11111111", 00123 => "11111111", 00124 => "11111111",
      00125 => "11111111", 00126 => "11111111", 00127 => "11111111", 00128 => "11111111", 00129 => "11111111",
      00130 => "11111111", 00131 => "11111111", 00132 => "11111111", 00133 => "11111111", 00134 => "11111111",
      00135 => "11111111", 00136 => "11111111", 00137 => "11111111", 00138 => "11111111", 00139 => "11111111",
      00140 => "11111111", 00141 => "11111111", 00142 => "11111111", 00143 => "11111111", 00144 => "11111111",
      00145 => "11111111", 00146 => "11111111", 00147 => "11111111", 00148 => "11111111", 00149 => "11111111",
      00150 => "11111111", 00151 => "11111111", 00152 => "11111111", 00153 => "11111111", 00154 => "11111111",
      00155 => "11111111", 00156 => "11111111", 00157 => "11111111", 00158 => "11111111", 00159 => "11111111",
      00160 => "11111111", 00161 => "11111111", 00162 => "11111111", 00163 => "11111111", 00164 => "11111111",
      00165 => "11111111", 00166 => "11111111", 00167 => "11111111", 00168 => "11111111", 00169 => "11111111",
      00170 => "11111111", 00171 => "11111111", 00172 => "11111111", 00173 => "11111111", 00174 => "11111111",
      00175 => "11111111", 00176 => "11111111", 00177 => "11111111", 00178 => "11111111", 00179 => "11111111",
      00180 => "11111111", 00181 => "11111111", 00182 => "11111111", 00183 => "11111111", 00184 => "11111111",
      00185 => "11111111", 00186 => "11111111", 00187 => "11111111", 00188 => "11111111", 00189 => "11111111",
      00190 => "11111111", 00191 => "11111111", 00192 => "11111111", 00193 => "11111111", 00194 => "11111111",
      00195 => "11111111", 00196 => "11111111", 00197 => "11111111", 00198 => "11111111", 00199 => "11111111",
      00200 => "11111111", 00201 => "11111111", 00202 => "11111111", 00203 => "11111111", 00204 => "11111111",
      00205 => "11111111", 00206 => "11111111", 00207 => "11111111", 00208 => "11111111", 00209 => "11111111",
      00210 => "11111111", 00211 => "11111111", 00212 => "11111111", 00213 => "11111111", 00214 => "11111111",
      00215 => "11111111", 00216 => "11111111", 00217 => "11111111", 00218 => "11111111", 00219 => "11111111",
      00220 => "11111111", 00221 => "11111111", 00222 => "11111111", 00223 => "11111111", 00224 => "11111111",
      00225 => "11111111", 00226 => "11111111", 00227 => "11111111", 00228 => "11111111", 00229 => "11111111",
      00230 => "11111111", 00231 => "11111111", 00232 => "11111111", 00233 => "11111111", 00234 => "11111111",
      00235 => "11111111", 00236 => "11111111", 00237 => "11111111", 00238 => "11111111", 00239 => "11111111",
      00240 => "11111111", 00241 => "11111111", 00242 => "11111111", 00243 => "11111111", 00244 => "11111111",
      00245 => "11111111", 00246 => "11111111", 00247 => "11111111", 00248 => "11111111", 00249 => "11111111",
      00250 => "11111111", 00251 => "11111111", 00252 => "11111111", 00253 => "11111111", 00254 => "11111111",
      00255 => "11111111", 00256 => "00111110", 00257 => "00000000", 00258 => "00000110", 00259 => "00000000",
      00260 => "00001110", 00261 => "00000000", 00262 => "11011101", 00263 => "00100001", 00264 => "00000000",
      00265 => "10000000", 00266 => "11111101", 00267 => "00100001", 00268 => "00000001", 00269 => "10000000",
      00270 => "11011101", 00271 => "00110110", 00272 => "00000000", 00273 => "10101010", 00274 => "11111101",
      00275 => "00110110", 00276 => "00000000", 00277 => "10101010", 00278 => "11011011", 00279 => "00000000",
      00280 => "11111110", 00281 => "00000000", 00282 => "11001100", 00283 => "01101110", 00284 => "00000001",
      00285 => "11011011", 00286 => "00000000", 00287 => "11111110", 00288 => "00000001", 00289 => "11001100",
      00290 => "01000000", 00291 => "00000001", 00292 => "11011011", 00293 => "00000000", 00294 => "11111110",
      00295 => "00000001", 00296 => "11000100", 00297 => "01010100", 00298 => "00000001", 00299 => "11011011",
      00300 => "00000000", 00301 => "11111110", 00302 => "00000010", 00303 => "11001100", 00304 => "01010111",
      00305 => "00000001", 00306 => "11011011", 00307 => "00000000", 00308 => "11111110", 00309 => "00000010",
      00310 => "11000100", 00311 => "01101011", 00312 => "00000001", 00313 => "00110001", 00314 => "11111111",
      00315 => "11111111", 00316 => "11001101", 00317 => "00010110", 00318 => "00000001", 00319 => "01110110",
      00320 => "00000100", 00321 => "01111000", 00322 => "11111110", 00323 => "00010100", 00324 => "11001100",
      00325 => "01001000", 00326 => "00000001", 00327 => "11001001", 00328 => "11011101", 00329 => "01111110",
      00330 => "00000000", 00331 => "00111100", 00332 => "11011101", 00333 => "01110111", 00334 => "00000000",
      00335 => "11010011", 00336 => "00000010", 00337 => "00000110", 00338 => "00000000", 00339 => "11001001",
      00340 => "00000110", 00341 => "00000000", 00342 => "11001001", 00343 => "00001100", 00344 => "01111001",
      00345 => "11111110", 00346 => "00010100", 00347 => "11001100", 00348 => "01011111", 00349 => "00000001",
      00350 => "11001001", 00351 => "11011101", 00352 => "01111110", 00353 => "00000000", 00354 => "00111101",
      00355 => "11011101", 00356 => "01110111", 00357 => "00000000", 00358 => "11010011", 00359 => "00000010",
      00360 => "00001110", 00361 => "00000000", 00362 => "11001001", 00363 => "00001110", 00364 => "00000000",
      00365 => "11001001", 00366 => "00111110", 00367 => "10000000", 00368 => "11010011", 00369 => "00000011",
      00370 => "11011011", 00371 => "00000000", 00372 => "11111110", 00373 => "00000000", 00374 => "11001010",
      00375 => "01110010", 00376 => "00000001", 00377 => "00111110", 00378 => "00000000", 00379 => "11010011",
      00380 => "00000011", 00381 => "11001001",
		OTHERS=> "11111111"
		);

BEGIN
	nRESCPU_i <= nRESET;
	nRSOUT <= nRESCPU_i;

	CLK_i	<= CK;
	CKOUT <= CLK_i;	  	-- Clock Output
	nINTA <= nINTACK_i;
	nSYNC <= nSYNC_i;

	-- CPU Core --------------------------------------------
	CPU_Core: DMC8 PORT MAP (
		RESET_n => nRESCPU_i,
		CLK => CLK_i,
		IRQ0_n => nINT,	-- tied together, to get the "INT38"
		IRQ1_n => nINT,
		IRQ2_n => nINT,
		SYNC_n => nSYNC_i,
		MEMREQ_n => nMEMREQ_i,
		IOREQ_n => nIOREQ_i,
		READ_n => nREAD_i,
		WRITE_n => nWRITE_i,
		INTACK_n => nINTACK_i,
		Addr => Addr_i,
		DataIn => DI_CPU_i,
		DataOut => DO_CPU_i,
		-- Debug Interface ----------------------------
      oRes_n => xRes_n,
      oStepSync => xStepSync,
		S0 => xS0,
		S1 => xS1,
		S2 => xS2,
		S3 => xS3,
		S4 => xS4,
		Ni => xNi,
		R0 => xR0,
		R1 => xR1,
		R2 => xR2,
		R3 => xR3
		);

	-- Debug Interface ----------------------------
	NRES <= xRes_n;
   STEP <= xStepSync;
	xS0 <= S0;
	xS1 <= S1;
	xS2 <= S2;
	xS3 <= S3;
	xS4 <= S4;
	xNi <= Ni;
	R0	<= xR0;
	R1	<= xR1;
	R2	<= xR2;
	R3	<= xR3;
	R0	<= xR0;

	-- Input Port "Buffers" -------------------------------------------------------------
	DO_InIA_i(7) <= IA7; DO_InIA_i(6) <= IA6;	DO_InIA_i(5) <= IA5;	DO_InIA_i(4) <= IA4;
	DO_InIA_i(3) <= IA3;	DO_InIA_i(2) <= IA2;	DO_InIA_i(1) <= IA1;	DO_InIA_i(0) <= IA0;
   --
	DO_InIB_i(7) <= IB7; DO_InIB_i(6) <= IB6;	DO_InIB_i(5) <= IB5;	DO_InIB_i(4) <= IB4;
	DO_InIB_i(3) <= IB3;	DO_InIB_i(2) <= IB2;	DO_InIB_i(1) <= IB1;	DO_InIB_i(0) <= IB0;
   --
	DO_InIC_i(7) <= IC7; DO_InIC_i(6) <= IC6;	DO_InIC_i(5) <= IC5;	DO_InIC_i(4) <= IC4;
	DO_InIC_i(3) <= IC3;	DO_InIC_i(2) <= IC2;	DO_InIC_i(1) <= IC1;	DO_InIC_i(0) <= IC0;
   --
	DO_InID_i(7) <= ID7; DO_InID_i(6) <= ID6;	DO_InID_i(5) <= ID5;	DO_InID_i(4) <= ID4;
	DO_InID_i(3) <= ID3;	DO_InID_i(2) <= ID2;	DO_InID_i(1) <= ID1;	DO_InID_i(0) <= ID0;
	
	
	-- Memory Address Decoders ----------------------------------------------------------
	nROM_CS_i <= not ((not nMEMREQ_i) and (not Addr_i(15))); 
	nRAM_CS_i <= not ((not nMEMREQ_i) and Addr_i(15));

	
	-- Input Port Address Decoders ------------------------------------------------------
   EnPort_IA <= (not nIOREQ_i) and 
							((Addr_i(7) xnor Adr_IA(7)) and (Addr_i(6) xnor Adr_IA(6)) and
							 (Addr_i(5) xnor Adr_IA(5)) and (Addr_i(4) xnor Adr_IA(4)) and
							 (Addr_i(3) xnor Adr_IA(3)) and (Addr_i(2) xnor Adr_IA(2)) and
							 (Addr_i(1) xnor Adr_IA(1)) and (Addr_i(0) xnor Adr_IA(0)) );
   EnPort_IB <= (not nIOREQ_i) and 
							((Addr_i(7) xnor Adr_IB(7)) and (Addr_i(6) xnor Adr_IB(6)) and
							 (Addr_i(5) xnor Adr_IB(5)) and (Addr_i(4) xnor Adr_IB(4)) and
							 (Addr_i(3) xnor Adr_IB(3)) and (Addr_i(2) xnor Adr_IB(2)) and
							 (Addr_i(1) xnor Adr_IB(1)) and (Addr_i(0) xnor Adr_IB(0)) );
   EnPort_IC <= (not nIOREQ_i) and 
							((Addr_i(7) xnor Adr_IC(7)) and (Addr_i(6) xnor Adr_IC(6)) and
							 (Addr_i(5) xnor Adr_IC(5)) and (Addr_i(4) xnor Adr_IC(4)) and
							 (Addr_i(3) xnor Adr_IC(3)) and (Addr_i(2) xnor Adr_IC(2)) and
							 (Addr_i(1) xnor Adr_IC(1)) and (Addr_i(0) xnor Adr_IC(0)) );
   EnPort_ID <= (not nIOREQ_i) and 
							((Addr_i(7) xnor Adr_ID(7)) and (Addr_i(6) xnor Adr_ID(6)) and
							 (Addr_i(5) xnor Adr_ID(5)) and (Addr_i(4) xnor Adr_ID(4)) and
							 (Addr_i(3) xnor Adr_ID(3)) and (Addr_i(2) xnor Adr_ID(2)) and
							 (Addr_i(1) xnor Adr_ID(1)) and (Addr_i(0) xnor Adr_ID(0)) );
								 
	nRA <= not((not nREAD_i) and EnPort_IA);
	nRB <= not((not nREAD_i) and EnPort_IB); 
	nRC <= not((not nREAD_i) and EnPort_IC); 
	nRD <= not((not nREAD_i) and EnPort_ID); 

	
	-- Input Port Address Decoders ------------------------------------------------------
   EnPort_OA <= (not nIOREQ_i) and 
							((Addr_i(7) xnor Adr_OA(7)) and (Addr_i(6) xnor Adr_OA(6)) and
							 (Addr_i(5) xnor Adr_OA(5)) and (Addr_i(4) xnor Adr_OA(4)) and
							 (Addr_i(3) xnor Adr_OA(3)) and (Addr_i(2) xnor Adr_OA(2)) and
							 (Addr_i(1) xnor Adr_OA(1)) and (Addr_i(0) xnor Adr_OA(0)) );
   EnPort_OB <= (not nIOREQ_i) and 
							((Addr_i(7) xnor Adr_OB(7)) and (Addr_i(6) xnor Adr_OB(6)) and
							 (Addr_i(5) xnor Adr_OB(5)) and (Addr_i(4) xnor Adr_OB(4)) and
							 (Addr_i(3) xnor Adr_OB(3)) and (Addr_i(2) xnor Adr_OB(2)) and
							 (Addr_i(1) xnor Adr_OB(1)) and (Addr_i(0) xnor Adr_OB(0)) );
   EnPort_OC <= (not nIOREQ_i) and 
							((Addr_i(7) xnor Adr_OC(7)) and (Addr_i(6) xnor Adr_OC(6)) and
							 (Addr_i(5) xnor Adr_OC(5)) and (Addr_i(4) xnor Adr_OC(4)) and
							 (Addr_i(3) xnor Adr_OC(3)) and (Addr_i(2) xnor Adr_OC(2)) and
							 (Addr_i(1) xnor Adr_OC(1)) and (Addr_i(0) xnor Adr_OC(0)) );
   EnPort_OD <= (not nIOREQ_i) and
							((Addr_i(7) xnor Adr_OD(7)) and (Addr_i(6) xnor Adr_OD(6)) and
							 (Addr_i(5) xnor Adr_OD(5)) and (Addr_i(4) xnor Adr_OD(4)) and
							 (Addr_i(3) xnor Adr_OD(3)) and (Addr_i(2) xnor Adr_OD(2)) and
							 (Addr_i(1) xnor Adr_OD(1)) and (Addr_i(0) xnor Adr_OD(0)) );
	nWA <= not((not nWRITE_i) and EnPort_OA);
	nWB <= not((not nWRITE_i) and EnPort_OB);
	nWC <= not((not nWRITE_i) and EnPort_OC);
	nWD <= not((not nWRITE_i) and EnPort_OD);

			
	-- Data Bus Multiplexer toward CPU Data Bus Input -----------------------------------
	DI_CPU_i <=	DO_ROM_i		when (nROM_CS_i = '0') else
					DO_RAM_i		when (nRAM_CS_i = '0') else 
					DO_InIA_i	WHEN (nREAD_i = '0') and (EnPort_IA = '1') else
					DO_InIB_i	WHEN (nREAD_i = '0') and (EnPort_IB = '1') else
					DO_InIC_i	WHEN (nREAD_i = '0') and (EnPort_IC = '1') else
					DO_InID_i	WHEN (nREAD_i = '0') and (EnPort_ID = '1') else
					"00000000";


	-- ROM read operation -----------------------------------------------------------------
	process( nROM_CS_i, nREAD_i ) 
	begin
		if (nROM_CS_i = '0') and (nREAD_i = '0') then	
			  DO_ROM_i <= ROM_Bytes(to_integer(unsigned(Addr_i(14 downto 0))));
		else DO_ROM_i <= "11111111";
		end if;
	end process;
	
	
	-- RAM read/write operations ----------------------------------------------------------
	process(CLK_i, nRAM_CS_i, nREAD_i, nWRITE_i)
	begin
		if (nRAM_CS_i = '0') and
		   (nREAD_i = '0') and (nWRITE_i = '1') then
			DO_RAM_i <= RAM_Bytes(to_integer(unsigned(Addr_i(14 downto 0))));
		else
			DO_RAM_i <= "00000000";
			if (CLK_i'event and (CLK_i = '1')) then
				if (nRAM_CS_i = '0') and (nWRITE_i = '0') then
					RAM_Bytes(to_integer(unsigned(Addr_i(14 downto 0)))) <= DO_CPU_i;
				end if;
			end if;
		end if;
	end process;

	
	-- OA Output Port ------------------------------------------------------------
	process(nRESCPU_i, nWRITE_i, EnPort_OA)  
	begin
		if (nRESCPU_i = '0') then
			OA7 <='0'; 
			OA6 <='0'; 
			OA5 <='0';	
			OA4 <='0'; 
			OA3 <='0';
			OA2 <='0';
			OA1 <='0'; 
			OA0 <='0';	
		elsif (nWRITE_i = '0') and (EnPort_OA = '1') then
			OA7 <= DO_CPU_i(7); 
			OA6 <= DO_CPU_i(6); 
			OA5 <= DO_CPU_i(5);	
			OA4 <= DO_CPU_i(4);
			OA3 <= DO_CPU_i(3); 
			OA2 <= DO_CPU_i(2); 
			OA1 <= DO_CPU_i(1); 
			OA0 <= DO_CPU_i(0);
		end if;
	end process;

	-- OB Output Port ------------------------------------------------------------
	process(nRESCPU_i, nWRITE_i, EnPort_OB)  
	begin
		if (nRESCPU_i = '0') then
			OB7 <='0'; 
			OB6 <='0'; 
			OB5 <='0';	
			OB4 <='0'; 
			OB3 <='0'; 
			OB2 <='0'; 
			OB1 <='0'; 
			OB0 <='0';
		elsif (nWRITE_i = '0') and (EnPort_OB = '1') then
			OB7 <= DO_CPU_i(7); 
			OB6 <= DO_CPU_i(6); 
			OB5 <= DO_CPU_i(5);	
			OB4 <= DO_CPU_i(4);
			OB3 <= DO_CPU_i(3); 
			OB2 <= DO_CPU_i(2); 
			OB1 <= DO_CPU_i(1); 
			OB0 <= DO_CPU_i(0);
		end if;
	end process;
	
	-- OC Output Port ------------------------------------------------------------
	process(nRESCPU_i, nWRITE_i, EnPort_OC)  
	begin
		if (nRESCPU_i = '0') then
			OC7 <='0'; 
			OC6 <='0'; 
			OC5 <='0';	
			OC4 <='0'; 
			OC3 <='0'; 
			OC2 <='0'; 
			OC1 <='0';
			OC0 <='0';
		elsif (nWRITE_i = '0') and (EnPort_OC = '1') then
			OC7 <= DO_CPU_i(7); 
			OC6 <= DO_CPU_i(6); 
			OC5 <= DO_CPU_i(5);	
			OC4 <= DO_CPU_i(4);
			OC3 <= DO_CPU_i(3); 
			OC2 <= DO_CPU_i(2); 
			OC1 <= DO_CPU_i(1); 
			OC0 <= DO_CPU_i(0);
		end if; 
	end process;
	
	-- OD Output Port ------------------------------------------------------------
	process(nRESCPU_i, nWRITE_i, EnPort_OD)  
	begin
		if (nRESCPU_i = '0') then
			OD7 <='0'; 
			OD6 <='0'; 
			OD5 <='0';	
			OD4 <='0'; 
			OD3 <='0'; 
			OD2 <='0'; 
			OD1 <='0'; 
			OD0 <='0';
		elsif (nWRITE_i = '0') and (EnPort_OD = '1') then
			OD7 <= DO_CPU_i(7); 
			OD6 <= DO_CPU_i(6); 
			OD5 <= DO_CPU_i(5);	
			OD4 <= DO_CPU_i(4);
			OD3 <= DO_CPU_i(3); 
			OD2 <= DO_CPU_i(2); 
			OD1 <= DO_CPU_i(1); 
			OD0 <= DO_CPU_i(0);
		end if;
	end process;
	
END structural;
