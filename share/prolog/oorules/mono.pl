user:term_expansion((:- table Pred as incremental),
                    (:- table Pred as (monotonic,lazy))) :-
    incremental(Pred).

log :-
    protocol('lazy.log'),
    run,
    noprotocol,
    shell('diff incr.log lazy.log').

snap :-
    call_cleanup(
        snapshot(log),
        (   abolish_all_tables,
            set_flag(numfacts, 0),
            set_flag(guesses, 0),
            set_flag(reasonForwardSteps, 0)
        )).

try(PI) :-
    untable(PI),
    (table PI as (monotonic,lazy)),
    (   snap
    ->  true
    ;   untable(PI),
        (table PI as incremental),
        fail
    ).

tryall :-
    forall(incremental(PI),
           (   try(PI)
           ->  assertz(monotonic(PI))
           ;   true
           )).

% Stuff that was incremental
incremental(reasonEmbeddedObject_B/3).
incremental(reasonClassSizeLTE_D/2).
incremental(reasonNOTRealDestructor_A/1).
incremental(reasonMergeClasses_J/2).
incremental(reasonNOTRealDestructor_B/1).
incremental(reasonEmbeddedObject_A/3).
incremental(reasonEmbeddedObject/3).
incremental(reasonMergeClasses_H/2).
incremental(reasonRealDestructor/1).
incremental(reasonObjectInObject_D/3).
incremental(reasonMergeClasses_E/2).
incremental(reasonMergeClasses_G/2).
incremental(reasonObjectInObject_E/3).
incremental(reasonClassRelationship/2).
incremental(reasonNOTRealDestructor/1).
incremental(reasonNOTConstructor_G/1).
incremental(reasonDerivedClass_A/3).
incremental(reasonDerivedClass_B/3).
incremental(reasonNOTConstructor_H/1).
incremental(reasonNOTMergeClasses_G/2).
incremental(reasonDerivedClass/3).
incremental(reasonNOTMergeClasses_C/2).
incremental(reasonNOTMergeClasses_F/2).
incremental(reasonNOTMergeClasses_A/2).
incremental(reasonNOTConstructor_E/1).
incremental(reasonNOTEmbeddedObject/3).
incremental(reasonNOTConstructor_F/1).
incremental(reasonEmbeddedObject_C/3).
incremental(reasonEmbeddedObject_D/3).
incremental(reasonRTTIInformation/3).
incremental(reasonNOTMergeClasses/2).
incremental(reasonMethod_B/1).
incremental(reasonClassSizeGTE_B/2).
incremental(reasonNOTDeletingDestructor/1).
incremental(reasonNOTDeletingDestructor_A/1).
incremental(reasonClassSizeGTE_C/2).
incremental(reasonClassSizeGTE_D/2).
incremental(reasonNOTDeletingDestructor_B/1).
incremental(reasonMethod_A/1).
incremental(reasonVFTableSizeLTE/2).
incremental(reasonClassSizeGTE_E/2).
incremental(reasonMethod/1).
incremental(reasonReusedImplementation/1).
incremental(reasonVBTable/1).
incremental(reasonDeletingDestructor/1).
incremental(reasonClassSizeGTE_F/2).
incremental(reasonClassCallsMethod_F/2).
incremental(reasonNOTRealDestructor_F/1).
incremental(reasonClassSizeGTE_G/2).
incremental(reasonVirtualFunctionCall/5).
incremental(reasonMergeClasses_D/2).
incremental(reasonObjectInObject_C/3).
incremental(reasonNOTRealDestructor_G/1).
incremental(reasonClassSizeLTE/2).
incremental(reasonNOTRealDestructor_H/1).
incremental(reasonObjectInObject_B/3).
incremental(reasonMergeClasses_C/2).
incremental(reasonClassSizeLTE_A/2).
incremental(reasonObjectInObject/3).
incremental(reasonMergeClasses/2).
incremental(reasonNOTRealDestructor_C/1).
incremental(reasonNOTRealDestructor_D/1).
incremental(likelyDeletingDestructor/2).
incremental(reasonClassSizeLTE_B/2).
incremental(reasonMergeClasses_B/2).
incremental(reasonObjectInObject_A/3).
incremental(reasonVBTableWrite/4).
incremental(reasonVBTableEntry/3).
incremental(reasonMergeVFTables/2).
incremental(reasonClassSizeLTE_C/2).
incremental(reasonNOTRealDestructor_E/1).
incremental(validFuncOffset/4).
incremental(insanityConstructorAndRealDestructor/0).
incremental(reasonClassHasUnknownBase_D/1).
incremental(reasonMethod_M/1).
incremental(insanityConstructorAndNotConstructor/0).
incremental(reasonSharedImplementation/2).
incremental(reasonClassHasUnknownBase_E/1).
incremental(reasonClassHasUnknownBase_C/1).
incremental(reasonClassHasUnknownBase_B/1).
incremental(certainMemberOnClass/3).
incremental(insanityBaseVFTableLarger/0).
incremental(reasonMethod_L/1).
incremental(insanityMemberPastEndOfObject/0).
incremental(validMethodMemberAccess/4).
incremental(reasonClassHasUnknownBase_A/1).
incremental(reasonMethod_K/1).
incremental(insanityObjectCycle/0).
incremental(insanityEmbeddedObjectLarger/0).
incremental(reasonMethod_J/1).
incremental(insanityVFTableSizeInvalid/0).
incremental(reasonMethod_I/1).
incremental(insanityInheritanceAfterNonInheritance/0).
incremental(reasonVFTable/1).
incremental(reasonNOTDeletingDestructor_F/1).
incremental(reasonMethod_H/1).
incremental(reasonClassSizeGTE_A/2).
incremental(reasonMethod_G/1).
incremental(reasonVFTableOverwrite/4).
incremental(reasonClassCallsMethod_C/2).
incremental(reasonClassCallsMethod_E/2).
incremental(reasonClassSizeGTE/2).
incremental(sanityChecks/0).
incremental(insanityEmbeddedAndNot/0).
incremental(reasonNOTDeletingDestructor_G/1).
incremental(reasonMethod_F/1).
incremental(reasonVFTableWrite/4).
incremental(reasonClassCallsMethod_D/2).
incremental(reasonMethod_E/1).
incremental(insanityContradictoryNOTConstructor/0).
incremental(reasonClassCallsMethod_A/2).
incremental(certainMemberNOTOnExactClass/3).
incremental(insanityContradictoryMerges/0).
incremental(reasonNOTDeletingDestructor_C/1).
incremental(reasonClassCallsMethod/2).
incremental(certainMemberOnExactClass/3).
incremental(insanityTwoRealDestructorsOnClass/0).
incremental(reasonNOTDeletingDestructor_E/1).
incremental(reasonMethod_D/1).
incremental(reasonClassCallsMethod_B/2).
incremental(reasonNOTDeletingDestructor_D/1).
incremental(reasonMethod_C/1).
incremental(insanityConstructorAndDeletingDestructor/0).
incremental(reasonNOTConstructor_D/1).
incremental(reasonNOTVFTableEntry_D/3).
incremental(reasonNOTMergeClasses_O/2).
incremental(reasonNOTConstructor_C/1).
incremental(reasonNOTVFTableEntry_C/3).
incremental(reasonNOTMergeClasses_L/2).
incremental(reasonDerivedClass_F/3).
incremental(reasonNOTVFTableEntry_E/3).
incremental(reasonDerivedClass_E/3).
incremental(reasonNOTConstructor_B/1).
incremental(reasonNOTMergeClasses_K/2).
incremental(reasonNOTConstructor_A/1).
incremental(reasonVFTableBelongsToClass/5).
incremental(reasonNOTMergeClasses_J/2).
incremental(reasonDerivedClass_D/3).
incremental(reasonDerivedClass_C/3).
incremental(reasonNOTConstructor/1).
incremental(reasonVFTableSizeGTE/2).
incremental(reasonNOTMergeClasses_I/2).
incremental(reasonNOTMergeClasses_E/2).
incremental(insanityClassSizeInvalid/0).
incremental(rTTITDA2Class/2).
incremental(insanityInheritanceLoop/0).
incremental(reasonConstructor/1).
incremental(reasonNOTVFTableEntry/3).
incremental(insanityConstructorInVFTable/0).
incremental(guessMethodE/1).
incremental(reasonVFTableEntry/3).
incremental(insanityVFTableOnTwoClasses/0).
incremental(reasonNOTMergeClasses_R/2).
incremental(reasonMethod_P/1).
incremental(reasonClassHasUnknownBase/1).
incremental(reasonNOTVFTableEntry_A/3).
incremental(guessMethodD/1).
incremental(reasonMethod_O/1).
incremental(reasonNOTVFTableEntry_B/3).
incremental(reasonMethod_N/1).
incremental(reasonDerivedClassRelationship/2).
incremental(reasonNOTMergeClasses_P/2).
incremental(reasonNOTMergeClasses_M/2).
incremental(reasonNOTMergeClasses_N/2).
incremental(reasonClassHasNoBase/1).
incremental(reasonNOTDerivedClass/3).

