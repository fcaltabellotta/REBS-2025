#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#_data_and_control_files: 2025_rougheye_data.ss // 2025_rougheye_control.ss
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS3)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_within/between_stdev_ratio (no read if N_platoons=1)
#_Cond sd_ratio_rd < 0: platoon_sd_ratio parameter required after movement params.
#_Cond  1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
1 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
3 #_Nblock_Patterns
 1 2 1 #_blocks_per_pattern 
# begin and end years of blocks
 1995 2004
 2002 2010 2011 2024
 2011 2024
#
# controls for all timevary parameters 
1 #_time-vary parm bound check (1=warn relative to base parm bounds; 3=no bound check); Also see env (3) and dev (5) options to constrain with base bounds
#
# AUTOGEN
 1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen time-varying parms of this category; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=P_base*exp(TVP*env(y));  2: P(y)=P_base+TVP*env(y);  3: P(y)=f(TVP,env_Zscore) w/ logit to stay in min-max;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=dev(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho;  5: like 4 with logit transform to stay in base min-max
#_DevLinks(more):  21-25 keep last dev for rest of years
#
#_Prior_codes:  0=none; 6=normal; 1=symmetric beta; 2=CASAL's beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
#
# setup for M, growth, wt-len, maturity, fecundity, (hermaphro), recr_distr, cohort_grow, (movement), (age error), (catch_mult), sex ratio 
#_NATMORT
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=BETA:_Maunder_link_to_maturity;_6=Lorenzen_range
  #_no additional input for selected M option; read 1P per morph
#
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
2 #_Age(post-settlement) for L1 (aka Amin); first growth parameter is size at this age; linear growth below this
80 #_Age(post-settlement) for L2 (aka Amax); 999 to treat as Linf
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
2 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
5 #_First_Mature_Age
1 #_fecundity_at_length option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0.001 0.2 0.0495745 -3.3918 0.5424 3 5 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 1 25 11.4646 12 10 0 2 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 40 90 58.8061 58 10 0 3 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0.01 0.15 0.0741569 0.069 0.8 0 2 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0.5 15 0.621282 3 99 0 3 0 0 0 0 0 0 0 # SD_young_Fem_GP_1
 0.5 15 6.15585 3 99 0 4 0 0 0 0 0 0 0 # SD_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 -3 3 9.23918e-06 9.23918e-06 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 -3 4 3.13877 3.13877 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 1 60 43.87 43.87 0.8 0 -3 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -30 3 -0.3 -0.25 0.8 0 -3 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 -3 3 1 1 0.8 0 -3 0 0 0 0 0 0 0 # Eggs/kg_inter_Fem_GP_1
 -3 3 0 0 0.8 0 -3 0 0 0 0 0 0 0 # Eggs/kg_slope_wt_Fem_GP_1
# Sex: 2  BioPattern: 1  NatMort
 -3 3 0 0 0 0 -5 0 0 0 0 0 0 0 # NatM_uniform_Mal_GP_1
# Sex: 2  BioPattern: 1  Growth
 1 25 11.0317 12 10 0 2 0 0 0 0 0 0 0 # L_at_Amin_Mal_GP_1
 40 90 56.4536 58 10 0 3 0 0 0 0 0 0 0 # L_at_Amax_Mal_GP_1
 0.01 0.15 0.0843295 0.069 0.8 0 2 0 0 0 0 0 0 0 # VonBert_K_Mal_GP_1
 -3 3 0 0 0 0 -5 0 0 0 0 0 0 0 # SD_young_Mal_GP_1
 0.5 15 5.0719 3 99 0 4 0 0 0 0 0 0 0 # SD_old_Mal_GP_1
# Sex: 2  BioPattern: 1  WtLen
 -3 3 1.10901e-05 1.10901e-05 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_1_Mal_GP_1
 -3 4 3.08695 3.08695 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_2_Mal_GP_1
# Hermaphroditism
#  Recruitment Distribution 
#  Cohort growth dev base
 0 1 1 1 0 0 -4 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
#  Platoon StDev Ratio 
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
 1e-06 0.999999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#  M2 parameter for each predator fleet
#
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 1=NA; 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
             1            10       7.25331             6            10             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
          0.25          0.99         0.72         	0.72         0.152             2         -3          0          0          0          0          0          0          0 # SR_BH_steep
             0             2           0.4           0.6           0.8             0         -4          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0             1             0         -4          0          0          0          0          0          0          0 # SR_regime
             0             0             0             0             0             0        -99          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
2 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1980 # first year of main recr_devs; early devs can precede this era
2022 # last year of main recr_devs; forecast devs start in following year
3 #_recdev phase 
1 # (0/1) to read 13 advanced options
 1900 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 4 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1987.3 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1993.2 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2010 #_last_yr_fullbias_adj_in_MPD
 2022.2 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS3 sets bias_adj to 0.0 for fcast yrs)
 0.6504 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
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
# all recruitment deviations
#  1900E 1901E 1902E 1903E 1904E 1905E 1906E 1907E 1908E 1909E 1910E 1911E 1912E 1913E 1914E 1915E 1916E 1917E 1918E 1919E 1920E 1921E 1922E 1923E 1924E 1925E 1926E 1927E 1928E 1929E 1930E 1931E 1932E 1933E 1934E 1935E 1936E 1937E 1938E 1939E 1940E 1941E 1942E 1943E 1944E 1945E 1946E 1947E 1948E 1949E 1950E 1951E 1952E 1953E 1954E 1955E 1956E 1957E 1958E 1959E 1960E 1961E 1962E 1963E 1964E 1965E 1966E 1967E 1968E 1969E 1970E 1971E 1972E 1973E 1974E 1975E 1976E 1977E 1978E 1979E 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017R 2018R 2019R 2020R 2021R 2022R 2023F 2024F 2025F 2026F 2027F 2028F 2029F 2030F 2031F 2032F 2033F 2034F 2035F 2036F
#  0.0500368 0.0518791 0.0537277 0.0555693 0.0573869 0.0591589 0.0608595 0.062459 0.0639236 0.065215 0.0662912 0.0671055 0.0676071 0.0677428 0.0674562 0.06669 0.0653861 0.0634844 0.0609374 0.0577012 0.0537399 0.0490278 0.0435521 0.0373147 0.0303341 0.0226493 0.0143234 0.00544236 -0.00387931 -0.0134825 -0.0231667 -0.0327189 -0.0419372 -0.0506586 -0.0587512 -0.0660945 -0.072562 -0.0780167 -0.0823486 -0.085467 -0.0873024 -0.087796 -0.0869217 -0.0846648 -0.0810158 -0.0760793 -0.0698556 -0.0624239 -0.0539155 -0.0445145 -0.0344903 -0.0242091 -0.0141488 -0.00491099 0.00280432 0.00823068 0.0106101 0.00929521 0.00385334 -0.00583777 -0.0195487 -0.0367149 -0.0565032 -0.0779101 -0.0998619 -0.121277 -0.141136 -0.158496 -0.172509 -0.182385 -0.187384 -0.186848 -0.180264 -0.167516 -0.149153 -0.12672 -0.102902 -0.0811876 -0.0649413 -0.0581347 -0.0656819 -0.095069 -0.154474 -0.223283 -0.265946 -0.252861 -0.150101 0.0733641 0.366758 0.336694 0.107084 0.0597296 -0.158117 -0.251462 -0.630373 -0.858797 -0.77957 -0.544453 -0.0552827 0.896628 -0.250744 0.0977975 -0.484696 -0.110756 0.180154 -0.191249 -0.197602 0.549293 0.404348 0.218164 0.941124 0.1475 1.31616 0.194205 -0.335505 -0.365487 -0.038745 1.24623 0.405218 0.112232 -0.025588 -0.0125698 0.00178101 -0.000934567 0 0 0 0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
0.2 # F ballpark value in units of annual_F
-2001 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
4 # max F (methods 2-4) or harvest fraction (method 1)
5  # N iterations for tuning in hybrid mode; recommend 3 (faster) to 5 (more precise if many fleets)
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 0
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
#
# F rates by fleet x season
# Yr:  1892 1893 1894 1895 1896 1897 1898 1899 1900 1901 1902 1903 1904 1905 1906 1907 1908 1909 1910 1911 1912 1913 1914 1915 1916 1917 1918 1919 1920 1921 1922 1923 1924 1925 1926 1927 1928 1929 1930 1931 1932 1933 1934 1935 1936 1937 1938 1939 1940 1941 1942 1943 1944 1945 1946 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030 2031 2032 2033 2034 2035 2036
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# TRAWL 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2.52831e-07 1.55191e-07 5.80998e-07 1.68224e-05 2.81518e-05 2.40403e-05 2.67097e-05 2.62961e-05 5.37118e-05 8.1563e-05 0.00013606 0.000442003 0.000734567 0.00123217 0.000660718 0.000397058 0.000339009 0.000347344 0.000377395 0.000336982 0.000432171 0.000335737 0.000531811 0.000480764 0.00058323 0.000736362 0.000672131 0.000514637 0.000749557 0.000837228 0.000901614 0.000666418 0.000722021 0.00119359 0.00143132 0.000857941 0.00176383 0.000610059 3.65488e-05 0.000874412 0.000348821 0.00033708 0.000120078 0.00034497 0.000440973 4.5726e-05 0.00210793 0.00718317 0.00375203 0.00396397 0.00622401 0.00363551 0.00494725 0.00935263 0.0106921 0.0141781 0.0123772 0.02129 0.0126496 0.0178349 0.014234 0.0130399 0.0100725 0.0129773 0.0100922 0.00854805 0.00871315 0.00637164 0.00665764 0.00597535 0.00173113 0.00320305 0.00325087 0.0024894 0.00260137 0.00338583 0.00301147 0.00375854 0.00464367 0.00300385 0.00506876 0.00350535 0.00198094 0.00261061 0.00241138 0.00126547 0.000985077 0.00161293 0.0019811 0.00159849 0.0014962 0.00192426 0.00358898 0.0159294 0.0159294 0.0159294 0.0159294 0.0159294 0.0159294 0.0159294 0.0159294 0.0159294 0.0159294 0.0159294 0.0159294
# NON_TRAWL 0.00129784 0.00129876 0.00129966 0.000334326 8.04973e-05 8.20266e-05 4.64392e-05 7.85252e-05 0.000110615 0.000142717 0.000174805 0.00020689 0.000238985 0.000271099 0.000303201 0.000335319 0.000367461 0.0003996 0.000431732 0.000463838 0.000495856 0.00052768 0.000559243 0.000590515 0.00282122 0.00296966 0.00311346 0.00325388 0.00339705 0.00353927 0.00368119 0.0038253 0.00396989 0.00411246 0.00425735 0.00440026 0.00568889 0.00757027 0.00675433 0.00596381 0.00376731 0.00437376 0.00464703 0.00452678 0.00696829 0.00693854 0.00592396 0.00379342 0.00712611 0.00990884 0.0141945 0.0262402 0.00718548 0.00476951 0.0058088 0.00492924 0.00595881 0.00545663 0.00458191 0.00596425 0.00395708 0.00186858 0.00329157 0.00351722 0.00147808 0.00270293 0.000777125 0.00172465 0.00164838 0.00145231 0.00168963 0.0010635 0.00182591 0.000815843 0.000572923 0.000886317 0.000586882 0.00203209 0.00027599 6.1392e-05 0.00010326 0.000409022 0.00135933 0.000488578 0.00014598 0.0125389 0.00423142 0.0078122 0.00251532 0.00755474 0.00827942 0.00946918 0.0104251 0.0212127 0.0321992 0.0489739 0.0241665 0.0225102 0.0151114 0.0118267 0.0209721 0.0290343 0.0315728 0.0391898 0.028491 0.0200118 0.0245402 0.0158408 0.00285679 0.00172654 0.00229602 0.0018747 0.00272388 0.00396965 0.00466229 0.00462938 0.00439858 0.00828635 0.00568714 0.00335452 0.00394519 0.00317261 0.00198156 0.00247792 0.00319529 0.00311847 0.00246108 0.00204161 0.00127623 0.00109252 0.000976297 0.000940958 0.000489634 0.0165421 0.0165421 0.0165421 0.0165421 0.0165421 0.0165421 0.0165421 0.0165421 0.0165421 0.0165421 0.0165421 0.0165421
# AT_SEA_HAKE 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000147942 3.25548e-05 5.56416e-05 1.74393e-05 3.61348e-05 8.92383e-06 9.91613e-05 0 5.8227e-05 0.000108997 4.42366e-05 5.98988e-05 0.000215645 0.000832172 1.43995e-05 5.58096e-05 0.000298111 0.000578375 9.92622e-05 0.000379712 0.000187246 0.000490168 0.000636879 0.00112877 0.000589982 0.00454187 0.00133106 4.64677e-05 0.000136319 0.000861106 0.00223233 0.000408739 0.00178079 0.00463354 0.000569881 0.00133066 0.00501809 0.00336254 0.0011113 0.000347277 0.00135086 0.00182829 0.00234401 0.00988731 0.00768126 0.00255301 0.00227046 0.00390367 0.00226124 0.00221852 0.0165421 0.0165421 0.0165421 0.0165421 0.0165421 0.0165421 0.0165421 0.0165421 0.0165421 0.0165421 0.0165421 0.0165421
# TRAWL_DISCARD 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000797048 0.000807761 0.000523838 0.000303119 0.000912611 0.00197194 0.00192633 0.0025028 0.00347629 0.00902448 0.0079111 0.00223606 0.000567091 0.00278129 0.00215502 0.00297962 0.0103595 0.00326635 0.00243857 0.00541987 0.00524885 0.00488354 0 0 0 0 0 0 0 0 0 0 0 0 0
# NON_TRAWL_DISCARD 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3.46349e-05 0.000103863 0.000263567 0.000259313 6.38131e-05 0.000484264 0.000133999 7.35565e-05 0.00124044 0.000510812 0.00110685 0.000690276 0.000583824 0.000764604 0.000696892 0.00189537 0.000799967 0.00171101 5.63547e-05 0.000127713 0.000145584 2.5327e-05 0 0 0 0 0 0 0 0 0 0 0 0 0
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         4         1         0         1         0         1  #  TRIENNIAL
         5         1         0         1         0         1  #  AK_SLOPE
         6         1         0         1         0         1  #  NW_SLOPE
         7         1         0         1         0         1  #  WCGBTS
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
           -10             2      -2.77384             0            99             0         -1          0          0          0          0          0          0          0  #  LnQ_base_TRIENNIAL(4)
             0             2      0.374298             0            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_TRIENNIAL(4)
           -15            15      -3.20058             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_AK_SLOPE(5)
             0             2      0.142194             0            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_AK_SLOPE(5)
           -15            15      -2.02844             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_NW_SLOPE(6)
             0             2   1.21002e-07             0            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_NW_SLOPE(6)
           -15            15      -3.33834             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_WCGBTS(7)
             0             2     0.0265477             0            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_WCGBTS(7)
