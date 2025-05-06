#Control File
#C file created using an r4ss function
#C file write time: 2025-05-02  15:35:52
#
0 # 0 means do not read wtatage.ss; 1 means read and usewtatage.ss and also read and use growth parameters
1 #_N_Growth_Patterns
1 #_N_platoons_Within_GrowthPattern
4 # recr_dist_method for parameters
1 # not yet implemented; Future usage:Spawner-Recruitment; 1=global; 2=by area
1 # number of recruitment settlement assignments 
0 # unused option
# for each settlement assignment:
#_GPattern	month	area	age
1	1	1	0	#_recr_dist_pattern1
#
#_Cond 0 # N_movement_definitions goes here if N_areas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
3 #_Nblock_Patterns
2 3 1 #_blocks_per_pattern
#_begin and end years of blocks
2002 2010 2011 2014
2002 2010 2011 2019 2020 2024
1995 2004
#
# controls for all timevary parameters 
1 #_env/block/dev_adjust_method for all time-vary parms (1=warn relative to base parm bounds; 3=no bound check)
#
# AUTOGEN
1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen all time-varying parms; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
# setup for M, growth, maturity, fecundity, recruitment distibution, movement
#
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=Maunder_M;_6=Age-range_Lorenzen
#_no additional input for selected M option; read 1P per morph
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr;5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
-1.19 #_Age(post-settlement)_for_L1;linear growth below this
999 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0 #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
0 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
#
#_growth_parms
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env_var&link	dev_link	dev_minyr	dev_maxyr	dev_PH	Block	Block_Fxn
0.001	     0.2	  0.0422163	    -3.3918	0.5424	3	 2	0	0	0	0	0	0	0	#_NatM_p_1_Fem_GP_1  
    -100	      25	    0	         12	    10	0	 2	0	0	0	0	0	0	0	#_L_at_Amin_Fem_GP_1 
   40	      90	    58.81	         58	    10	0	 2	0	0	0	0	0	0	0	#_L_at_Amax_Fem_GP_1 
 0.01	    0.15	  0.0814609	      0.069	    99	0	 2	0	0	0	0	0	0	0	#_VonBert_K_Fem_GP_1 
  0.000001	      1	     0.1	          0.1	    99	0	 2	0	0	0	0	0	0	0	#_CV_young_Fem_GP_1  
  0.000001	      1	     0.1	          0.1	    99	0	 2	0	0	0	0	0	0	0	#_CV_old_Fem_GP_1    
   -3	       3	8.77857e-06	8.77857e-06	    99	0	-3	0	0	0	0	0	0	0	#_Wtlen_1_Fem_GP_1   
   -3	       4	      3.153	      3.153	    99	0	-3	0	0	0	0	0	0	0	#_Wtlen_2_Fem_GP_1   
    1	      60	    46.5346	    46.5346	    99	0	-3	0	0	0	0	0	0	0	#_Mat50%_Fem_GP_1    
  -30	       3	   -0.25353	   -0.25353	    99	0	-3	0	0	0	0	0	0	0	#_Mat_slope_Fem_GP_1 
   -3	       3	          1	          1	     1	0	-3	0	0	0	0	0	0	0	#_Eggs_alpha_Fem_GP_1
   -3	       3	          0	          0	     1	0	-3	0	0	0	0	0	0	0	#_Eggs_beta_Fem_GP_1 
