* Encoding: UTF-8.

Mid/vig exercise recoded to inc value of 0 (new variable where 0 is never) so the PA is continuous

RECODE W1_Q41_EX_week (1=0) (2=1) (3=2) (4=3) (5=4) (6=5) (7=6) (8=7) INTO PA_week_cont.
VARIABLE LABELS  PA_week_cont 'PA_week_cont'.
EXECUTE.

Recoded SI into a continuous varaible where value of 6 (missing) was ommited; the W8_SI_week was already coded as 0 = never; 

DATASET ACTIVATE DataSet1.
RECODE W8_SI_week (0=0) (1=1) (2=2) (3=3) (4=4) INTO W8_SI_week_recoded.
VARIABLE LABELS  W8_SI_week_recoded 'W8_SI_week_recoded'.
EXECUTE.

Cronbah's Alpha reliability analysis for 4 items of the defeat scale 

RELIABILITY
  /VARIABLES=W1_Q68a_defeat1 W1_Q68b_defeat2 W1_Q68c_defeat3 W1_Q68d_defeat4
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL.

Cronbah's Alpha reliability analysis for 4 items of the entrapment scale 

RELIABILITY
  /VARIABLES=W1_Q69a_ENT1 W1_Q69b_ENT2 W1_Q69c_ENT3 W1_Q69d_ENT4
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL.


Correlations: distress, defeat, entrapment, PA sum and PA week (wave 1) and SI (wave 8) 
   
I will be using PA days per week cont in the further analyses.     

CORRELATIONS
  /VARIABLES=W1_DI W1_DEF_T W1_ENT_T SUM_walk_run_cycle W8_SI_week_recoded PA_week_cont
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

Univariate binomial regression (UBR)

UBR-PA output

DATASET ACTIVATE DataSet1.
LOGISTIC REGRESSION VARIABLES W8_SI_week_binary
  /METHOD=ENTER PA_week_cont 
  /SAVE=PRED PGROUP
  /CLASSPLOT
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

UBR-Stress output

LOGISTIC REGRESSION VARIABLES W8_SI_week_binary
  /METHOD=ENTER W1_DI 
  /SAVE=PRED PGROUP
  /CLASSPLOT
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

UBR - defeat output

LOGISTIC REGRESSION VARIABLES W8_SI_week_binary
  /METHOD=ENTER W1_DEF_T 
  /SAVE=PRED PGROUP
  /CLASSPLOT
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

UBR - entrapment output

LOGISTIC REGRESSION VARIABLES W8_SI_week_binary
  /METHOD=ENTER W1_ENT_T 
  /SAVE=PRED PGROUP
  /CLASSPLOT
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


Multivariate Binominal Logistic Regression (MBLR) 

LOGISTIC REGRESSION VARIABLES W8_SI_week_binary
  /METHOD=ENTER W1_DI W1_DEF_T W1_ENT_T PA_week_cont 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


Multivariate Binominal Logistic Regression (MBLR) with Block 1 (W1_S1); Block 2 (demographics) and Block 3 (IVs)
    Age reference cat is set as first

DATASET ACTIVATE DataSet1.
LOGISTIC REGRESSION VARIABLES W8_SI_week_binary
  /METHOD=ENTER W1_DLOGISTIC REGRESSION VARIABLES W8_SI_week_binary
  /METHOD=ENTER W1_SI_last_week 
  /METHOD=ENTER Age_range_3cat_new Gender_group SEG_grouping_binary 
  /METHOD=ENTER W1_DI W1_DEF_T W1_ENT_T PA_week_cont 
  /CONTRAST (W1_SI_last_week)=Indicator(1)
  /CONTRAST (Age_range_3cat_new)=Indicator(1)
  /CONTRAST (Gender_group)=Indicator(1)
  /CONTRAST (SEG_grouping_binary)=Indicator(1)
  /CLASSPLOT
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

Multivariate Binominal Logistic Regression (MBLR) with Block 1 (W1_S1); Block 2 (demographics) and Block 3 (IVs)
    Age reference cat is set as last (to complete the output)
    