#_no timevary Q parameters
#
#_size_selex_patterns
#Pattern:_0;  parm=0; selex=1.0 for all sizes
#Pattern:_1;  parm=2; logistic; with 95% width specification
#Pattern:_5;  parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_11; parm=2; selex=1.0  for specified min-max population length bin range
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6;  parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (mean over bin range)
#Pattern:_8;  parm=8; double_logistic with smooth transitions and constant above Linf option
#Pattern:_9;  parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_2;  parm=6; double_normal with sel(minL) and sel(maxL), using joiners, back compatibile version of 24 with 3.30.18 and older
#Pattern:_25; parm=3; exponential-logistic in length
#Pattern:_27; parm=special+3; cubic spline in length; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=special+3+2; cubic spline; like 27, with 2 additional param for scaling (mean over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 24 0 0 0 # 1 TRAWL
 24 0 0 0 # 2 NON_TRAWL
 24 0 0 0 # 3 AT_SEA_HAKE
 24 0 0 0 # 4 TRIENNIAL
 24 0 0 0 # 5 AK_SLOPE
 15 0 0 5 # 6 NW_SLOPE
 24 0 0 0 # 7 WCGBTS
 24 0 0 0 # 8 TRAWL_DISCARD
 24 0 0 0 # 9 NON_TRAWL_DISCARD
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic. Recommend using pattern 18 instead.
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (mean over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (mean over bin range)
#Age patterns entered with value >100 create Min_selage from first digit and pattern from remainder
#_Pattern Discard Male Special
 10 0 0 0 # 1 TRAWL
 10 0 0 0 # 2 NON_TRAWL
 10 0 0 0 # 3 AT_SEA_HAKE
 10 0 0 0 # 4 TRIENNIAL
 10 0 0 0 # 5 AK_SLOPE
 10 0 0 0 # 6 NW_SLOPE
 10 0 0 0 # 7 WCGBTS
 10 0 0 0 # 8 TRAWL_DISCARD
 10 0 0 0 # 9 NON_TRAWL_DISCARD
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   TRAWL LenSelex
            15            79       43.7886            45            99             0          1          0          0          0          0          0          2          2  #  Size_DblN_peak_TRAWL(1)
           -15             4           -15           -15            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_TRAWL(1)
            -4            12       4.78458             3            99             0          2          0          0          0          0          0          2          2  #  Size_DblN_ascend_se_TRAWL(1)
            -2            10       4.43755            10            99             0          4          0          0          0          0          0          2          2  #  Size_DblN_descend_se_TRAWL(1)
          -999             9          -999           0.5            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_start_logit_TRAWL(1)
          -999             9          -999           0.5            99             0         -4          0          0          0          0          0          0          0  #  Size_DblN_end_logit_TRAWL(1)
# 2   NON_TRAWL LenSelex
            15            70       45.5038            45            99             0          1          0          0          0          0          0          2          2  #  Size_DblN_peak_NON_TRAWL(2)
           -15            10           -15           -15            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_NON_TRAWL(2)
            -4            12       2.57369             3            99             0          2          0          0          0          0          0          2          2  #  Size_DblN_ascend_se_NON_TRAWL(2)
            -2            10       4.17275            10            99             0          4          0          0          0          0          0          2          2  #  Size_DblN_descend_se_NON_TRAWL(2)
          -999             9          -999           0.5            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_start_logit_NON_TRAWL(2)
          -999             9          -999           0.5            99             0         -4          0          0          0          0          0          0          0  #  Size_DblN_end_logit_NON_TRAWL(2)
# 3   AT_SEA_HAKE LenSelex
            15            70       50.3916            50            99             0          2          0          0          0          0          0          0          0  #  Size_DblN_peak_AT_SEA_HAKE(3)
           -15            10           -15           -15            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_AT_SEA_HAKE(3)
            -4            12        3.3679             4            99             0          2          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_AT_SEA_HAKE(3)
            -2            10       5.50486            10            99             0          4          0          0          0          0          0          0          0  #  Size_DblN_descend_se_AT_SEA_HAKE(3)
          -999             9          -999          -999            99             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_AT_SEA_HAKE(3)
          -999             9          -999          -999            99             0         -4          0          0          0          0          0          0          0  #  Size_DblN_end_logit_AT_SEA_HAKE(3)
# 4   TRIENNIAL LenSelex
            13            50       13.2473            25            99             0          2          0          0          0          0          0          0          0  #  Size_DblN_peak_TRIENNIAL(4)
           -15            10           -15           -15            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_TRIENNIAL(4)
            -4            12      -3.94197             3            99             0          2          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_TRIENNIAL(4)
            -2            10       6.55338            10            99             0          3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_TRIENNIAL(4)
          -999             9          -999          -999            99             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_TRIENNIAL(4)
          -999             9          -999          -999            99             0         -4          0          0          0          0          0          0          0  #  Size_DblN_end_logit_TRIENNIAL(4)
# 5   AK_SLOPE LenSelex
            13            50       39.4222            35            99             0          2          0          0          0          0          0          0          0  #  Size_DblN_peak_AK_SLOPE(5)
           -15            10           -15           -15            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_AK_SLOPE(5)
            -4            12       5.15799             5            99             0          2          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_AK_SLOPE(5)
            -2            10       4.62104            10            99             0          4          0          0          0          0          0          0          0  #  Size_DblN_descend_se_AK_SLOPE(5)
          -999             9          -999          -999            99             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_AK_SLOPE(5)
          -999             9          -999          -999            99             0         -4          0          0          0          0          0          0          0  #  Size_DblN_end_logit_AK_SLOPE(5)
# 6   NW_SLOPE LenSelex
# 7   WCGBTS LenSelex
            13            50       18.5857            20            99             0          2          0          0          0          0          0          0          0  #  Size_DblN_peak_WCGBTS(7)
           -15             4           -15           -15            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_WCGBTS(7)
            -4            12       2.70809             3            99             0          2          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_WCGBTS(7)
            -2            10       9.34124            10            99             0          4          0          0          0          0          0          0          0  #  Size_DblN_descend_se_WCGBTS(7)
          -999             5          -999          -999            99             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_WCGBTS(7)
          -999            10          -999          -999            99             0         -4          0          0          0          0          0          0          0  #  Size_DblN_end_logit_WCGBTS(7)
# 8   TRAWL_DISCARD LenSelex
            15            79       47.7723            45            99             0          1          0          0          0          0          0          3          2  #  Size_DblN_peak_TRAWL_DISCARD(8)
           -15             4           -15           -15            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_TRAWL_DISCARD(8)
            -4            12       5.81542             3            99             0          2          0          0          0          0          0          3          2  #  Size_DblN_ascend_se_TRAWL_DISCARD(8)
            -2            10       4.96922            10            99             0          4          0          0          0          0          0          3          2  #  Size_DblN_descend_se_TRAWL_DISCARD(8)
          -999             9          -999          -999            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_start_logit_TRAWL_DISCARD(8)
          -999             9          -999          -999            99             0         -4          0          0          0          0          0          0          0  #  Size_DblN_end_logit_TRAWL_DISCARD(8)
# 9   NON_TRAWL_DISCARD LenSelex
            15            70       50.3172            45            99             0          1          0          0          0          0          0          3          2  #  Size_DblN_peak_NON_TRAWL_DISCARD(9)
           -15             4           -15           -15            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_NON_TRAWL_DISCARD(9)
            -4            12       4.43115             3            99             0          2          0          0          0          0          0          3          2  #  Size_DblN_ascend_se_NON_TRAWL_DISCARD(9)
            -2            10       9.98708            10            99             0          4          0          0          0          0          0          3          2  #  Size_DblN_descend_se_NON_TRAWL_DISCARD(9)
          -999             9          -999          -999            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_start_logit_NON_TRAWL_DISCARD(9)
          -999             9          -999          -999            99             0         -4          0          0          0          0          0          0          0  #  Size_DblN_end_logit_NON_TRAWL_DISCARD(9)
# 1   TRAWL AgeSelex
# 2   NON_TRAWL AgeSelex
# 3   AT_SEA_HAKE AgeSelex
# 4   TRIENNIAL AgeSelex
# 5   AK_SLOPE AgeSelex
# 6   NW_SLOPE AgeSelex
# 7   WCGBTS AgeSelex
# 8   TRAWL_DISCARD AgeSelex
# 9   NON_TRAWL_DISCARD AgeSelex
#_No_Dirichlet parameters
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
            15            79       47.8787            45            99             0      1  # Size_DblN_peak_TRAWL(1)_BLK2repl_2002
            15            79       53.2982            45            99             0      1  # Size_DblN_peak_TRAWL(1)_BLK2repl_2011
            -4            12       4.09158             3            99             0      2  # Size_DblN_ascend_se_TRAWL(1)_BLK2repl_2002
            -4            12       4.84299             3            99             0      2  # Size_DblN_ascend_se_TRAWL(1)_BLK2repl_2011
            -2            10       5.77479            10            99             0      4  # Size_DblN_descend_se_TRAWL(1)_BLK2repl_2002
            -2            10       7.16585            10            99             0      4  # Size_DblN_descend_se_TRAWL(1)_BLK2repl_2011
            15            70       46.4815            45            99             0      1  # Size_DblN_peak_NON_TRAWL(2)_BLK2repl_2002
            15            70       50.7663            45            99             0      1  # Size_DblN_peak_NON_TRAWL(2)_BLK2repl_2011
            -4            12       2.89797             3            99             0      2  # Size_DblN_ascend_se_NON_TRAWL(2)_BLK2repl_2002
            -4            12       3.81515             3            99             0      2  # Size_DblN_ascend_se_NON_TRAWL(2)_BLK2repl_2011
            -2            10       4.41671            10            99             0      4  # Size_DblN_descend_se_NON_TRAWL(2)_BLK2repl_2002
            -2            10       9.99572            10            99             0      4  # Size_DblN_descend_se_NON_TRAWL(2)_BLK2repl_2011
            15            79       22.2276            45            99             0      1  # Size_DblN_peak_TRAWL_DISCARD(8)_BLK3repl_2011
            -4            12       3.68375             3            99             0      2  # Size_DblN_ascend_se_TRAWL_DISCARD(8)_BLK3repl_2011
            -2            10       5.16476            10            99             0      4  # Size_DblN_descend_se_TRAWL_DISCARD(8)_BLK3repl_2011
            15            70        51.606            45            99             0      1  # Size_DblN_peak_NON_TRAWL_DISCARD(9)_BLK3repl_2011
            -4            12       3.73934             3            99             0      2  # Size_DblN_ascend_se_NON_TRAWL_DISCARD(9)_BLK3repl_2011
            -2            10       9.98829            10            99             0      4  # Size_DblN_descend_se_NON_TRAWL_DISCARD(9)_BLK3repl_2011
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0   #  use 2D_AR1 selectivity? (0/1)
#_no 2D_AR1 selex offset used
#_specs:  fleet, ymin, ymax, amin, amax, sigma_amax, use_rho, len1/age2, devphase, before_range, after_range
#_sigma_amax>amin means create sigma parm for each bin from min to sigma_amax; sigma_amax<0 means just one sigma parm is read and used for all bins
#_needed parameters follow each fleet's specifications
# -9999  0 0 0 0 0 0 0 0 0 0 # terminator
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read and autogen if tag data exist; 1=read
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# deviation vectors for timevary parameters
#  base   base first block   block  env  env   dev   dev   dev   dev   dev
#  type  index  parm trend pattern link  var  vectr link _mnyr  mxyr phase  dev_vector
#      5     1     1     2     2     0     0     0     0     0     0     0
#      5     3     3     2     2     0     0     0     0     0     0     0
#      5     4     5     2     2     0     0     0     0     0     0     0
#      5     7     7     2     2     0     0     0     0     0     0     0
#      5     9     9     2     2     0     0     0     0     0     0     0
#      5    10    11     2     2     0     0     0     0     0     0     0
#      5    37    13     3     2     0     0     0     0     0     0     0
#      5    39    14     3     2     0     0     0     0     0     0     0
#      5    40    15     3     2     0     0     0     0     0     0     0
#      5    43    16     3     2     0     0     0     0     0     0     0
#      5    45    17     3     2     0     0     0     0     0     0     0
#      5    46    18     3     2     0     0     0     0     0     0     0
     #
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
  4     1    0.060233   
  4     2    0.132995   
  4     3    0.102527   
  4     4    0.064313   
  4     5    1   
  4     7    0.099806   
  4     8    0.082861   
  4     9    0.292696   
  5     1    0.243764   
  5     2    0.239208   
  5     3    0.293947   
  5     7    0.424447   
 -9999   1    0  # terminator
#
15 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 0 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_CPUE/survey:_1
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_CPUE/survey:_2
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_CPUE/survey:_3
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_4
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_5
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_6
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_7
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_CPUE/survey:_8
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_CPUE/survey:_9
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_lencomp:_1
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_lencomp:_2
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_lencomp:_3
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_lencomp:_4
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_lencomp:_5
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_lencomp:_6
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_lencomp:_7
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_lencomp:_8
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_lencomp:_9
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_agecomp:_1
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_agecomp:_2
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_agecomp:_3
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_agecomp:_4
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_agecomp:_5
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_agecomp:_6
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_agecomp:_7
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_agecomp:_8
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_agecomp:_9
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_init_equ_catch1
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_init_equ_catch2
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_init_equ_catch3
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_init_equ_catch4
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_init_equ_catch5
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_init_equ_catch6
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_init_equ_catch7
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_init_equ_catch8
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_init_equ_catch9
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_recruitments
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_parameter-priors
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_parameter-dev-vectors
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_crashPenLambda
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 # F_ballpark_lambda
0 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 # 0 2 0 0 # Selectivity: (1) fleet, (2) 1=len/2=age/3=both, (3) year, (4) N selex bins
 # 0 0 # Growth: (1) growth pattern, (2) growth ages
 # 0 0 0 # Numbers-at-age: (1) area(-1 for all), (2) year, (3) N ages
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
999

