limit(40).

% Define class predicate
ooasp_class(Model, Class) :- ooasp_class(Model, Class, _).

% Define subclass predicate
ooasp_subclass(Model, SubClass, SuperClass) :- ooasp_subclass(Model, SubClass, SuperClass, _).

% Defne association predicate
ooasp_assoc(Model, Assoc, Class1, MinC1, MaxC1, Class2, MinC2, MaxC2) :-
    ooasp_assoc(Model, Assoc, Class1, MinC1, MaxC1, Class2, MinC2, MaxC2, _).

% new components
{ ooasp_isa(Instance, Class, Object) : Object = 1..N } N :- ooasp_instantiation(Model, Instance), ooasp_class(Model, Class), not ooasp_subclass(Model, _, Class), limit(N).

% associations
{ ooasp_associated(Instance, Assoc, ID1, ID2) : ooasp_isa(Instance, SC2, ID2) } :- 
ooasp_instantiation(Model, Instance), ooasp_assoc(Model, Assoc, Class1, MinC1, MaxC1, Class2, MinC2, MaxC2), ooasp_isa(Instance, SC1, ID1), ooasp_subclass(Model, SC1, Class1), ooasp_subclass(Model, SC2, Class2).
{ ooasp_associated(Instance, Assoc, ID1, ID2) : ooasp_isa(Instance, Class2, ID2) } :-
 ooasp_instantiation(Model, Instance), ooasp_assoc(Model, Assoc, Class1, MinC1, MaxC1, Class2, MinC2, MaxC2), ooasp_isa(Instance, SC1, ID1), ooasp_subclass(Model, SC1, Class1).
{ ooasp_associated(Instance, Assoc, ID1, ID2) : ooasp_isa(Instance, SC2, ID2) } :- 
ooasp_instantiation(Model, Instance), ooasp_assoc(Model, Assoc, Class1, MinC1, MaxC1, Class2, MinC2, MaxC2), ooasp_isa(Instance, Class1, ID1), ooasp_subclass(Model, SC2, Class2).
{ ooasp_associated(Instance, Assoc, ID1, ID2) : ooasp_isa(Instance, Class2, ID2) } :- 
ooasp_instantiation(Model, Instance), ooasp_assoc(Model, Assoc, Class1, MinC1, MaxC1, Class2, MinC2, MaxC2), ooasp_isa(Instance, Class1, ID1).


% ensure generated ids are unique for each and check associations
:- ooasp_isa(Instance, Class1, ID), ooasp_isa(Instance, Class2, ID), Class1 != Class2.
:- ooasp_isa(Instance, Class2, ID2), not ooasp_associated(Instance, Assoc, _, ID2), ooasp_assoc(Model, Assoc, Class1, MinC1, MaxC1, Class2, MinC2, MaxC2), MinC1 != 0.
:- ooasp_isa(Instance, SC1, ID1), not ooasp_associated(Instance, Assoc, ID1, _), ooasp_assoc(Model, Assoc, Class1, MinC1, MaxC1, Class2, MinC2, MaxC2), ooasp_subclass(Model, SC1, Class1), MinC2 != 0.
:- ooasp_isa(Instance, Class1, ID1), not ooasp_associated(Instance, Assoc, ID1, _), ooasp_assoc(Model, Assoc, Class1, MinC1, MaxC1, Class2, MinC2, MaxC2), MinC2 != 0.
:- ooasp_isa(Instance, SC2, ID2), not ooasp_associated(Instance, Assoc, _, ID2), ooasp_assoc(Model, Assoc, Class1, MinC1, MaxC1, Class2, MinC2, MaxC2), ooasp_subclass(Model, SC2, Class2), MinC1 != 0.:- ooasp_assoc(Model, Assoc, Class1, MinC1, MaxC1, Class2, MinC2, MaxC2), ooasp_isa(Instance, SC1, ID1), ooasp_isa(Instance, SC2, ID2), ooasp_subclass(Model, SC1, Class1), ooasp_subclass(Model, SC2, Class2), not ooasp_associated(Instance, Assoc, _, ID2).

% Define attribute predicate
ooasp_attribute(Model, Class, Attribute, Type) :- ooasp_attribute(Model, Class, Attribute, Type, _).
ooasp_attribute_minInclusive(Model, Class, Attribute, MinValue) :- ooasp_attribute_minInclusive(Model, Class, Attribute, MinValue, _).
ooasp_attribute_maxInclusive(Model, Class, Attribute, MaxValue) :- ooasp_attribute_maxInclusive(Model, Class, Attribute, MaxValue, _).
ooasp_attribute_enum(Model, Class, Attribute, Value) :- ooasp_attribute_enum(Model, Class, Attribute, Value, _).

% Define instantiation predicate
ooasp_instantiation(Model, Instance) :- ooasp_instantiation(Model, Instance, _).

% Define isa predicate
ooasp_isa(Instance, Class, Object) :- ooasp_isa(Instance, Class, Object, _).

% Define associated predicate
ooasp_associated(Instance, Assoc, Object1, Object2) :- ooasp_associated(Instance, Assoc, Object1, Object2, _).


% Define count_associated_objects/5 to count associated objects
count_associated_objects(I, A, O1, C2, Count) :-
    ooasp_associated(I, A, O1, _),   
    ooasp_isa(I, C2, _),              
    Count = #count {X : ooasp_associated(I, A, O1, X), ooasp_isa(I, C2, X)}.

% Integrity constraint to check minimum cardinality of associations
:- ooasp_associated(I, A, O1, O2),
   ooasp_isa(I, C2, O2),
   ooasp_assoc(M, A, C1, C1MIN, _, _, C2MIN, _),
   ooasp_instantiation(M, I),
   ooasp_isa(I, C1, O1),
   count_associated_objects(I, A, O1, C2, Count),
   C2MIN > 0,
   Count < C2MIN.

% Integrity constraint to check maximum cardinality of associations
:- ooasp_associated(I, A, O1, O2),
   ooasp_isa(I, C2, O2),
   ooasp_assoc(M, A, C1, _, _, _, _, C2MAX),
   ooasp_instantiation(M, I),
   ooasp_isa(I, C1, O1),
   count_associated_objects(I, A, O1, C2, Count),
   Count > C2MAX.

% Integrity constraint to check if instantiation is empty
:- not ooasp_instantiation(_, _).

% Integrity constraint to check attributes
:- ooasp_attribute(M, C, AT, Type), ooasp_instantiation(M, I), ooasp_isa(I, C, O), not ooasp_attribute_value(I, AT, O, _).

% Integrity constraint to check minimum value of integer attributes
:- ooasp_attribute_minInclusive(M, C, AT, MinV), ooasp_instantiation(M, I), ooasp_isa(I, C, O), ooasp_attribute_value(I, AT, O, Val), Val < MinV.

% Integrity constraint to check maximum value of integer attributes
:- ooasp_attribute_maxInclusive(M, C, AT, MaxV), ooasp_instantiation(M, I), ooasp_isa(I, C, O), ooasp_attribute_value(I, AT, O, Val), Val > MaxV.

% Define attribute value predicate
ooasp_attribute_value(Instance, Attribute, Object, Value) :- ooasp_attribute_value(Instance, Attribute, Object, Value, _).


% Minimize the number of instances
#minimize {1, ID : ooasp_isa(Instance,Class,ID)}.

#show ooasp_isa/3.
#show ooasp_instantiation/2.
#show ooasp_associated/4.
