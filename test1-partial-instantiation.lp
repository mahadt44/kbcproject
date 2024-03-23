% Partial instantiation
ooasp_instantiation("v1", "inst1").
ooasp_isa("inst1", "ClassA", "object1").
ooasp_isa("inst1", "ClassB", "object2").
ooasp_isa("inst1", "ClassB", "object3").
ooasp_associated("inst1", "association", "object1", "object2").
ooasp_associated("inst1", "association", "object1", "object3").