0.001	     0.2	  0.0422163	    -3.3918	0.5424	3	 2	0	0	0	0	0	0	0	#_NatM_p_1_Mal_GP_1  
    -100	      25	    0	         12	    10	0	 2	0	0	0	0	0	0	0	#_L_at_Amin_Mal_GP_1 
   40	      90	    57.13	         58	    10	0	 2	0	0	0	0	0	0	0	#_L_at_Amax_Mal_GP_1 
 0.01	    0.15	  0.09	      0.069	    99	0	 2	0	0	0	0	0	0	0	#_VonBert_K_Mal_GP_1 
  0.000001	      1	    0.1	          0.1	    99	0	 2	0	0	0	0	0	0	0	#_CV_young_Mal_GP_1  
  0.000001	      1	    0.1	          0.1	    99	0	 2	0	0	0	0	0	0	0	#_CV_old_Mal_GP_1    
   -3	       3	1.18439e-05	1.18439e-05	    99	0	-3	0	0	0	0	0	0	0	#_Wtlen_1_Mal_GP_1   
   -3	       4	      3.071	      3.071	    99	0	-3	0	0	0	0	0	0	0	#_Wtlen_2_Mal_GP_1   
    0	       1	          1	          1	     0	0	-4	0	0	0	0	0	0	0	#_CohortGrowDev      
1e-06	0.999999	        0.5	        0.5	    99	0	-5	0	0	0	0	0	0	0	#_FracFemale_GP_1    
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; 2=Ricker; 3=std_B-H; 4=SCAA;5=Hockey; 6=B-H_flattop; 7=survival_3Parm;8=Shepard_3Parm
0 # 0/1 to use steepness in initial equ recruitment calculation
0 # future feature: 0/1 to make realized sigmaR a function of SR curvature
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn # parm_name
   1	  15	6.19871	   6	   10	0	  1	0	0	0	0	0	0	0	#_SR_LN(R0)  
0.25	0.99	   0.72	0.72	0.152	2	 -3	0	0	0	0	0	0	0	#_SR_BH_steep
   0	   2	    0.5	 0.5	  0.8	0	 -4	0	0	0	0	0	0	0	#_SR_sigmaR  
  -5	   5	      0	   0	    1	0	 -4	0	0	0	0	0	0	0	#_SR_regime  
   0	   0	      0	   0	    0	0	-99	0	0	0	0	0	0	0	#_SR_autocorr
#_no timevary SR parameters
2 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1900 # first year of main recr_devs; early devs can preceed this era
2023 # last year of main recr_devs; forecast devs start in following year
3 #_recdev phase
1 # (0/1) to read 13 advanced options
0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
-4 #_recdev_early_phase
0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
1 #_lambda for Fcast_recr_like occurring before endyr+1
1965 #_last_yr_nobias_adj_in_MPD; begin of ramp
1995 #_first_yr_fullbias_adj_in_MPD; begin of plateau
2010 #_last_yr_fullbias_adj_in_MPD
2021 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS sets bias_adj to 0.0 for fcast yrs)
0.6 #_max_bias_adj_in_MPD (-1 to override ramp and set biasadj=1.0 for all estimated recdevs)
0 #_period of cycles in recruitment (N parms read below)
-5 #min rec_dev
5 #max rec_dev
0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
#Fishing Mortality info
0.05 # F ballpark
-2001 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
4 # max F or harvest rate, depends on F_Method
5 # N iterations for tuning F in hybrid method (recommend 3 to 7)
#
#_initial_F_parms; count = 0
#
#_Q_setup for fleets with cpue or survey data
#_fleet	link	link_info	extra_se	biasadj	float  #  fleetname
    7	1	0	1	0	1	#_TRIENNIAL 
    8	1	0	0	0	1	#_AK_SLOPE  
    9	1	0	0	0	1	#_NW_SLOPE  
    10	1	0	0	0	1	#_WCGBTS    
-9999	0	0	0	0	0	#_terminator
#_Q_parms(if_any);Qunits_are_ln(q)
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn  #  parm_name
-10	 2	-0.973932	0	99	0	-1	0	0	0	0	0	0	0	#_LnQ_base_TRIENNIAL(7) 
  0	 2	 0.104247	0	99	0	 2	0	0	0	0	0	0	0	#_Q_extraSD_TRIENNIAL(7)
