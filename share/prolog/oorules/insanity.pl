% Copyright 2017-2020 Carnegie Mellon University.
% ============================================================================================
% Sanity checking rules
% ============================================================================================

% A virtual function table may not be assigned to two classes.
% PAPER: Sanity-VFTables
:- table insanityVFTableOnTwoClasses/1 as incremental.
insanityVFTableOnTwoClasses(Out) :-
    % There's some confusion about the object offset.  See the comments in rules.pl, and be
    % sure to keep this constraint in sync with the rule that merges classes.
    factVFTableWrite(_Insn1, Method1, ObjectOffset, VFTable),
    factVFTableWrite(_Insn2, Method2, ObjectOffset, VFTable),
    iso_dif(Method1, Method2),
    % I'm unsure why these are here...  I think to prevent premature triggering of this rule.
    % With the class-based rewrite of ClassHasNoBase, this entire rule may need rethinking.
    find(Method1, Class1),
    factClassHasNoBase(Class1),
    find(Method2, Class2),
    factClassHasNoBase(Class2),
    % Now there's yet another exception.  Inlined vftable writes from the base and derived
    % class in the same method.  Perhaps this sanity check rule isn't really what we want...
    not((possibleVFTableOverwrite(_, _, Method1, _, _, _);
         possibleVFTableOverwrite(_, _, Method2, _, _, _))),
    % If they're actually two constructors for the same class, that's ok.
    iso_dif(Class1, Class2),

    Out = (
        logwarnln(true, 'insanityVFTableOnTwoClasses failed: VFTable=~Q Method1=~Q Method2=~Q', [VFTable, Method1, Method2])
    ).

% A constructor may not be virtual.
% PAPER: Sanity-VirtualConstructor
:- table insanityConstructorInVFTable/1 as incremental.
insanityConstructorInVFTable(Out) :-
    factVFTableEntry(VFTable, Offset, Entry),
    dethunk(Entry, Constructor),
    factConstructor(Constructor),

    Out = (
        logwarnln(true, 'A constructor may not be virtual: VFTable=~Q Offset=~Q Ctor=~Q', [VFTable, Offset, Constructor])
    ).

% A class may not be derived from itself (even with intermediate classes).
% PAPER: Sanity-InheritanceLoop
:- table insanityInheritanceLoop/1 as incremental.
insanityInheritanceLoop(Out) :-
    reasonDerivedClassRelationship(DerivedClass, BaseClass),
    reasonDerivedClassRelationship(BaseClass, DerivedClass),
    is_current(BaseClass),
    is_current(DerivedClass),

    Out = (
        logwarnln(true, 'A class may not be derived from itself: Class1=~Q Class2=~Q', [BaseClass, DerivedClass])
    ).

% Classes may not have an invalid size.
% Perhaps this rule replaces all other size rules?
% PAPER: NA.  Handled by constraint system.
:- table insanityClassSizeInvalid/1 as incremental.
insanityClassSizeInvalid(Out) :-
    factClassSizeLTE(Class, LTESize),
    factClassSizeGTE(Class, GTESize),
    LTESize < GTESize,

    Out = (
        logwarnln(true, 'insanityClassSizeInvalid failed: Class=~Q LTESize=~Q GTESize=~Q', [Class, LTESize, GTESize])
    ).

% Roughly speaking, inheritance can only occur in an object when it is at offset zero, or there
% are inhertance objects that preceed it in the object layout.  It turns out that this rule was
% not true in cases of virtual inheritance, which can place ordinary members between the
% immediate base classes and the virtual base class, so this sanity check needed to be disabled
% again.  I've left the check in this file because the idea is still a good one, and the check
% probably just needs more refinement for the virtual inheritance case to be correct.
:- table insanityInheritanceAfterNonInheritance/1 as incremental.
insanityInheritanceAfterNonInheritance(Out) :-
    factDerivedClass(DerivedClass, BaseClass, Offset),
    not(
        (
            Offset = 0;
            factDerivedClass(DerivedClass, _LowerBaseClass, LowerOffset),
            LowerOffset < Offset
        )
    ),

    Out = (
        logwarnln(true, 'insanityInheritanceAfterInheritance failed: DerivedClass=~Q BaseClass=~Q Offset=~Q', [DerivedClass, BaseClass, Offset])
    ).

