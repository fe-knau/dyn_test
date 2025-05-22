## Automated tests for the [did_multiplegt_dyn](https://github.com/chaisemartinPackages/did_multiplegt_dyn) package

This repository consists of two do files:

### test_dyn
In this file you specify which version of did_multiplegt_dyn you want to test. Then, after setting all relevant parameters in the preamble, you can run the do file and it will produce a dta file soting all the relevant outputs of the command in a variety of different specificaions.
At the moment, it allows to test the baseline command and all options that do not produce any additional output individually. Adding combinations of options is straight forward when following the structure how the relevant resulting matrix is constructed, one just needs to
adjust the desired options of the command and adapt a corresponding name of the specification in the matrix.\
The idea is to run this do file with the two versions of did_multiplegt_dyn one is interested in comparing, producing two dta files of interest that should be properly named, and that then can be compared by the following do file.

### compairison_dyn
Once the two dta files using the versions of did_multiplegt_dyn are created by the test_dyn do file, one can proceed running the compairison_dyn file. There, one just needs to specify the two version names as they were used in the test_dyn do file, then this do file
automatically shows any discrepancies in the results and for which outcomes and with which option specifications they arise. For a broader overview, just browse the resulting data that shows all the compard quantities and tags any potential differences.\ 
(Note: when adapting any new specification as described above, be aware that the "test" variable that is generated at the beginning of 
this do file has to be augmented by the corresponding specification name)