-15	15	  -2.7057	0	 1	0	-1	0	0	0	0	0	0	0	#_LnQ_base_AK_SLOPE(8)  
-15	15	 -2.58588	0	 1	0	-1	0	0	0	0	0	0	0	#_LnQ_base_NW_SLOPE(9)  
-15	15	 -2.19044	0	 1	0	-1	0	0	0	0	0	0	0	#_LnQ_base_WCGBTS(10)    
#_no timevary Q parameters
#
#_size_selex_patterns
#_Pattern	Discard	Male	Special
24	0	0	0	#_1 BOTTOM_TRAWL        
24	0	0	0	#_2 BOTTOM_TRAWL_DISCARD
24	0	0	0	#_3 NON_TRAWL      			
24	0	0	0	#_4 NON_TRAWL_DISCARD   
24	0	0	0	#_5 MIDWATER_TRAWL   		
24	0	0	0	#_6 AT_SEA_HAKE         
24	0	0	0	#_7 TRIENNIAL           
24	0	0	0	#_8 AK_SLOPE        		
15	0	0	8	#_9 NW_SLOPE     				
24	0	0	0	#_10 WCGBTS     					
#
#_age_selex_patterns
#_Pattern	Discard	Male	Special
10	0	0	0	#_1 BOTTOM_TRAWL        
10	0	0	0	#_2 BOTTOM_TRAWL_DISCARD
10	0	0	0	#_3 NON_TRAWL      			
10	0	0	0	#_4 NON_TRAWL_DISCARD   
10	0	0	0	#_5 MIDWATER_TRAWL   		
10	0	0	0	#_6 AT_SEA_HAKE         
10	0	0	0	#_7 TRIENNIAL           
10	0	0	0	#_8 AK_SLOPE        		
10	0	0	0	#_9 NW_SLOPE     				
10	0	0	0	#_10 WCGBTS     					
#
#_SizeSelex
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn  #  parm_name
  15	79	 51.0339	  45	99	0	 3	0	0	0	0	0	1	2	#_SizeSel_P_1_TRAWL(1)            
 -15	20	     -15	 -15	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_2_TRAWL(1)            
  -4	12	 4.06553	   3	99	0	 3	0	0	0	0	0	1	2	#_SizeSel_P_3_TRAWL(1)            
  -2	20	      20	  20	99	0	-4	0	0	0	0	0	0	0	#_SizeSel_P_4_TRAWL(1)            
-999	20	    -999	 0.5	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_5_TRAWL(1)            
-999	20	    -999	 0.5	99	0	-4	0	0	0	0	0	0	0	#_SizeSel_P_6_TRAWL(1)            
  15	79	 47.7723	  45	99	0	 3	0	0	0	0	0	0	0	#_SizeSel_P_1_TRAWL_DISCARD(8)    
 -15	20	     -15	 -15	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_2_TRAWL_DISCARD(8)    
  -4	12	 5.81542	   3	99	0	 3	0	0	0	0	0	0	0	#_SizeSel_P_3_TRAWL_DISCARD(8)    
  -2	20	      20	  20	99	0	 4	0	0	0	0	0	0	0	#_SizeSel_P_4_TRAWL_DISCARD(8)    
-999	20	    -999	-999	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_5_TRAWL_DISCARD(8)    
-999	20	    -999	-999	99	0	-4	0	0	0	0	0	0	0	#_SizeSel_P_6_TRAWL_DISCARD(8)    
  15	70	 48.3918	  45	99	0	 3	0	0	0	0	0	2	2	#_SizeSel_P_1_NON_TRAWL(2)        
 -15	20	     -15	 -15	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_2_NON_TRAWL(2)        
  -4	12	 3.19744	   3	99	0	 3	0	0	0	0	0	2	2	#_SizeSel_P_3_NON_TRAWL(2)        
  -2	20	      20	  20	99	0	-4	0	0	0	0	0	0	0	#_SizeSel_P_4_NON_TRAWL(2)        
