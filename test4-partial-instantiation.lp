ooasp_instantiation("v1", "emp1").
ooasp_isa("emp1", "Employee", "john").
ooasp_attribute_value("emp1", "age", "john", 65).  % John's age is set above the maximum value


% In this test case, we're defining a configuration model where the "Employee" class has an attribute "age" with a maximum value of 60. However, in the partial instantiation, we're setting John's age to 65, which violates the maximum value constraint. 