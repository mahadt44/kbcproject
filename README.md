# kbcproject
Term project code for Knowledge Based Configuration 

The ooasp.lp file contains the encoding for instantiation and integrity constraints.
The initial config-model.lp file has the encoding of the modules configuration model in Listing 1 as a test case
The initial partial-instantiation.lp file contains the partial instantiation given subsection 4.2 

Running the config-model.lp partial-instantiation.lp ooasp.lp -0 command initially would give the satisfiable complete configuration for the initial test case as given in Figure 3.

Test cases:
1) test case 1: to check for maximum constraint constaraint. Kindly use the test1-config-model.lp test1-partial-instantiation.lp files. test1-config-model.lp test1-partial-instantiation.lp ooasp.lp -0
2) test case 2: to check for minimum constraint constaraint. Kindly use the test2-config-model.lp test2-partial-instantiation.lp files. test2-config-model.lp test2-partial-instantiation.lp ooasp.lp -0
3) test case 3: to check for attribute constraint. Kindly use the test3-config-model.lp test3-partial-instantiation.lp files. test3-config-model.lp test3-partial-instantiation.lp ooasp.lp -0
4) test case 4: to check for integrity constraint for maximum value of integer attributes. Kindly use the test4-config-model.lp test4-partial-instantiation.lp files. test4-config-model.lp test4-partial-instantiation.lp ooasp.lp -0
5) test case 5: to check for integrity constraint for minimum value of integer attributes. Kindly use the test5-config-model.lp test5-partial-instantiation.lp files. test5-config-model.lp test5-partial-instantiation.lp ooasp.lp -0