% VFTables may not have an invalid size.
% Perhaps this rule replaces all other size rules?
% PAPER: NA.  Handled by constraint system.
:- table insanityVFTableSizeInvalid/1 as incremental.
insanityVFTableSizeInvalid(Out) :-
    factVFTable(VFTable),
    factVFTableSizeLTE(VFTable, LTESize),
    factVFTableSizeGTE(VFTable, GTESize),
    LTESize < GTESize,

    Out = (
        logwarnln(true, 'insanityVFTableSizeInvalid failed: VFTable=~Q LTESize=~Q GTESize=~Q', [VFTable, LTESize, GTESize])
    ).

% The size of an embdded class may not exceed the size of the class it's in.
% PAPER: NA.  Handled by constraint system.
:- table insanityEmbeddedObjectLarger/1 as incremental.
insanityEmbeddedObjectLarger(Out) :-
    factEmbeddedObject(OuterClass, InnerClass, Offset),
    factClassSizeLTE(OuterClass, OuterSize),
    factClassSizeGTE(InnerClass, InnerSize),
    ComputedSize is Offset + InnerSize,
    OuterSize < ComputedSize,

    Out = (
        logwarnln(true, 'insanityEmbeddedObjectLarger failed: O_Class=~Q O_Offset=~Q O_Size=~Q I_Class=~Q I_Size=~Q', [OuterClass, Offset, OuterSize, InnerClass, InnerSize])
    ).

:- table insanityObjectCycle/1 as incremental.
insanityObjectCycle(Out) :-
    reasonClassRelationship(Class1, Class2),
    reasonClassRelationship(Class2, Class1),

    Out = (
        logwarnln(true, 'insanityObjectCycle failed: Class1=~Q Class2=~Q', [Class1, Class2])
    ).

% A member may not extend past the end of the object.
% PAPER: XXX Need to add member logic
:- table insanityMemberPastEndOfObject/1 as incremental.
insanityMemberPastEndOfObject(Out) :-
    certainMemberOnClass(Class, Offset, Size),
    ComputedSize is Offset + Size,
    factClassSizeLTE(Class, ObjectSize),
    ComputedSize > ObjectSize,

    Out = (
        logwarnln(true, 'insanityMemberPastEndObject failed: Class=~Q Offset=~Q Size=~Q ObjectSize=~Q', [Class, Offset, Size, ObjectSize])
    ).

% The size of the virtual function table on a derived class may not be less than the size of
% the virtual function table on the base class.
% PAPER: Size-2
% XXX: Why isn't this a regular reasoning rule?
:- table insanityBaseVFTableLarger/1 as incremental.
insanityBaseVFTableLarger(Out) :-
    factVFTableWrite(_Insn1, DerivedConstructor, DerivedVFTable, ObjectOffset),
    factVFTableWrite(_Insn2, BaseConstructor, BaseVFTable, 0),
    find(DerivedConstructor, DerivedClass),
    find(BaseConstructor, BaseClass),
    factDerivedClass(DerivedClass, BaseClass, ObjectOffset),
    factVFTableSizeLTE(DerivedVFTable, DerivedSize),
    factVFTableSizeGTE(BaseVFTable, BaseSize),
    DerivedSize < BaseSize,

    Out = (
        logwarnln(true, 'insanityBaseVFTableLarger failed: Derived{Class,VFTable,Size}=~Q,~Q,~Q Base{Class,VFTable,Size}=~Q,~Q,~Q',
                  [DerivedClass, DerivedVFTable, DerivedSize, BaseClass, BaseVFTable, BaseSize])
    ).

% A method may not be both a constructor and not a constructor.
:- table insanityConstructorAndNotConstructor/1 as incremental.
insanityConstructorAndNotConstructor(Out) :-
    factConstructor(Method),
    factNOTConstructor(Method),

    Out = (
        logwarnln(true, 'A method may not be a constructor and not a constructor: Method=~Q', [Method])
    ).

