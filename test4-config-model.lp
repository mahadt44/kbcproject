% Define class
ooasp_class("v1", "Employee").

% Define attribute with maximum value
ooasp_attribute("v1", "Employee", "age", "integer").
ooasp_attribute_maxInclusive("v1", "Employee", "age", 60).  % Maximum age allowed is 60
