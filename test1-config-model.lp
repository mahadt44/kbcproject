% Classes
ooasp_class("v1", "ClassA").
ooasp_class("v1", "ClassB").

% Associations
ooasp_assoc("v1", "association", "ClassA", 0, 1, "ClassB", 1, 1).

%maximum 1 allowed, whereas in partial 3 associations were created 
