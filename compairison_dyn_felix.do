***** This is the complementary do file for the dyn_test to compare different versions *****

						*** Version: 22.04.25 ***


							*** Preamble ***
********************************************************************************
// Set the directory to load the datasets and to store the resulting log files

// Felix
* save path
global save_path="C:\Users\Felix\Desktop\DID_programs\did_multiplegt_dyn\test_dyn\log"

// Diego
* save path


// Romain
* save path


// Clément
* save path


// Define old and new dataset names 
local old = "pvalue_test_old"
local new = "pvalue_test_new"

// Describe the Versions and changes we are comparing -> Change name (in the path) for new test!

file open changes using "$save_path\pvalue_test.txt", write
file write changes "Test if the inclusion of the p-values on the joint nullity of the effects plus the one from the effects_equal option worked."
file close changes

********************************************************************************

qui{
*** Load the old dataset to test agianst
use "$save_path\datasets\data_`old'.dta", clear

*** Merge with the new dataset 
merge 1:1 _n using "$save_path/datasets/data_`new'.dta"

*** Generate a group variable to directly show which options produced a missmatch
gen test = (Effect == "Baseline" | Effect == "Placebos" | Effect == "Normalized" | Effect == "Controls" | Effect == "Trends_Nonparam" | Effect == "" | Effect == "" | Effect == "" | Effect == "" | Effect == "Trends_Lin" | Effect == "Continuous" | Effect == "Weight" | Effect == "Cluster" | Effect == "Same_Switchers" | Effect == "Same_SwitcherS_Placebo" | Effect == "Switchers_In" | Effect == "Switchers_Out" | Effect == "Only_Never_Switchers" | Effect == "CI_Level_90" | Effect == "CI_Level_99" | Effect == "Less_Conservative_SE" | Effect == "Bootstrap" | Effect == "Dont_Drop_Larger_Lower" | Effect == "Effects_Equal")

gen group=0
local N=_N
forvalues i=1/`N'{
	replace group=group[_n-1] if (_n==`i' & _n>1)
	replace group=group+1 if _n==`i' & test[`i']==1
}

bys group: gen Option=Effect[1]
drop test

*** Variable distinguishing estimates from variances 
bys group: gen n_group_int=_n-1 if Effect=="N_effect_1"
bys group: egen n_group=mean(n_group_int)
replace n_group=(n_group-1)/2
bys group: gen Type_int=(_n<=n_group+1) if _n!=1
gen Type="Point Estimate" if Type_int==1
bys group: replace Type="Variance" if Type_int==0 & _n<=2*n_group+1


order group Option Type Effect



***** Test if any effects/variances differ between the two versions

*** Tag Observations where the results differ 
gen tag_diff = (results_`old'!= results_`new')

}

*** Display the options in which we have a discrepancy
tab Option Type if tag_diff==1 & Type!=""
tab Option Effect if tag_diff==1 & Type==""

br if tag_diff==1

