% A method may not be both a constructor and a real destructor.
% PAPER: Sanity-DoubleDuty
:- table insanityConstructorAndRealDestructor/1 as incremental.
insanityConstructorAndRealDestructor(Out) :-
    factConstructor(Method),
    factRealDestructor(Method),

    Out = (
        logwarnln(true, 'A method may not be a constructor and real destructor: Method=~Q', [Method])
    ).


% A method may not be both a constructor and a deleting destructor.
% PAPER: Sanity-DoubleDuty
:- table insanityConstructorAndDeletingDestructor/1 as incremental.
insanityConstructorAndDeletingDestructor(Out) :-
    factConstructor(Method),
    factDeletingDestructor(Method),

    Out = (
        logwarnln(true, 'A method may not be a constructor and deleting destructor: Method=~Q', [Method])
    ).

% A class may not have two real destructors.
% PAPER: Sanity-MultipleRealDestructors
:- table insanityTwoRealDestructorsOnClass/1 as incremental.
insanityTwoRealDestructorsOnClass(Out) :-
    factRealDestructor(Destructor1),
    factRealDestructor(Destructor2),
    iso_dif(Destructor1, Destructor2),
    find(Destructor1, Class),
    find(Destructor2, Class),

    Out = (
        logwarnln(true, 'A class may not have more than one real destructor: Class=~Q Dtor1=~Q Dtor2=~Q', [Class, Destructor1, Destructor2])
    ).

% A method cannot be both merged and not merged into a class.
:- table insanityContradictoryMerges/1 as incremental.
insanityContradictoryMerges(Out) :-
    reasonMergeClasses(Method1, Method2),
    dynFactNOTMergeClasses(Method1, Method2),

    Out = (
        logwarnln(true, 'Contradictory information about merging classes: Method1=~Q Method2=~Q', [Method1, Method2])
        %(reasonMergeClasses(Method1, Method2) -> true; break)

    ).

:- table insanityContradictoryNOTConstructor/1 as incremental.
insanityContradictoryNOTConstructor(Out) :-
    reasonNOTConstructor(M),
    factConstructor(M),

    Out = (
        logwarnln(true, 'Contradictory information about constructor: factConstructor(~Q) but reasonNOTConstructor(~Q)', [M, M]),
        (M=0x4284fc -> break; true)
        %(reasonNOTConstructor(M) -> true; break)

    ).


insanityContradictoryNOTConstructor(Out) :-
    reasonConstructor(M),
    factNOTConstructor(M),

    Out = (
        logwarnln(true, 'Contradictory information about constructor: factNOTConstructor(~Q) but reasonConstructor(~Q)', [M, M])
    ).


:- table insanityEmbeddedAndNot/1 as incremental.
insanityEmbeddedAndNot(Out) :-
    factEmbeddedObject(A, B, C),
    factNOTEmbeddedObject(A, B, C),

    Out = (
        logwarnln(true, 'Contradictory information about embedded object: ~Q',
                  factEmbeddedObject(A, B, C))
    ).

:- table sanityChecks/1 as incremental.
sanityChecks(Out) :-
    insanityEmbeddedAndNot(Out);
    insanityConstructorAndNotConstructor(Out);
    insanityConstructorAndRealDestructor(Out);
    insanityConstructorInVFTable(Out);
    insanityClassSizeInvalid(Out);
    insanityVFTableSizeInvalid(Out);
    insanityEmbeddedObjectLarger(Out);
    insanityObjectCycle(Out);
    insanityMemberPastEndOfObject(Out);
    insanityBaseVFTableLarger(Out);
    insanityConstructorAndDeletingDestructor(Out);
    insanityInheritanceLoop(Out);
    insanityContradictoryMerges(Out);
    insanityContradictoryNOTConstructor(Out);
    insanityTwoRealDestructorsOnClass(Out).

sanityChecks :-
    sanityChecks(Out)
    ->
        logwarnln('Consistency checks failed.'),
        call(Out),
        fail
    ;
    true.

/* Local Variables:   */
/* mode: prolog       */
/* fill-column:    95 */
/* comment-column: 0  */
/* End:               */