% These can be monotonic

monotonic(reasonEmbeddedObject_B/3).
monotonic(reasonNOTRealDestructor_A/1).
monotonic(reasonMergeClasses_J/2).
monotonic(reasonNOTRealDestructor_B/1).
monotonic(reasonEmbeddedObject_A/3).
monotonic(reasonEmbeddedObject/3).
monotonic(reasonMergeClasses_H/2).
monotonic(reasonRealDestructor/1).
monotonic(reasonObjectInObject_D/3).
monotonic(reasonMergeClasses_E/2).
monotonic(reasonMergeClasses_G/2).
monotonic(reasonNOTRealDestructor/1).
monotonic(reasonDerivedClass_A/3).
monotonic(reasonNOTConstructor_H/1).
monotonic(reasonNOTMergeClasses_G/2).
monotonic(reasonDerivedClass/3).
monotonic(reasonNOTMergeClasses_F/2).
monotonic(reasonNOTMergeClasses_E/2).
monotonic(reasonNOTMergeClasses/2).
monotonic(reasonMethod_B/1).
monotonic(reasonClassSizeGTE_C/2).
monotonic(reasonMethod_A/1).
monotonic(reasonReusedImplementation/1).
monotonic(reasonVBTable/1).
monotonic(reasonDeletingDestructor/1).
monotonic(reasonClassSizeGTE_F/2).
monotonic(reasonClassSizeGTE_G/2).
monotonic(reasonVirtualFunctionCall/5).