-999	20	    -999	 0.5	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_5_NON_TRAWL(2)        
-999	20	    -999	 0.5	99	0	-4	0	0	0	0	0	0	0	#_SizeSel_P_6_NON_TRAWL(2)        
  15	70	 50.3172	  45	99	0	 3	0	0	0	0	0	0	0	#_SizeSel_P_1_NON_TRAWL_DISCARD(9)
 -15	20	     -15	 -15	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_2_NON_TRAWL_DISCARD(9)
  -4	12	 4.43115	   3	99	0	 3	0	0	0	0	0	0	0	#_SizeSel_P_3_NON_TRAWL_DISCARD(9)
  -2	20	      20	  20	99	0	 4	0	0	0	0	0	0	0	#_SizeSel_P_4_NON_TRAWL_DISCARD(9)
-999	20	    -999	-999	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_5_NON_TRAWL_DISCARD(9)
-999	20	    -999	-999	99	0	-4	0	0	0	0	0	0	0	#_SizeSel_P_6_NON_TRAWL_DISCARD(9)
  15	79	 51.0339	  45	99	0	 3	0	0	0	0	0	0	0	#_SizeSel_P_1_MDT(10)             
 -15	20	     -15	 -15	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_2_MDT(10)             
  -4	12	 4.06553	   3	99	0	 3	0	0	0	0	0	0	0	#_SizeSel_P_3_MDT(10)             
  -2	20	      20	  20	99	0	-4	0	0	0	0	0	0	0	#_SizeSel_P_4_MDT(10)             
-999	20	    -999	 0.5	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_5_MDT(10)             
-999	20	    -999	 0.5	99	0	-4	0	0	0	0	0	0	0	#_SizeSel_P_6_MDT(10)             
  15	70	  56.075	  50	99	0	 3	0	0	0	0	0	0	0	#_SizeSel_P_1_AT_SEA_HAKE(3)      
 -15	20	     -15	 -15	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_2_AT_SEA_HAKE(3)      
  -4	12	 4.20926	   4	99	0	 3	0	0	0	0	0	0	0	#_SizeSel_P_3_AT_SEA_HAKE(3)      
  -2	20	      20	  20	99	0	-4	0	0	0	0	0	0	0	#_SizeSel_P_4_AT_SEA_HAKE(3)      
-999	20	    -999	-999	99	0	-2	0	0	0	0	0	0	0	#_SizeSel_P_5_AT_SEA_HAKE(3)      
-999	20	    -999	   5	99	0	-4	0	0	0	0	0	0	0	#_SizeSel_P_6_AT_SEA_HAKE(3)      
  13	50	 19.4947	  25	99	0	 3	0	0	0	0	0	0	0	#_SizeSel_P_1_TRIENNIAL(4)        
 -15	20	     -15	 -15	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_2_TRIENNIAL(4)        
  -4	12	 2.54332	   3	99	0	 3	0	0	0	0	0	0	0	#_SizeSel_P_3_TRIENNIAL(4)        
  -2	20	      5	  20	99	0	 3	0	0	0	0	0	0	0	#_SizeSel_P_4_TRIENNIAL(4)        
-999	20	    -15	 0.5	99	0	-2	0	0	0	0	0	0	0	#_SizeSel_P_5_TRIENNIAL(4)        
-999	20	    -15	 0.5	99	0	-4	0	0	0	0	0	0	0	#_SizeSel_P_6_TRIENNIAL(4)        
  13	50	  21.625	  35	99	0	 3	0	0	0	0	0	0	0	#_SizeSel_P_1_AK_SLOPE(5)         
 -15	20	     -15	 -15	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_2_AK_SLOPE(5)         
  -4	12	-1.71241	   5	99	0	 3	0	0	0	0	0	0	0	#_SizeSel_P_3_AK_SLOPE(5)         
  -2	20	      5 	  20	99	0	 4	0	0	0	0	0	0	0	#_SizeSel_P_4_AK_SLOPE(5)         
-999	20	    -15 -999	99	0	-2	0	0	0	0	0	0	0	#_SizeSel_P_5_AK_SLOPE(5)         
-999	20	    -15    5	99	0	-4	0	0	0	0	0	0	0	#_SizeSel_P_6_AK_SLOPE(5)         
  13	50	 18.2307	  20	99	0	 3	0	0	0	0	0	0	0	#_SizeSel_P_1_WCGBTS(7)           
 -15	20	     -15	 -15	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_2_WCGBTS(7)           
  -4	12	 2.69688	   3	99	0	 3	0	0	0	0	0	0	0	#_SizeSel_P_3_WCGBTS(7)           
  -2	20	      5	  20	99	0	 4	0	0	0	0	0	0	0	#_SizeSel_P_4_WCGBTS(7)           
-999	20	    -15	-999	99	0	-2	0	0	0	0	0	0	0	#_SizeSel_P_5_WCGBTS(7)           
-999	20	    -15	-999	99	0	-4	0	0	0	0	0	0	0	#_SizeSel_P_6_WCGBTS(7)           
#_AgeSelex
#_No age_selex_parm
# timevary selex parameters 
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE
15	70	38.4627	45	99	0	3	#_SizeSel_P_1_TRAWL(1)_BLK1repl_2002    
15	70	38.4627	45	99	0	3	#_SizeSel_P_1_TRAWL(1)_BLK1repl_2011    
-4	12	3.78134	 3	99	0	3	#_SizeSel_P_3_TRAWL(1)_BLK1repl_2002    
-4	12	3.78134	 3	99	0	3	#_SizeSel_P_3_TRAWL(1)_BLK1repl_2011    
15	70	45.3578	45	99	0	3	#_SizeSel_P_1_NON_TRAWL(2)_BLK2repl_2002
15	70	45.3578	45	99	0	3	#_SizeSel_P_1_NON_TRAWL(2)_BLK2repl_2011
15	70	45.3578	45	99	0	3	#_SizeSel_P_1_NON_TRAWL(2)_BLK2repl_2020
-4	12	2.55971	 3	99	0	3	#_SizeSel_P_3_NON_TRAWL(2)_BLK2repl_2002
-4	12	2.55971	 3	99	0	3	#_SizeSel_P_3_NON_TRAWL(2)_BLK2repl_2011
-4	12	2.55971	 3	99	0	3	#_SizeSel_P_3_NON_TRAWL(2)_BLK2repl_2020
# info on dev vectors created for selex parms are reported with other devs after tag parameter section
#
0 #  use 2D_AR1 selectivity(0/1):  experimental feature
#_no 2D_AR1 selex offset used
# Tag loss and Tag reporting parameters go next
0 # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# Input variance adjustments factors: 
#_factor	fleet	value
    4	 1	0.061601	#_Variance_adjustment_list1 
    4	 2	0.044313	#_Variance_adjustment_list7 
    4	 3	0.065636	#_Variance_adjustment_list2 
    4	 4	0.219116	#_Variance_adjustment_list8 
    4	 5	0.368387	#_Variance_adjustment_list9 
    4	 6	0.027122	#_Variance_adjustment_list3 
    4	 7	0.077933	#_Variance_adjustment_list4 
    4	 8	       1	#_Variance_adjustment_list5 
    4	 10	0.090484	#_Variance_adjustment_list6 
    5	 1	0.095767	#_Variance_adjustment_list10
    5	 3	0.075234	#_Variance_adjustment_list11
    5	 5	0.136598	#_Variance_adjustment_list14
    5	 6	       1	#_Variance_adjustment_list12
    5	 10	0.602828	#_Variance_adjustment_list13
-9999	 0	       0	#_terminator                
#
15 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 0 changes to default Lambdas (default value is 1.0)
-9999 0 0 0 0 # terminator
#
0 # 0/1 read specs for more stddev reporting
#
999