LOGISTIC REGRESSION VARIABLES W8_SI_week_binary
  /METHOD=ENTER W1_SI_last_week 
  /METHOD=ENTER Age_range_3cat_new Gender_group SEG_grouping_binary 
  /METHOD=ENTER W1_DI W1_DEF_T W1_ENT_T PA_week_cont 
  /CONTRAST (W1_SI_last_week)=Indicator(1)
  /CONTRAST (Gender_group)=Indicator(1)
  /CONTRAST (SEG_grouping_binary)=Indicator(1)
  /CONTRAST (Age_range_3cat_new)=Indicator
  /CLASSPLOT
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).
I W1_DEF_T W1_ENT_T PA_week_cont 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

Multivariate Binominal Logistic Regression (MBLR) with Block 1 (W1_S1); Block 2 (demographics) and Block 3 (IVs)
    Age kept as a continuous - as to Heather's advice 

LOGISTIC REGRESSION VARIABLES W8_SI_week_binary
  /METHOD=ENTER W1_SI_last_week 
  /METHOD=ENTER Age_range_3cat_new Gender_group SEG_grouping_binary 
  /METHOD=ENTER W1_DI W1_DEF_T W1_ENT_T PA_week_cont 
  /CONTRAST (W1_SI_last_week)=Indicator(1)
  /CONTRAST (Gender_group)=Indicator(1)
  /CONTRAST (SEG_grouping_binary)=Indicator(1)
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

Moderation in Process Macro

Friedmans test for demographics 
    
AGE at W1 and W2

DATASET ACTIVATE DataSet1.
NPAR TESTS
  /FRIEDMAN=W1_Q1_age W8_q1_age
  /STATISTICS DESCRIPTIVES 
  /MISSING LISTWISE.

post hoc 

NPAR TESTS
  /WILCOXON=Age_range_3cat_new WITH W8_q1_age (PAIRED)
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS.

recoded SEG at W8 into binary varaible so I can compare it with W1 SEG that was already presented in the binary variable 

RECODE W8_v2 (1=1) (2=1) (3=2) (4=2) INTO W8_SEG_binary.
VARIABLE LABELS  W8_SEG_binary 'W8_SEG_binary'.
EXECUTE.

SEG  at W1 and W2

NPAR TESTS
  /FRIEDMAN=SEG_grouping_binary W8_SEG_binary
  /STATISTICS DESCRIPTIVES 
  /MISSING LISTWISE.

Post hoc 

NPAR TESTS
  /WILCOXON=SEG_grouping_binary WITH W8_SEG_binary (PAIRED)
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS.

GENDER at W1 and W2

RECODE W8_q4_sex (1=1) (2=2) (3=SYSMIS) INTO W8_gender.
VARIABLE LABELS  W8_gender 'W8_gender'.
EXECUTE.

NPAR TESTS
  /FRIEDMAN=W1_Q4_sex W8_gender
  /STATISTICS DESCRIPTIVES 
  /MISSING LISTWISE.

Post hoc 

NPAR TESTS
  /WILCOXON=W1_Q4_sex WITH W8_gender (PAIRED)
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS.

DESCRIPTIVES 
    
DESCRIPTIVES VARIABLES=W1_DI W1_DEF_T W1_ENT_T PA_week_cont W8_SI_week_recoded
  /STATISTICS=MEAN STDDEV MIN MAX KURTOSIS SKEWNESS.

FREQUENCIES VARIABLES=Age_range_3cat_new Gender_group SEG_grouping_binary
  /BARCHART FREQ
  /ORDER=ANALYSIS.

Moderation defeat - entrapment (PA) graph
    
DATA LIST FREE/ 
   W1_DEF_T   PA_week_   W8_ENT_T   . 
BEGIN DATA. 
     -3.903     -2.395       .593 
       .000     -2.395      3.420 
      3.903     -2.395      6.248 
     -3.903       .000       .603 
       .000       .000      3.440 
      3.903       .000      6.278 
     -3.903      2.395       .613 
       .000      2.395      3.460 
      3.903      2.395      6.308 
END DATA. 
GRAPH/SCATTERPLOT= 
 W1_DEF_T WITH     W8_ENT_T BY       PA_week_ .

paired test of difference between the demographic characteristics across the two waves of interest

NPAR TESTS
  /WILCOXON=W1_Q4_sex WITH W8_q4_sex (PAIRED)
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS.

NPAR TESTS
  /WILCOXON=SEG_grouping_binary WITH W8_SEG_binary (PAIRED)
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS.

NPAR TESTS
  /WILCOXON=W1_Q1_age WITH W8_q1_age (PAIRED)
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS.