monotonic(insanityObjectCycle/0).
monotonic(insanityVFTableSizeInvalid/0).
monotonic(likelyDeletingDestructor/2).
%monotonic(reasonClassSizeLTE_A/2).
%monotonic(reasonClassSizeLTE_B/2).
%monotonic(reasonMergeClasses/2).
%monotonic(reasonMergeClasses_C/2).
%monotonic(reasonMergeClasses_D/2).
monotonic(reasonMethod_J/1).
%monotonic(reasonNOTRealDestructor_C/1).
%monotonic(reasonNOTRealDestructor_D/1).
monotonic(reasonObjectInObject_A/3).
monotonic(reasonObjectInObject_B/3).
monotonic(reasonObjectInObject_C/3).
monotonic(validFuncOffset/4).

monotonic(insanityInheritanceAfterNonInheritance/0).
monotonic(reasonClassSizeGTE/2).
monotonic(reasonVFTableWrite/4).
monotonic(reasonMethod_E/1).
monotonic(insanityContradictoryNOTConstructor/0).
monotonic(reasonNOTDeletingDestructor_C/1).
monotonic(reasonNOTDeletingDestructor_E/1).
monotonic(reasonNOTDeletingDestructor_D/1).
monotonic(reasonNOTVFTableEntry_D/3).
monotonic(reasonDerivedClass_F/3).
monotonic(reasonNOTVFTableEntry_E/3).
monotonic(reasonVFTableBelongsToClass/5).
monotonic(reasonVFTableSizeGTE/2).
monotonic(reasonNOTVFTableEntry/3).
monotonic(reasonClassHasNoBase/1).

%% Local Variables:
%% mode: prolog
%% End:
