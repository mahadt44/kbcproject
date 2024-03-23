ooasp_instantiation("v1", "emp1").
ooasp_isa("emp1", "Employee", "john").

%ooasp_attribute_value("emp1", "salary", "john", 50000).

% we have a configuration model defining an "Employee" class with an attribute "salary". However, in the partial instantiation, we are not providing a value for the "salary" attribute. 
% According to the integrity constraint, every instantiated object of class "Employee" must have a value assigned to the "salary" attribute. 