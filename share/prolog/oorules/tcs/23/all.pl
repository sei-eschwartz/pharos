:- working_directory(_, '/home/ed/Documents/pharos/share/prolog/oorules').
% Set log level if running interactively.
:- current_prolog_flag(break_level, _) -> assert(logLevel(7)); true.
:- ensure_loaded(report).
% This file attempts to gather coverage information and return it as a
% list of tuples.  Large parts of it are copied from SWIPL's
% test_cover.pl

clause_call_site_annotation(ClauseRef, NextPC, Line, Annot, Len, Entered, Exited) :-
    prolog_cover:clause_call_site(ClauseRef, PC-NextPC, Line:_LPos),
    (   '$cov_data'(call_site(ClauseRef, NextPC, _PI), Entered, Exited)
    ->  prolog_cover:counts_annotation(Entered, Exited, Annot, Len)
    ).

print_line(File-Line-(Entered-Exited)) :-
    format('~w:~w +~w-~w~n', [File, Line, Entered, Exited]).

line_annotation(File, covered, Clause, [((File-Pred-Line)-(Entered-Exited))|CallSites]) :-
    clause_property(Clause, file(File)),
    clause_property(Clause, line_count(Line)),
    clause_property(Clause, predicate(Pred)),
    '$cov_data'(clause(Clause), Entered, Exited),
    prolog_cover:counts_annotation(Entered, Exited, Annot, Len),
    findall(((File-Pred-CSLine)-(CSEntered-CSExited)),
            clause_call_site_annotation(Clause, PC, CSLine, CSAnnot, CSLen, CSEntered, CSExited),
            CallSites).

detailed_report(Uncovered, Covered, File, _Options, Out):-
    convlist(line_annotation(File, covered),   Covered,   Annot20),
    flatten(Annot20, FlatList),
    Out=FlatList.

file_coverage(File, Succeeded, Failed, UncoveredOut, CoveredOut) :-
    findall(Cl, prolog_cover:clause_source(Cl, File, _), Clauses),
    sort(Clauses, All),
    (   ord_intersect(All, Succeeded)
    ->  true
    ;   ord_intersect(All, Failed)
    ),                                  % Clauses from this file are touched
    !,
    ord_intersection(All, Failed, FailedInFile),
    ord_intersection(All, Succeeded, SucceededInFile),
    ord_subtract(All, SucceededInFile, UnCov1),
    ord_subtract(UnCov1, FailedInFile, Uncovered),

    prolog_cover:clean_set(All, All_wo_system),
    prolog_cover:clean_set(Uncovered, Uncovered_wo_system),
    prolog_cover:clean_set(FailedInFile, Failed_wo_system),

    length(All_wo_system, AC),
    length(Uncovered_wo_system, UC),
    length(Failed_wo_system, FC),

    CP is 100-100*UC/AC,
    FCP is 100*FC/AC,


    prolog_cover:summary(File, 56, SFile),
    prolog_cover:clean_set(SucceededInFile, Succeeded_wo_system),
    ord_union(Failed_wo_system, Succeeded_wo_system, Covered),
    UncoveredOut=Uncovered_wo_system, CoveredOut=Covered.

my_file_coverage(Succeeded, Failed) :-
    findall(Out,
            (source_file(File),
             once(file_coverage(File, Succeeded, Failed, Uncovered, Covered)),
             detailed_report(Uncovered, Covered, File, [], Out)),
            OutList),

    flatten(OutList, FlatOutList),

    assert(cov(FlatOutList)).

:- multifile prolog_cover:report_hook/2.
prolog_cover:report_hook(Succ, Fail) :- my_file_coverage(Succ, Fail).

get_coverage(Action, CovOut) :-
    show_coverage(Action),
    retract(cov(CovOut)).

get_coverage(Action, A, B, C, D, E) :-
    get_coverage(Action, L),
    member((((A-Borig)-C)-(D-E)), L),
    term_string(Borig, B).
% Declare new helper facts in case we don't export any.
:- dynamic factVFTableWrite/3.
:- dynamic factVBTableWrite/3.
:- dynamic possibleVFTableWriteHelper/5.
:- dynamic possibleVBTableWriteHelper/5.
:- dynamic thisPtrOffset/4.
:- dynamic groundVFTableBelongsToClass/2.
:- dynamic groundConstructor/1.
:- dynamic groundDestructor/1.
:- dynamic callBefore/4.
:- dynamic returnsSelf/1.
:- dynamic factDerivedClass/4.
:- dynamic ignorefactNOTMergeClasses/2.
:- dynamic methodMemberAccessHelper/4.
% This enables clauses in paperSoundnessProblems/1, which are clauses that cause problems in practice but are sound.
modelCompiler.
groundTruth(F) :- F.
returnsSelf(function(8)).
returnsSelf(function(5)).
returnsSelf(function(1)).
returnsSelf(function(9)).
returnsSelf(function(10)).
returnsSelf(function(0)).
returnsSelf(function(6)).
returnsSelf(function(7)).
returnsSelf(function(3)).
returnsSelf(function(2)).
returnsSelf(function(4)).
factClassCallsMethod(class(0), function(0), 0).
factClassCallsMethod(class(0), function(0), unknown).
factClassCallsMethod(class(0), function(1), 0).
factClassCallsMethod(class(0), function(1), unknown).
factClassCallsMethod(class(0), function(8), 0).
factClassCallsMethod(class(0), function(8), unknown).
factClassCallsMethod(class(0), function(0), 0).
factClassCallsMethod(class(0), function(0), unknown).
factClassCallsMethod(class(0), function(1), 0).
factClassCallsMethod(class(0), function(1), unknown).
factClassCallsMethod(class(0), function(8), 0).
factClassCallsMethod(class(0), function(8), unknown).
factClassCallsMethod(class(1), function(2), 0).
factClassCallsMethod(class(1), function(2), unknown).
factClassCallsMethod(class(1), function(3), 0).
factClassCallsMethod(class(1), function(3), unknown).
factClassCallsMethod(class(1), function(9), 0).
factClassCallsMethod(class(1), function(9), unknown).
factClassCallsMethod(class(1), function(2), 0).
factClassCallsMethod(class(1), function(2), unknown).
factClassCallsMethod(class(1), function(3), 0).
factClassCallsMethod(class(1), function(3), unknown).
factClassCallsMethod(class(1), function(9), 0).
factClassCallsMethod(class(1), function(9), unknown).
factClassCallsMethod(class(2), function(4), 0).
factClassCallsMethod(class(2), function(4), unknown).
factClassCallsMethod(class(2), function(5), 0).
factClassCallsMethod(class(2), function(5), unknown).
factClassCallsMethod(class(2), function(6), 0).
factClassCallsMethod(class(2), function(6), unknown).
factClassCallsMethod(class(2), function(10), 0).
factClassCallsMethod(class(2), function(10), unknown).
factClassCallsMethod(class(2), function(2), 0).
factClassCallsMethod(class(2), function(2), unknown).
factClassCallsMethod(class(2), function(3), 0).
factClassCallsMethod(class(2), function(3), unknown).
factClassCallsMethod(class(2), function(9), 0).
factClassCallsMethod(class(2), function(9), unknown).
factClassCallsMethod(class(2), function(0), 0x4).
factClassCallsMethod(class(2), function(0), unknown).
factClassCallsMethod(class(2), function(1), 0x4).
factClassCallsMethod(class(2), function(1), unknown).
factClassCallsMethod(class(2), function(8), 0x4).
factClassCallsMethod(class(2), function(8), unknown).
factClassCallsMethod(class(2), function(4), 0).
factClassCallsMethod(class(2), function(4), unknown).
factClassCallsMethod(class(2), function(5), 0).
factClassCallsMethod(class(2), function(5), unknown).
factClassCallsMethod(class(2), function(6), 0).
factClassCallsMethod(class(2), function(6), unknown).
factClassCallsMethod(class(2), function(10), 0).
factClassCallsMethod(class(2), function(10), unknown).
factClassCallsMethod(class(3), function(7), 0).
factClassCallsMethod(class(3), function(7), unknown).
factClassCallsMethod(class(3), function(4), 0).
factClassCallsMethod(class(3), function(4), unknown).
factClassCallsMethod(class(3), function(5), 0).
factClassCallsMethod(class(3), function(5), unknown).
factClassCallsMethod(class(3), function(6), 0).
factClassCallsMethod(class(3), function(6), unknown).
factClassCallsMethod(class(3), function(10), 0).
factClassCallsMethod(class(3), function(10), unknown).
factClassCallsMethod(class(3), function(2), 0).
factClassCallsMethod(class(3), function(2), unknown).
factClassCallsMethod(class(3), function(3), 0).
factClassCallsMethod(class(3), function(3), unknown).
factClassCallsMethod(class(3), function(9), 0).
factClassCallsMethod(class(3), function(9), unknown).
factClassCallsMethod(class(3), function(0), 0x4).
factClassCallsMethod(class(3), function(0), unknown).
factClassCallsMethod(class(3), function(1), 0x4).
factClassCallsMethod(class(3), function(1), unknown).
factClassCallsMethod(class(3), function(8), 0x4).
factClassCallsMethod(class(3), function(8), unknown).
factClassCallsMethod(class(3), function(7), 0).
factClassCallsMethod(class(3), function(7), unknown).
factClassRelatedMethod(class(0), function(0), 0).
factClassRelatedMethod(class(0), function(0), unknown).
factClassRelatedMethod(class(0), function(1), 0).
factClassRelatedMethod(class(0), function(1), unknown).
factClassRelatedMethod(class(0), function(8), 0).
factClassRelatedMethod(class(0), function(8), unknown).
factClassRelatedMethod(class(0), function(0), 0).
factClassRelatedMethod(class(0), function(0), unknown).
factClassRelatedMethod(class(0), function(1), 0).
factClassRelatedMethod(class(0), function(1), unknown).
factClassRelatedMethod(class(0), function(8), 0).
factClassRelatedMethod(class(0), function(8), unknown).
factClassRelatedMethod(class(0), function(0), 0).
factClassRelatedMethod(class(0), function(0), unknown).
factClassRelatedMethod(class(0), function(1), 0).
factClassRelatedMethod(class(0), function(1), unknown).
factClassRelatedMethod(class(0), function(8), 0).
factClassRelatedMethod(class(0), function(8), unknown).
factClassRelatedMethod(class(0), function(0), 0).
factClassRelatedMethod(class(0), function(0), unknown).
factClassRelatedMethod(class(0), function(1), 0).
factClassRelatedMethod(class(0), function(1), unknown).
factClassRelatedMethod(class(0), function(8), 0).
factClassRelatedMethod(class(0), function(8), unknown).
factClassRelatedMethod(class(1), function(2), 0).
factClassRelatedMethod(class(1), function(2), unknown).
factClassRelatedMethod(class(1), function(3), 0).
factClassRelatedMethod(class(1), function(3), unknown).
factClassRelatedMethod(class(1), function(9), 0).
factClassRelatedMethod(class(1), function(9), unknown).
factClassRelatedMethod(class(1), function(2), 0).
factClassRelatedMethod(class(1), function(2), unknown).
factClassRelatedMethod(class(1), function(3), 0).
factClassRelatedMethod(class(1), function(3), unknown).
factClassRelatedMethod(class(1), function(9), 0).
factClassRelatedMethod(class(1), function(9), unknown).
factClassRelatedMethod(class(1), function(2), 0).
factClassRelatedMethod(class(1), function(2), unknown).
factClassRelatedMethod(class(1), function(3), 0).
factClassRelatedMethod(class(1), function(3), unknown).
factClassRelatedMethod(class(1), function(9), 0).
factClassRelatedMethod(class(1), function(9), unknown).
factClassRelatedMethod(class(1), function(2), 0).
factClassRelatedMethod(class(1), function(2), unknown).
factClassRelatedMethod(class(1), function(3), 0).
factClassRelatedMethod(class(1), function(3), unknown).
factClassRelatedMethod(class(1), function(9), 0).
factClassRelatedMethod(class(1), function(9), unknown).
factClassRelatedMethod(class(2), function(4), 0).
factClassRelatedMethod(class(2), function(4), unknown).
factClassRelatedMethod(class(2), function(5), 0).
factClassRelatedMethod(class(2), function(5), unknown).
factClassRelatedMethod(class(2), function(6), 0).
factClassRelatedMethod(class(2), function(6), unknown).
factClassRelatedMethod(class(2), function(10), 0).
factClassRelatedMethod(class(2), function(10), unknown).
factClassRelatedMethod(class(2), function(4), 0).
factClassRelatedMethod(class(2), function(4), unknown).
factClassRelatedMethod(class(2), function(5), 0).
factClassRelatedMethod(class(2), function(5), unknown).
factClassRelatedMethod(class(2), function(6), 0).
factClassRelatedMethod(class(2), function(6), unknown).
factClassRelatedMethod(class(2), function(10), 0).
factClassRelatedMethod(class(2), function(10), unknown).
factClassRelatedMethod(class(2), function(2), 0).
factClassRelatedMethod(class(2), function(2), unknown).
factClassRelatedMethod(class(2), function(3), 0).
factClassRelatedMethod(class(2), function(3), unknown).
factClassRelatedMethod(class(2), function(9), 0).
factClassRelatedMethod(class(2), function(9), unknown).
factClassRelatedMethod(class(1), function(4), 0).
factClassRelatedMethod(class(1), function(4), unknown).
factClassRelatedMethod(class(1), function(5), 0).
factClassRelatedMethod(class(1), function(5), unknown).
factClassRelatedMethod(class(1), function(6), 0).
factClassRelatedMethod(class(1), function(6), unknown).
factClassRelatedMethod(class(1), function(10), 0).
factClassRelatedMethod(class(1), function(10), unknown).
factClassRelatedMethod(class(2), function(0), 0x4).
factClassRelatedMethod(class(2), function(0), unknown).
factClassRelatedMethod(class(2), function(1), 0x4).
factClassRelatedMethod(class(2), function(1), unknown).
factClassRelatedMethod(class(2), function(8), 0x4).
factClassRelatedMethod(class(2), function(8), unknown).
factClassRelatedMethod(class(0), function(4), 0x4).
factClassRelatedMethod(class(0), function(4), unknown).
factClassRelatedMethod(class(0), function(5), 0x4).
factClassRelatedMethod(class(0), function(5), unknown).
factClassRelatedMethod(class(0), function(6), 0x4).
factClassRelatedMethod(class(0), function(6), unknown).
factClassRelatedMethod(class(0), function(10), 0x4).
factClassRelatedMethod(class(0), function(10), unknown).
factClassRelatedMethod(class(2), function(4), 0).
factClassRelatedMethod(class(2), function(4), unknown).
factClassRelatedMethod(class(2), function(5), 0).
factClassRelatedMethod(class(2), function(5), unknown).
factClassRelatedMethod(class(2), function(6), 0).
factClassRelatedMethod(class(2), function(6), unknown).
factClassRelatedMethod(class(2), function(10), 0).
factClassRelatedMethod(class(2), function(10), unknown).
factClassRelatedMethod(class(2), function(4), 0).
factClassRelatedMethod(class(2), function(4), unknown).
factClassRelatedMethod(class(2), function(5), 0).
factClassRelatedMethod(class(2), function(5), unknown).
factClassRelatedMethod(class(2), function(6), 0).
factClassRelatedMethod(class(2), function(6), unknown).
factClassRelatedMethod(class(2), function(10), 0).
factClassRelatedMethod(class(2), function(10), unknown).
factClassRelatedMethod(class(3), function(7), 0).
factClassRelatedMethod(class(3), function(7), unknown).
factClassRelatedMethod(class(3), function(7), 0).
factClassRelatedMethod(class(3), function(7), unknown).
factClassRelatedMethod(class(3), function(4), 0).
factClassRelatedMethod(class(3), function(4), unknown).
factClassRelatedMethod(class(3), function(5), 0).
factClassRelatedMethod(class(3), function(5), unknown).
factClassRelatedMethod(class(3), function(6), 0).
factClassRelatedMethod(class(3), function(6), unknown).
factClassRelatedMethod(class(3), function(10), 0).
factClassRelatedMethod(class(3), function(10), unknown).
factClassRelatedMethod(class(2), function(7), 0).
factClassRelatedMethod(class(2), function(7), unknown).
factClassRelatedMethod(class(3), function(2), 0).
factClassRelatedMethod(class(3), function(2), unknown).
factClassRelatedMethod(class(3), function(3), 0).
factClassRelatedMethod(class(3), function(3), unknown).
factClassRelatedMethod(class(3), function(9), 0).
factClassRelatedMethod(class(3), function(9), unknown).
factClassRelatedMethod(class(1), function(7), 0).
factClassRelatedMethod(class(1), function(7), unknown).
factClassRelatedMethod(class(3), function(0), 0x4).
factClassRelatedMethod(class(3), function(0), unknown).
factClassRelatedMethod(class(3), function(1), 0x4).
factClassRelatedMethod(class(3), function(1), unknown).
factClassRelatedMethod(class(3), function(8), 0x4).
factClassRelatedMethod(class(3), function(8), unknown).
factClassRelatedMethod(class(0), function(7), 0x4).
factClassRelatedMethod(class(0), function(7), unknown).
factClassRelatedMethod(class(3), function(7), 0).
factClassRelatedMethod(class(3), function(7), unknown).
factClassRelatedMethod(class(3), function(7), 0).
factClassRelatedMethod(class(3), function(7), unknown).
% vftable(0) for path [ 0 ]
factVFTable(vftable(0)).
factVFTableSizeGTE(vftable(0), 4).
factVFTableSizeLTE(vftable(0), 4).
factVFTableEntry(vftable(0), 0, function(0)).
possibleVFTableEntry(vftable(0), 0, function(0)).
factMethodInVFTable(vftable(0), 0, function(0)).
% vftable(2) for path [ 0, 2 ]
factVFTable(vftable(2)).
factVFTableSizeGTE(vftable(2), 4).
factVFTableSizeLTE(vftable(2), 4).
factVFTableEntry(vftable(2), 0, function(5)).
possibleVFTableEntry(vftable(2), 0, function(5)).
factMethodInVFTable(vftable(2), 0, function(5)).
% vftable(4) for path [ 0, 2, 3 ]
factVFTable(vftable(4)).
factVFTableSizeGTE(vftable(4), 4).
factVFTableSizeLTE(vftable(4), 4).
factVFTableEntry(vftable(4), 0, function(5)).
possibleVFTableEntry(vftable(4), 0, function(5)).
factMethodInVFTable(vftable(4), 0, function(5)).
% vftable(1) for path [ 1 ]
factVFTable(vftable(1)).
factVFTableSizeGTE(vftable(1), 4).
factVFTableSizeLTE(vftable(1), 4).
factVFTableEntry(vftable(1), 0, function(2)).
possibleVFTableEntry(vftable(1), 0, function(2)).
factMethodInVFTable(vftable(1), 0, function(2)).
% vftable(3) for path [ 1, 2 ]
factVFTable(vftable(3)).
factVFTableSizeGTE(vftable(3), 8).
factVFTableSizeLTE(vftable(3), 8).
factVFTableEntry(vftable(3), 0, function(5)).
possibleVFTableEntry(vftable(3), 0, function(5)).
factMethodInVFTable(vftable(3), 0, function(5)).
factVFTableEntry(vftable(3), 0x4, function(4)).
possibleVFTableEntry(vftable(3), 0x4, function(4)).
factMethodInVFTable(vftable(3), 0x4, function(4)).
% vftable(5) for path [ 1, 2, 3 ]
factVFTable(vftable(5)).
factVFTableSizeGTE(vftable(5), 8).
factVFTableSizeLTE(vftable(5), 8).
factVFTableEntry(vftable(5), 0, function(5)).
possibleVFTableEntry(vftable(5), 0, function(5)).
factMethodInVFTable(vftable(5), 0, function(5)).
factVFTableEntry(vftable(5), 0x4, function(4)).
possibleVFTableEntry(vftable(5), 0x4, function(4)).
factMethodInVFTable(vftable(5), 0x4, function(4)).
factVFTableWrite(0x10005, function(0), vftable(0)).
possibleVFTableWriteHelper(0x10005, function(0), thisptr(0), [], vftable(0)).
factVFTableWrite(0x11005, function(1), vftable(0)).
possibleVFTableWriteHelper(0x11005, function(1), thisptr(1), [], vftable(0)).
factVFTableWrite(0x12005, function(2), vftable(1)).
possibleVFTableWriteHelper(0x12005, function(2), thisptr(2), [], vftable(1)).
factVFTableWrite(0x13005, function(3), vftable(1)).
possibleVFTableWriteHelper(0x13005, function(3), thisptr(3), [], vftable(1)).
factVFTableWrite(0x15008, function(5), vftable(2)).
possibleVFTableWriteHelper(0x15008, function(5), thisptr(4), [], vftable(2)).
factVFTableWrite(0x1500f, function(5), vftable(3)).
possibleVFTableWriteHelper(0x1500f, function(5), thisptr(5), [], vftable(3)).
factVFTableWrite(0x1600d, function(6), vftable(2)).
possibleVFTableWriteHelper(0x1600d, function(6), thisptr(6), [], vftable(2)).
factVFTableWrite(0x16012, function(6), vftable(3)).
possibleVFTableWriteHelper(0x16012, function(6), thisptr(7), [], vftable(3)).
factVFTableWrite(0x17009, function(7), vftable(4)).
possibleVFTableWriteHelper(0x17009, function(7), thisptr(8), [], vftable(4)).
factVFTableWrite(0x1700e, function(7), vftable(5)).
possibleVFTableWriteHelper(0x1700e, function(7), thisptr(9), [], vftable(5)).
factVFTableWrite(0x1a00e, function(10), vftable(2)).
possibleVFTableWriteHelper(0x1a00e, function(10), thisptr(10), [conditional], vftable(2)).
factVFTableWrite(0x1a014, function(10), vftable(3)).
possibleVFTableWriteHelper(0x1a014, function(10), thisptr(11), [conditional], vftable(3)).
factDerivedClass(class(2), class(1), 0, nonvirtual).
factDerivedClass(class(2), class(1), 0, unknown).
factNOTEmbeddedObject(class(2), class(1), 0).
factObjectInObject(class(2), class(1), 0).
factDerivedClass(class(2), class(0), 0x4, nonvirtual).
factDerivedClass(class(2), class(0), 0x4, unknown).
factNOTEmbeddedObject(class(2), class(0), 0x4).
factObjectInObject(class(2), class(0), 0x4).
factDerivedClass(class(3), class(2), 0, nonvirtual).
factDerivedClass(class(3), class(2), 0, unknown).
factNOTEmbeddedObject(class(3), class(2), 0).
factObjectInObject(class(3), class(2), 0).
factClassHasNoBase(class(0)).
factClassHasNoBase(class(1)).
factClassSizeGTE(class(0), 4).
factClassSizeLTE(class(0), 4).
factClassSizeGTE(class(1), 4).
factClassSizeLTE(class(1), 4).
factClassSizeGTE(class(2), 8).
factClassSizeLTE(class(2), 8).
factClassSizeGTE(class(3), 8).
factClassSizeLTE(class(3), 8).
findint(function(0), class(0)).
factMethod(function(0)).
factNOTConstructor(function(0)).
factRealDestructor(function(0)).
factNOTDeletingDestructor(function(0)).
findint(function(1), class(0)).
factMethod(function(1)).
factConstructor(function(1)).
factNOTRealDestructor(function(1)).
factNOTDeletingDestructor(function(1)).
findint(function(2), class(1)).
factMethod(function(2)).
factNOTConstructor(function(2)).
factRealDestructor(function(2)).
factNOTDeletingDestructor(function(2)).
findint(function(3), class(1)).
factMethod(function(3)).
factConstructor(function(3)).
factNOTRealDestructor(function(3)).
factNOTDeletingDestructor(function(3)).
findint(function(4), class(2)).
factMethod(function(4)).
factNOTConstructor(function(4)).
factNOTRealDestructor(function(4)).
factNOTDeletingDestructor(function(4)).
findint(function(5), class(2)).
factMethod(function(5)).
factNOTConstructor(function(5)).
factRealDestructor(function(5)).
factNOTDeletingDestructor(function(5)).
findint(function(6), class(2)).
factMethod(function(6)).
factConstructor(function(6)).
factNOTRealDestructor(function(6)).
factNOTDeletingDestructor(function(6)).
findint(function(7), class(3)).
factMethod(function(7)).
factConstructor(function(7)).
factNOTRealDestructor(function(7)).
factNOTDeletingDestructor(function(7)).
findint(function(8), class(0)).
factMethod(function(8)).
factNOTConstructor(function(8)).
factNOTRealDestructor(function(8)).
factDeletingDestructor(function(8)).
findint(function(9), class(1)).
factMethod(function(9)).
factNOTConstructor(function(9)).
factNOTRealDestructor(function(9)).
factDeletingDestructor(function(9)).
findint(function(10), class(2)).
factMethod(function(10)).
factNOTConstructor(function(10)).
factNOTRealDestructor(function(10)).
factDeletingDestructor(function(10)).
funcParameter(function(0), ecx, thisptr(0)).
funcParameter(function(1), ecx, thisptr(1)).
funcParameter(function(2), ecx, thisptr(2)).
funcParameter(function(3), ecx, thisptr(3)).
funcParameter(function(4), ecx, thisptr(12)).
funcParameter(function(5), ecx, thisptr(13)).
funcParameter(function(6), ecx, thisptr(7)).
funcParameter(function(7), ecx, thisptr(9)).
funcParameter(function(8), ecx, thisptr(14)).
funcParameter(function(9), ecx, thisptr(15)).
funcParameter(function(10), ecx, thisptr(16)).
callParameter(0x10009, function(0), ecx, thisptr(17)).
callParameter(0x1000a, function(0), ecx, thisptr(18)).
callParameter(0x1501a, function(5), ecx, thisptr(4)).
callParameter(0x1501f, function(5), ecx, thisptr(5)).
callParameter(0x16003, function(6), ecx, thisptr(7)).
callParameter(0x16007, function(6), ecx, thisptr(6)).
callParameter(0x17003, function(7), ecx, thisptr(9)).
callParameter(0x18002, function(8), ecx, thisptr(14)).
callParameter(0x19002, function(9), ecx, thisptr(15)).
callParameter(0x1a01e, function(10), ecx, thisptr(10)).
callParameter(0x1a022, function(10), ecx, thisptr(11)).
callTarget(0x10009, function(0), function(1)).
callTarget(0x1000a, function(0), function(8)).
callTarget(0x1501a, function(5), function(0)).
callTarget(0x1501f, function(5), function(2)).
callTarget(0x16003, function(6), function(3)).
callTarget(0x16007, function(6), function(1)).
callTarget(0x17003, function(7), function(6)).
callTarget(0x18002, function(8), function(0)).
callTarget(0x19002, function(9), function(2)).
callTarget(0x1a01e, function(10), function(0)).
callTarget(0x1a022, function(10), function(2)).
thisPtrOffset(function(5), thisptr(13), -0x4, thisptr(5)).
thisPtrOffset(function(5), thisptr(13), -0x4, thisptr(5)).
thisPtrOffset(function(5), thisptr(5), 0x4, thisptr(4)).
thisPtrOffset(function(5), thisptr(13), -0x4, thisptr(5)).
thisPtrOffset(function(5), thisptr(13), -0x4, thisptr(5)).
thisPtrOffset(function(5), thisptr(13), -0x4, thisptr(5)).
thisPtrOffset(function(5), thisptr(5), 0x4, thisptr(4)).
thisPtrOffset(function(5), thisptr(13), -0x4, thisptr(5)).
thisPtrOffset(function(6), thisptr(7), 0x4, thisptr(6)).
thisPtrOffset(function(6), thisptr(7), 0x4, thisptr(6)).
thisPtrOffset(function(7), thisptr(9), 0x4, thisptr(8)).
thisPtrOffset(function(10), thisptr(16), -0x4, thisptr(19)).
thisPtrOffset(function(10), thisptr(19), 0x4, thisptr(20)).
thisPtrOffset(function(10), thisptr(20), -0x4, thisptr(11)).
thisPtrOffset(function(10), thisptr(20), -0x4, thisptr(11)).
thisPtrOffset(function(10), thisptr(11), 0x4, thisptr(10)).
thisPtrOffset(function(10), thisptr(20), -0x4, thisptr(11)).
thisPtrOffset(function(10), thisptr(20), -0x4, thisptr(11)).
thisPtrOffset(function(10), thisptr(20), -0x4, thisptr(11)).
thisPtrOffset(function(10), thisptr(11), 0x4, thisptr(10)).
thisPtrOffset(function(10), thisptr(20), -0x4, thisptr(11)).
thisPtrOffset(function(10), thisptr(16), -0x4, thisptr(19)).
thisPtrAllocation(0x10008, function(0), thisptr(17), type_Heap, 4).
insnCallsDelete(0x18004, function(8), thisptr(14)).
insnCallsDelete(0x19004, function(9), thisptr(15)).
insnCallsDelete(0x1a027, function(10), thisptr(19)).
% Adapt to rules that assume thisptr is in ecx
% Mimic noCallsBefore/1 and noCallsAfter/1 for old rules
noCallsBefore(M) :- possibleMethod(M), not(callBefore(_F, _A, _BeforeM, M)).
noCallsAfter(M) :- possibleMethod(M), not(callBefore(_F, _A, M, _AfterM)).
% Assume thiscall
callingConvention(M, '__thiscall').
% Given a thisptr, try to do constant propagation as far back as we can to the oldest thisptr.
:- table goBack/4 as opaque.
goBack(F, Tnew, Tnew, 0) :- not(thisPtrOffset(F, _, _, Tnew)), !.
goBack(F, Tnew, Told, Offset) :- thisPtrOffset(F, Tmid, MidOffset, Tnew), goBack(F, Tmid, Told, OldOffset), Offset is MidOffset + OldOffset.
% Adapt to possibleVFTableWrite with offsets
% Assume that any condition is a vbase condition
:- multifile unconditional_single/1.
unconditional_single(unconditional).
possibleVFTableWrite(A, F, Told, O, Told, Cond, V) :- possibleVFTableWriteHelper(A, F, T, Cond, V), goBack(F, T, Told, O), funcParameter(F, ecx, Told).
% Auto ignore the condition.
possibleVFTableWrite(A, F, T, O, V) :- possibleVFTableWrite(A, F, T, O, T, _Cond, V).
% Adapt thisPtrOffset
thisPtrOffset(A,B,C) :- thisPtrOffset(_F,A,B,C).
% Adapt to factVFTableWrite with offsets
factVFTableWrite(A, F, O, V) :- factVFTableWrite(A, F, V), possibleVFTableWrite(A, F, _, O, V).
% Adapt to possibleVBTableWrite with offsets
possibleVBTableWrite(A, F, Told, O, Cond, V) :- possibleVBTableWriteHelper(A, F, T, Cond, V), goBack(F, T, Told, O), funcParameter(F, ecx, Told).
% Auto ignore the condition.
possibleVBTableWrite(A, F, T, O, V) :- possibleVBTableWrite(A, F, T, O, _Cond, V).
% Adapt to factVBTableWrite with offsets
factVBTableWrite(A, F, O, V) :- factVBTableWrite(A, F, V), possibleVBTableWrite(A, F, _, O, V).
% Adapt methodMemberAccess to offsets
methodMemberAccess(Addr, Func, Offset, Size) :- methodMemberAccessHelper(Addr, Func, T, Size), funcParameter(F, ecx, Told), goBack(F, T, Told, Offset).
% Auto factNOTMergeClasses.
factNOTMergeClasses(A, B) :- class(A), class(B), iso_dif(A, B), not(ignorefactNOTMergeClasses(A, B)).
groundVFTableBelongsToClass(vftable(0), class(0)).
findint(vftable(0), class(0)).
groundVFTableBelongsToClass(vftable(2), class(2)).
findint(vftable(2), class(2)).
groundVFTableBelongsToClass(vftable(4), class(3)).
findint(vftable(4), class(3)).
groundVFTableBelongsToClass(vftable(1), class(1)).
findint(vftable(1), class(1)).
groundVFTableBelongsToClass(vftable(3), class(2)).
findint(vftable(3), class(2)).
groundVFTableBelongsToClass(vftable(5), class(3)).
findint(vftable(5), class(3)).
groundConstructor(function(1)).
groundConstructor(function(3)).
groundConstructor(function(6)).
groundConstructor(function(7)).
groundDestructor(function(0)).
groundDestructor(function(2)).
groundDestructor(function(5)).
check_VftableBelongs_sound(Arg) :- forall((reasonVFTableBelongsToClass(VFTable, _, Class, _, _)), ((groundVFTableBelongsToClass(VFTable, Class)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','VftableBelongs','VftableBelongs',(VFTable, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','VftableBelongs','VftableBelongs',(VFTable, Class), Arg])))).
check_VftableBelongs_complete(Arg) :- forall((groundVFTableBelongsToClass(VFTable, Class)), ((snapshot((true, reasonVFTableBelongsToClass(VFTable, _, Class, _, _)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','VftableBelongs','VftableBelongs',(VFTable, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','VftableBelongs','VftableBelongs',(VFTable, Class), Arg])))).
check_Method_sound(Arg) :- forall((reasonMethod(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','Method','Method',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','Method','Method',(M), Arg])))).
check_MethodB_sound(Arg) :- forall((reasonMethod_B(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodB','MethodB',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodB','MethodB',(M), Arg])))).
check_MethodC_sound(Arg) :- forall((reasonMethod_C(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodC','MethodC',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodC','MethodC',(M), Arg])))).
check_MethodD_sound(Arg) :- forall((reasonMethod_D(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodD','MethodD',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodD','MethodD',(M), Arg])))).
check_MethodE_sound(Arg) :- forall((reasonMethod_E(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodE','MethodE',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodE','MethodE',(M), Arg])))).
check_MethodF_sound(Arg) :- forall((reasonMethod_F(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodF','MethodF',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodF','MethodF',(M), Arg])))).
check_MethodG_sound(Arg) :- forall((reasonMethod_G(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodG','MethodG',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodG','MethodG',(M), Arg])))).
check_MethodH_sound(Arg) :- forall((reasonMethod_H(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodH','MethodH',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodH','MethodH',(M), Arg])))).
check_MethodI_sound(Arg) :- forall((reasonMethod_I(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodI','MethodI',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodI','MethodI',(M), Arg])))).
check_MethodJ_sound(Arg) :- forall((reasonMethod_J(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodJ','MethodJ',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodJ','MethodJ',(M), Arg])))).
check_MethodK_sound(Arg) :- forall((reasonMethod_K(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodK','MethodK',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodK','MethodK',(M), Arg])))).
check_MethodL_sound(Arg) :- forall((reasonMethod_L(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodL','MethodL',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodL','MethodL',(M), Arg])))).
check_MethodM_sound(Arg) :- forall((reasonMethod_M(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodM','MethodM',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodM','MethodM',(M), Arg])))).
check_MethodN_sound(Arg) :- forall((reasonMethod_N(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodN','MethodN',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodN','MethodN',(M), Arg])))).
check_MethodO_sound(Arg) :- forall((reasonMethod_O(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodO','MethodO',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodO','MethodO',(M), Arg])))).
check_MethodP_sound(Arg) :- forall((reasonMethod_P(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodP','MethodP',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodP','MethodP',(M), Arg])))).
check_Method_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','Method','Method',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','Method','Method',(M), Arg])))).
check_MethodB_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_B(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodB','MethodB',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodB','MethodB',(M), Arg])))).
check_MethodC_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_C(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodC','MethodC',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodC','MethodC',(M), Arg])))).
check_MethodD_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_D(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodD','MethodD',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodD','MethodD',(M), Arg])))).
check_MethodE_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_E(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodE','MethodE',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodE','MethodE',(M), Arg])))).
check_MethodF_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_F(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodF','MethodF',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodF','MethodF',(M), Arg])))).
check_MethodG_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_G(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodG','MethodG',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodG','MethodG',(M), Arg])))).
check_MethodH_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_H(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodH','MethodH',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodH','MethodH',(M), Arg])))).
check_MethodI_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_I(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodI','MethodI',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodI','MethodI',(M), Arg])))).
check_MethodJ_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_J(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodJ','MethodJ',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodJ','MethodJ',(M), Arg])))).
check_MethodK_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_K(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodK','MethodK',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodK','MethodK',(M), Arg])))).
check_MethodL_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_L(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodL','MethodL',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodL','MethodL',(M), Arg])))).
check_MethodM_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_M(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodM','MethodM',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodM','MethodM',(M), Arg])))).
check_MethodN_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_N(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodN','MethodN',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodN','MethodN',(M), Arg])))).
check_MethodO_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_O(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodO','MethodO',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodO','MethodO',(M), Arg])))).
check_MethodP_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_P(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodP','MethodP',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodP','MethodP',(M), Arg])))).
check_NOTConstructor_sound(Arg) :- forall((reasonNOTConstructor(M)), ((groundTruth(factNOTConstructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructor','NOTConstructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructor','NOTConstructor',(M), Arg])))).
check_NOTConstructorB_sound(Arg) :- forall((reasonNOTConstructor_B(M)), ((groundTruth(factNOTConstructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorB','NOTConstructorB',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorB','NOTConstructorB',(M), Arg])))).
check_NOTConstructorC_sound(Arg) :- forall((reasonNOTConstructor_C(M)), ((groundTruth(factNOTConstructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorC','NOTConstructorC',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorC','NOTConstructorC',(M), Arg])))).
check_NOTConstructorD_sound(Arg) :- forall((reasonNOTConstructor_D(M)), ((groundTruth(factNOTConstructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorD','NOTConstructorD',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorD','NOTConstructorD',(M), Arg])))).
check_NOTConstructorF_sound(Arg) :- forall((reasonNOTConstructor_F(M)), ((groundTruth(factNOTConstructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorF','NOTConstructorF',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorF','NOTConstructorF',(M), Arg])))).
check_NOTConstructorG_sound(Arg) :- forall((reasonNOTConstructor_G(M)), ((groundTruth(factNOTConstructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorG','NOTConstructorG',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorG','NOTConstructorG',(M), Arg])))).
check_NOTConstructorH_sound(Arg) :- forall((reasonNOTConstructor_H(M)), ((groundTruth(factNOTConstructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorH','NOTConstructorH',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorH','NOTConstructorH',(M), Arg])))).
check_NOTConstructorI_sound(Arg) :- forall((reasonNOTConstructor_I(M)), ((groundTruth(factNOTConstructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorI','NOTConstructorI',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorI','NOTConstructorI',(M), Arg])))).
check_NOTConstructorJ_sound(Arg) :- forall((reasonNOTConstructor_J(M)), ((groundTruth(factNOTConstructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorJ','NOTConstructorJ',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorJ','NOTConstructorJ',(M), Arg])))).
check_NOTConstructor_complete(Arg) :- forall((groundTruth(factNOTConstructor(M))), ((snapshot((retractall(factNOTConstructor(M)), reasonNOTConstructor(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructor','NOTConstructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructor','NOTConstructor',(M), Arg])))).
check_NOTConstructorB_complete(Arg) :- forall((groundTruth(factNOTConstructor(M))), ((snapshot((retractall(factNOTConstructor(M)), reasonNOTConstructor_B(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorB','NOTConstructorB',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorB','NOTConstructorB',(M), Arg])))).
check_NOTConstructorC_complete(Arg) :- forall((groundTruth(factNOTConstructor(M))), ((snapshot((retractall(factNOTConstructor(M)), reasonNOTConstructor_C(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorC','NOTConstructorC',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorC','NOTConstructorC',(M), Arg])))).
check_NOTConstructorD_complete(Arg) :- forall((groundTruth(factNOTConstructor(M))), ((snapshot((retractall(factNOTConstructor(M)), reasonNOTConstructor_D(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorD','NOTConstructorD',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorD','NOTConstructorD',(M), Arg])))).
check_NOTConstructorF_complete(Arg) :- forall((groundTruth(factNOTConstructor(M))), ((snapshot((retractall(factNOTConstructor(M)), reasonNOTConstructor_F(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorF','NOTConstructorF',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorF','NOTConstructorF',(M), Arg])))).
check_NOTConstructorG_complete(Arg) :- forall((groundTruth(factNOTConstructor(M))), ((snapshot((retractall(factNOTConstructor(M)), reasonNOTConstructor_G(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorG','NOTConstructorG',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorG','NOTConstructorG',(M), Arg])))).
check_NOTConstructorH_complete(Arg) :- forall((groundTruth(factNOTConstructor(M))), ((snapshot((retractall(factNOTConstructor(M)), reasonNOTConstructor_H(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorH','NOTConstructorH',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorH','NOTConstructorH',(M), Arg])))).
check_NOTConstructorI_complete(Arg) :- forall((groundTruth(factNOTConstructor(M))), ((snapshot((retractall(factNOTConstructor(M)), reasonNOTConstructor_I(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorI','NOTConstructorI',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorI','NOTConstructorI',(M), Arg])))).
check_NOTConstructorJ_complete(Arg) :- forall((groundTruth(factNOTConstructor(M))), ((snapshot((retractall(factNOTConstructor(M)), reasonNOTConstructor_J(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorJ','NOTConstructorJ',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorJ','NOTConstructorJ',(M), Arg])))).
check_Constructor_sound(Arg) :- forall((reasonConstructor(M)), ((factConstructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','Constructor','Constructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','Constructor','Constructor',(M), Arg])))).
check_Constructor_complete(Arg) :- forall((factConstructor(M)), ((snapshot((retract(factConstructor(M)), reasonConstructor(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','Constructor','Constructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','Constructor','Constructor',(M), Arg])))).
check_RealDestructor_sound(Arg) :- forall((reasonRealDestructor(M)), ((factRealDestructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','RealDestructor','RealDestructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','RealDestructor','RealDestructor',(M), Arg])))).
check_RealDestructor_complete(Arg) :- forall((factRealDestructor(M)), ((snapshot((retract(factRealDestructor(M)), reasonRealDestructor(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','RealDestructor','RealDestructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','RealDestructor','RealDestructor',(M), Arg])))).
check_NOTRealDestructor_sound(Arg) :- forall((reasonNOTRealDestructor(M)), ((groundTruth(factNOTRealDestructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructor','NOTRealDestructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructor','NOTRealDestructor',(M), Arg])))).
check_NOTRealDestructorB_sound(Arg) :- forall((reasonNOTRealDestructor_B(M)), ((groundTruth(factNOTRealDestructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorB','NOTRealDestructorB',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorB','NOTRealDestructorB',(M), Arg])))).
check_NOTRealDestructorC_sound(Arg) :- forall((reasonNOTRealDestructor_C(M)), ((groundTruth(factNOTRealDestructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorC','NOTRealDestructorC',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorC','NOTRealDestructorC',(M), Arg])))).
check_NOTRealDestructorD_sound(Arg) :- forall((reasonNOTRealDestructor_D(M)), ((groundTruth(factNOTRealDestructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorD','NOTRealDestructorD',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorD','NOTRealDestructorD',(M), Arg])))).
check_NOTRealDestructorE_sound(Arg) :- forall((reasonNOTRealDestructor_E(M)), ((groundTruth(factNOTRealDestructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorE','NOTRealDestructorE',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorE','NOTRealDestructorE',(M), Arg])))).
check_NOTRealDestructorF_sound(Arg) :- forall((reasonNOTRealDestructor_F(M)), ((groundTruth(factNOTRealDestructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorF','NOTRealDestructorF',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorF','NOTRealDestructorF',(M), Arg])))).
check_NOTRealDestructorG_sound(Arg) :- forall((reasonNOTRealDestructor_G(M)), ((groundTruth(factNOTRealDestructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorG','NOTRealDestructorG',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorG','NOTRealDestructorG',(M), Arg])))).
check_NOTRealDestructorH_sound(Arg) :- forall((reasonNOTRealDestructor_H(M)), ((groundTruth(factNOTRealDestructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorH','NOTRealDestructorH',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorH','NOTRealDestructorH',(M), Arg])))).
check_NOTRealDestructorI_sound(Arg) :- forall((reasonNOTRealDestructor_I(M)), ((groundTruth(factNOTRealDestructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorI','NOTRealDestructorI',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorI','NOTRealDestructorI',(M), Arg])))).
check_NOTRealDestructorJ_sound(Arg) :- forall((reasonNOTRealDestructor_J(M)), ((groundTruth(factNOTRealDestructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorJ','NOTRealDestructorJ',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorJ','NOTRealDestructorJ',(M), Arg])))).
check_NOTRealDestructor_complete(Arg) :- forall((groundTruth(factNOTRealDestructor(M))), ((snapshot((retractall(factNOTRealDestructor(M)), reasonNOTRealDestructor(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructor','NOTRealDestructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructor','NOTRealDestructor',(M), Arg])))).
check_NOTRealDestructorB_complete(Arg) :- forall((groundTruth(factNOTRealDestructor(M))), ((snapshot((retractall(factNOTRealDestructor(M)), reasonNOTRealDestructor_B(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorB','NOTRealDestructorB',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorB','NOTRealDestructorB',(M), Arg])))).
check_NOTRealDestructorC_complete(Arg) :- forall((groundTruth(factNOTRealDestructor(M))), ((snapshot((retractall(factNOTRealDestructor(M)), reasonNOTRealDestructor_C(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorC','NOTRealDestructorC',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorC','NOTRealDestructorC',(M), Arg])))).
check_NOTRealDestructorD_complete(Arg) :- forall((groundTruth(factNOTRealDestructor(M))), ((snapshot((retractall(factNOTRealDestructor(M)), reasonNOTRealDestructor_D(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorD','NOTRealDestructorD',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorD','NOTRealDestructorD',(M), Arg])))).
check_NOTRealDestructorE_complete(Arg) :- forall((groundTruth(factNOTRealDestructor(M))), ((snapshot((retractall(factNOTRealDestructor(M)), reasonNOTRealDestructor_E(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorE','NOTRealDestructorE',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorE','NOTRealDestructorE',(M), Arg])))).
check_NOTRealDestructorF_complete(Arg) :- forall((groundTruth(factNOTRealDestructor(M))), ((snapshot((retractall(factNOTRealDestructor(M)), reasonNOTRealDestructor_F(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorF','NOTRealDestructorF',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorF','NOTRealDestructorF',(M), Arg])))).
check_NOTRealDestructorG_complete(Arg) :- forall((groundTruth(factNOTRealDestructor(M))), ((snapshot((retractall(factNOTRealDestructor(M)), reasonNOTRealDestructor_G(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorG','NOTRealDestructorG',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorG','NOTRealDestructorG',(M), Arg])))).
check_NOTRealDestructorH_complete(Arg) :- forall((groundTruth(factNOTRealDestructor(M))), ((snapshot((retractall(factNOTRealDestructor(M)), reasonNOTRealDestructor_H(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorH','NOTRealDestructorH',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorH','NOTRealDestructorH',(M), Arg])))).
check_NOTRealDestructorI_complete(Arg) :- forall((groundTruth(factNOTRealDestructor(M))), ((snapshot((retractall(factNOTRealDestructor(M)), reasonNOTRealDestructor_I(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorI','NOTRealDestructorI',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorI','NOTRealDestructorI',(M), Arg])))).
check_NOTRealDestructorJ_complete(Arg) :- forall((groundTruth(factNOTRealDestructor(M))), ((snapshot((retractall(factNOTRealDestructor(M)), reasonNOTRealDestructor_J(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorJ','NOTRealDestructorJ',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorJ','NOTRealDestructorJ',(M), Arg])))).
check_VFTableSizeGTE_sound(Arg) :- forall((reasonVFTableSizeGTE(V, S), factVFTableSizeGTE(V, Sground)), ((Sground >= S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','VFTableSizeGTE','VFTableSizeGTE',(V, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','VFTableSizeGTE','VFTableSizeGTE',(V, S, Sground), Arg])))).
check_VFTableSizeLTE_sound(Arg) :- forall((reasonVFTableSizeLTE(V, S), factVFTableSizeLTE(V, Sground)), ((Sground =< S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','VFTableSizeLTE','VFTableSizeLTE',(V, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','VFTableSizeLTE','VFTableSizeLTE',(V, S, Sground), Arg])))).
check_ClassSizeGTE_sound(Arg) :- forall((reasonClassSizeGTE(C, S), factClassSizeGTE(C, Sground)), ((Sground >= S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTE','ClassSizeGTE',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTE','ClassSizeGTE',(C, S, Sground), Arg])))).
check_ClassSizeGTEB_sound(Arg) :- forall((reasonClassSizeGTE_B(C, S), factClassSizeGTE(C, Sground)), ((Sground >= S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEB','ClassSizeGTEB',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEB','ClassSizeGTEB',(C, S, Sground), Arg])))).
check_ClassSizeGTEC_sound(Arg) :- forall((reasonClassSizeGTE_C(C, S), factClassSizeGTE(C, Sground)), ((Sground >= S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEC','ClassSizeGTEC',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEC','ClassSizeGTEC',(C, S, Sground), Arg])))).
check_ClassSizeGTED_sound(Arg) :- forall((reasonClassSizeGTE_D(C, S), factClassSizeGTE(C, Sground)), ((Sground >= S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTED','ClassSizeGTED',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTED','ClassSizeGTED',(C, S, Sground), Arg])))).
check_ClassSizeGTEE_sound(Arg) :- forall((reasonClassSizeGTE_E(C, S), factClassSizeGTE(C, Sground)), ((Sground >= S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEE','ClassSizeGTEE',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEE','ClassSizeGTEE',(C, S, Sground), Arg])))).
check_ClassSizeGTEF_sound(Arg) :- forall((reasonClassSizeGTE_F(C, S), factClassSizeGTE(C, Sground)), ((Sground >= S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEF','ClassSizeGTEF',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEF','ClassSizeGTEF',(C, S, Sground), Arg])))).
check_ClassSizeGTEG_sound(Arg) :- forall((reasonClassSizeGTE_G(C, S), factClassSizeGTE(C, Sground)), ((Sground >= S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEG','ClassSizeGTEG',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEG','ClassSizeGTEG',(C, S, Sground), Arg])))).
check_ClassSizeLTE_sound(Arg) :- forall((reasonClassSizeLTE(C, S), factClassSizeLTE(C, Sground)), ((Sground =< S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeLTE','ClassSizeLTE',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeLTE','ClassSizeLTE',(C, S, Sground), Arg])))).
check_ClassSizeLTEB_sound(Arg) :- forall((reasonClassSizeLTE_B(C, S), factClassSizeLTE(C, Sground)), ((Sground =< S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeLTEB','ClassSizeLTEB',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeLTEB','ClassSizeLTEB',(C, S, Sground), Arg])))).
check_ClassSizeLTEC_sound(Arg) :- forall((reasonClassSizeLTE_C(C, S), factClassSizeLTE(C, Sground)), ((Sground =< S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeLTEC','ClassSizeLTEC',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeLTEC','ClassSizeLTEC',(C, S, Sground), Arg])))).
check_ClassSizeLTED_sound(Arg) :- forall((reasonClassSizeLTE_D(C, S), factClassSizeLTE(C, Sground)), ((Sground =< S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeLTED','ClassSizeLTED',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeLTED','ClassSizeLTED',(C, S, Sground), Arg])))).
check_DerivedClass_sound(Arg) :- forall((reasonDerivedClass(Outer, Inner, Offset, Type)), ((factDerivedClass(Outer, Inner, Offset, Type)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClass','DerivedClass',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClass','DerivedClass',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassB_sound(Arg) :- forall((reasonDerivedClass_B(Outer, Inner, Offset, Type)), ((factDerivedClass(Outer, Inner, Offset, Type)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassB','DerivedClassB',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassB','DerivedClassB',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassC_sound(Arg) :- forall((reasonDerivedClass_C(Outer, Inner, Offset, Type)), ((factDerivedClass(Outer, Inner, Offset, Type)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassC','DerivedClassC',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassC','DerivedClassC',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassD_sound(Arg) :- forall((reasonDerivedClass_D(Outer, Inner, Offset, Type)), ((factDerivedClass(Outer, Inner, Offset, Type)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassD','DerivedClassD',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassD','DerivedClassD',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassE_sound(Arg) :- forall((reasonDerivedClass_E(Outer, Inner, Offset, Type)), ((factDerivedClass(Outer, Inner, Offset, Type)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassE','DerivedClassE',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassE','DerivedClassE',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassF_sound(Arg) :- forall((reasonDerivedClass_F(Outer, Inner, Offset, Type)), ((factDerivedClass(Outer, Inner, Offset, Type)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassF','DerivedClassF',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassF','DerivedClassF',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClass_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset, Type)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset, Type)), retract(factObjectInObject(Outer, Inner, Offset)), reasonDerivedClass(Outer, Inner, Offset, Type)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClass','DerivedClass',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClass','DerivedClass',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassB_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset, Type)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset, Type)), retract(factObjectInObject(Outer, Inner, Offset)), reasonDerivedClass_B(Outer, Inner, Offset, Type)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassB','DerivedClassB',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassB','DerivedClassB',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassC_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset, Type)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset, Type)), retract(factObjectInObject(Outer, Inner, Offset)), reasonDerivedClass_C(Outer, Inner, Offset, Type)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassC','DerivedClassC',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassC','DerivedClassC',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassD_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset, Type)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset, Type)), retract(factObjectInObject(Outer, Inner, Offset)), reasonDerivedClass_D(Outer, Inner, Offset, Type)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassD','DerivedClassD',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassD','DerivedClassD',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassE_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset, Type)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset, Type)), retract(factObjectInObject(Outer, Inner, Offset)), reasonDerivedClass_E(Outer, Inner, Offset, Type)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassE','DerivedClassE',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassE','DerivedClassE',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassF_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset, Type)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset, Type)), retract(factObjectInObject(Outer, Inner, Offset)), reasonDerivedClass_F(Outer, Inner, Offset, Type)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassF','DerivedClassF',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassF','DerivedClassF',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassOIO_sound(Arg) :- forall((reasonDerivedClass(Outer, Inner, Offset, Type)), ((factDerivedClass(Outer, Inner, Offset, Type)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIO','DerivedClassOIO',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIO','DerivedClassOIO',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassOIOB_sound(Arg) :- forall((reasonDerivedClass_B(Outer, Inner, Offset, Type)), ((factDerivedClass(Outer, Inner, Offset, Type)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOB','DerivedClassOIOB',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOB','DerivedClassOIOB',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassOIOC_sound(Arg) :- forall((reasonDerivedClass_C(Outer, Inner, Offset, Type)), ((factDerivedClass(Outer, Inner, Offset, Type)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOC','DerivedClassOIOC',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOC','DerivedClassOIOC',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassOIOD_sound(Arg) :- forall((reasonDerivedClass_D(Outer, Inner, Offset, Type)), ((factDerivedClass(Outer, Inner, Offset, Type)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOD','DerivedClassOIOD',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOD','DerivedClassOIOD',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassOIOE_sound(Arg) :- forall((reasonDerivedClass_E(Outer, Inner, Offset, Type)), ((factDerivedClass(Outer, Inner, Offset, Type)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOE','DerivedClassOIOE',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOE','DerivedClassOIOE',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassOIOF_sound(Arg) :- forall((reasonDerivedClass_F(Outer, Inner, Offset, Type)), ((factDerivedClass(Outer, Inner, Offset, Type)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOF','DerivedClassOIOF',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOF','DerivedClassOIOF',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassOIO_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset, Type)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset, Type)), reasonDerivedClass(Outer, Inner, Offset, Type)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIO','DerivedClassOIO',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIO','DerivedClassOIO',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassOIOB_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset, Type)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset, Type)), reasonDerivedClass_B(Outer, Inner, Offset, Type)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOB','DerivedClassOIOB',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOB','DerivedClassOIOB',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassOIOC_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset, Type)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset, Type)), reasonDerivedClass_C(Outer, Inner, Offset, Type)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOC','DerivedClassOIOC',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOC','DerivedClassOIOC',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassOIOD_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset, Type)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset, Type)), reasonDerivedClass_D(Outer, Inner, Offset, Type)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOD','DerivedClassOIOD',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOD','DerivedClassOIOD',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassOIOE_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset, Type)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset, Type)), reasonDerivedClass_E(Outer, Inner, Offset, Type)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOE','DerivedClassOIOE',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOE','DerivedClassOIOE',(Outer, Inner, Offset, Type), Arg])))).
check_DerivedClassOIOF_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset, Type)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset, Type)), reasonDerivedClass_F(Outer, Inner, Offset, Type)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOF','DerivedClassOIOF',(Outer, Inner, Offset, Type), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOF','DerivedClassOIOF',(Outer, Inner, Offset, Type), Arg])))).
check_NOTDerivedClass_sound(Arg) :- forall((reasonNOTDerivedClass(Outer, Inner, Offset)), ((groundTruth(factNOTDerivedClass(Outer, Inner, Offset))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTDerivedClass','NOTDerivedClass',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTDerivedClass','NOTDerivedClass',(Outer, Inner, Offset), Arg])))).
check_NOTDerivedClass_complete(Arg) :- forall((groundTruth(factNOTDerivedClass(Outer, Inner, Offset))), ((snapshot((retract(factNOTDerivedClass(Outer, Inner, Offset)), reasonNOTDerivedClass(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTDerivedClass','NOTDerivedClass',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTDerivedClass','NOTDerivedClass',(Outer, Inner, Offset), Arg])))).
check_EmbeddedObject_sound(Arg) :- forall((reasonEmbeddedObject(Outer, Inner, Offset)), ((factEmbeddedObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','EmbeddedObject','EmbeddedObject',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','EmbeddedObject','EmbeddedObject',(Outer, Inner, Offset), Arg])))).
check_EmbeddedObjectB_sound(Arg) :- forall((reasonEmbeddedObject_B(Outer, Inner, Offset)), ((factEmbeddedObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','EmbeddedObjectB','EmbeddedObjectB',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','EmbeddedObjectB','EmbeddedObjectB',(Outer, Inner, Offset), Arg])))).
check_EmbeddedObjectC_sound(Arg) :- forall((reasonEmbeddedObject_C(Outer, Inner, Offset)), ((factEmbeddedObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','EmbeddedObjectC','EmbeddedObjectC',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','EmbeddedObjectC','EmbeddedObjectC',(Outer, Inner, Offset), Arg])))).
check_EmbeddedObjectD_sound(Arg) :- forall((reasonEmbeddedObject_D(Outer, Inner, Offset)), ((factEmbeddedObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','EmbeddedObjectD','EmbeddedObjectD',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','EmbeddedObjectD','EmbeddedObjectD',(Outer, Inner, Offset), Arg])))).
check_EmbeddedObject_complete(Arg) :- forall((factEmbeddedObject(Outer, Inner, Offset)), ((snapshot((retract(factEmbeddedObject(Outer, Inner, Offset)), reasonEmbeddedObject(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','EmbeddedObject','EmbeddedObject',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','EmbeddedObject','EmbeddedObject',(Outer, Inner, Offset), Arg])))).
check_EmbeddedObjectB_complete(Arg) :- forall((factEmbeddedObject(Outer, Inner, Offset)), ((snapshot((retract(factEmbeddedObject(Outer, Inner, Offset)), reasonEmbeddedObject_B(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','EmbeddedObjectB','EmbeddedObjectB',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','EmbeddedObjectB','EmbeddedObjectB',(Outer, Inner, Offset), Arg])))).
check_EmbeddedObjectC_complete(Arg) :- forall((factEmbeddedObject(Outer, Inner, Offset)), ((snapshot((retract(factEmbeddedObject(Outer, Inner, Offset)), reasonEmbeddedObject_C(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','EmbeddedObjectC','EmbeddedObjectC',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','EmbeddedObjectC','EmbeddedObjectC',(Outer, Inner, Offset), Arg])))).
check_EmbeddedObjectD_complete(Arg) :- forall((factEmbeddedObject(Outer, Inner, Offset)), ((snapshot((retract(factEmbeddedObject(Outer, Inner, Offset)), reasonEmbeddedObject_D(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','EmbeddedObjectD','EmbeddedObjectD',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','EmbeddedObjectD','EmbeddedObjectD',(Outer, Inner, Offset), Arg])))).
check_ObjectInObject_sound(Arg) :- forall((reasonObjectInObject(Outer, Inner, Offset)), ((factObjectInObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObject','ObjectInObject',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObject','ObjectInObject',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectB_sound(Arg) :- forall((reasonObjectInObject_B(Outer, Inner, Offset)), ((factObjectInObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectB','ObjectInObjectB',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectB','ObjectInObjectB',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectC_sound(Arg) :- forall((reasonObjectInObject_C(Outer, Inner, Offset)), ((factObjectInObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectC','ObjectInObjectC',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectC','ObjectInObjectC',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectD_sound(Arg) :- forall((reasonObjectInObject_D(Outer, Inner, Offset)), ((factObjectInObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectD','ObjectInObjectD',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectD','ObjectInObjectD',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectE_sound(Arg) :- forall((reasonObjectInObject_E(Outer, Inner, Offset)), ((factObjectInObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectE','ObjectInObjectE',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectE','ObjectInObjectE',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectF_sound(Arg) :- forall((reasonObjectInObject_F(Outer, Inner, Offset)), ((factObjectInObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectF','ObjectInObjectF',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectF','ObjectInObjectF',(Outer, Inner, Offset), Arg])))).
check_ObjectInObject_complete(Arg) :- forall((factObjectInObject(Outer, Inner, Offset)), ((snapshot((retract(factObjectInObject(Outer, Inner, Offset)), reasonObjectInObject(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObject','ObjectInObject',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObject','ObjectInObject',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectB_complete(Arg) :- forall((factObjectInObject(Outer, Inner, Offset)), ((snapshot((retract(factObjectInObject(Outer, Inner, Offset)), reasonObjectInObject_B(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectB','ObjectInObjectB',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectB','ObjectInObjectB',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectC_complete(Arg) :- forall((factObjectInObject(Outer, Inner, Offset)), ((snapshot((retract(factObjectInObject(Outer, Inner, Offset)), reasonObjectInObject_C(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectC','ObjectInObjectC',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectC','ObjectInObjectC',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectD_complete(Arg) :- forall((factObjectInObject(Outer, Inner, Offset)), ((snapshot((retract(factObjectInObject(Outer, Inner, Offset)), reasonObjectInObject_D(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectD','ObjectInObjectD',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectD','ObjectInObjectD',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectE_complete(Arg) :- forall((factObjectInObject(Outer, Inner, Offset)), ((snapshot((retract(factObjectInObject(Outer, Inner, Offset)), reasonObjectInObject_E(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectE','ObjectInObjectE',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectE','ObjectInObjectE',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectF_complete(Arg) :- forall((factObjectInObject(Outer, Inner, Offset)), ((snapshot((retract(factObjectInObject(Outer, Inner, Offset)), reasonObjectInObject_F(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectF','ObjectInObjectF',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectF','ObjectInObjectF',(Outer, Inner, Offset), Arg])))).
check_MergeClasses_sound(Arg) :- forall((reasonMergeClasses(Member, Class)), ((find(Member, Class)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClasses','MergeClasses',(Member, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClasses','MergeClasses',(Member, Class), Arg])))).
check_MergeClassesB_sound(Arg) :- forall((reasonMergeClasses_B(Member, Class)), ((find(Member, Class)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesB','MergeClassesB',(Member, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesB','MergeClassesB',(Member, Class), Arg])))).
check_MergeClassesC_sound(Arg) :- forall((reasonMergeClasses_C(Member, Class)), ((find(Member, Class)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesC','MergeClassesC',(Member, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesC','MergeClassesC',(Member, Class), Arg])))).
check_MergeClassesE_sound(Arg) :- forall((reasonMergeClasses_E(Member, Class)), ((find(Member, Class)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesE','MergeClassesE',(Member, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesE','MergeClassesE',(Member, Class), Arg])))).
check_MergeClassesG_sound(Arg) :- forall((reasonMergeClasses_G(Member, Class)), ((find(Member, Class)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesG','MergeClassesG',(Member, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesG','MergeClassesG',(Member, Class), Arg])))).
check_MergeClassesH_sound(Arg) :- forall((reasonMergeClasses_H(Member, Class)), ((find(Member, Class)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesH','MergeClassesH',(Member, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesH','MergeClassesH',(Member, Class), Arg])))).
check_MergeClassesJ_sound(Arg) :- forall((reasonMergeClasses_J(Member, Class)), ((find(Member, Class)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesJ','MergeClassesJ',(Member, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesJ','MergeClassesJ',(Member, Class), Arg])))).
check_MergeClassesK_sound(Arg) :- forall((reasonMergeClasses_K(Member, Class)), ((find(Member, Class)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesK','MergeClassesK',(Member, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesK','MergeClassesK',(Member, Class), Arg])))).
check_MergeClasses_complete(Arg) :- forall((find(Member, Class)), ((snapshot((retractall(classArgs(factNOTMergeClasses/2, _)), retract(findint(Member, Class)), assert(findint(Member, Member)), (forall(fixupClasses(Class, Member, _, NewFact), assert(NewFact)); true), reasonMergeClasses(Member, Class)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClasses','MergeClasses',(Member, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClasses','MergeClasses',(Member, Class), Arg])))).
check_MergeClassesB_complete(Arg) :- forall((find(Member, Class)), ((snapshot((retractall(classArgs(factNOTMergeClasses/2, _)), retract(findint(Member, Class)), assert(findint(Member, Member)), (forall(fixupClasses(Class, Member, _, NewFact), assert(NewFact)); true), reasonMergeClasses_B(Member, Class)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesB','MergeClassesB',(Member, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesB','MergeClassesB',(Member, Class), Arg])))).
check_MergeClassesC_complete(Arg) :- forall((find(Member, Class)), ((snapshot((retractall(classArgs(factNOTMergeClasses/2, _)), retract(findint(Member, Class)), assert(findint(Member, Member)), (forall(fixupClasses(Class, Member, _, NewFact), assert(NewFact)); true), reasonMergeClasses_C(Member, Class)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesC','MergeClassesC',(Member, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesC','MergeClassesC',(Member, Class), Arg])))).
check_MergeClassesE_complete(Arg) :- forall((find(Member, Class)), ((snapshot((retractall(classArgs(factNOTMergeClasses/2, _)), retract(findint(Member, Class)), assert(findint(Member, Member)), (forall(fixupClasses(Class, Member, _, NewFact), assert(NewFact)); true), reasonMergeClasses_E(Member, Class)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesE','MergeClassesE',(Member, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesE','MergeClassesE',(Member, Class), Arg])))).
check_MergeClassesG_complete(Arg) :- forall((find(Member, Class)), ((snapshot((retractall(classArgs(factNOTMergeClasses/2, _)), retract(findint(Member, Class)), assert(findint(Member, Member)), (forall(fixupClasses(Class, Member, _, NewFact), assert(NewFact)); true), reasonMergeClasses_G(Member, Class)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesG','MergeClassesG',(Member, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesG','MergeClassesG',(Member, Class), Arg])))).
check_MergeClassesH_complete(Arg) :- forall((find(Member, Class)), ((snapshot((retractall(classArgs(factNOTMergeClasses/2, _)), retract(findint(Member, Class)), assert(findint(Member, Member)), (forall(fixupClasses(Class, Member, _, NewFact), assert(NewFact)); true), reasonMergeClasses_H(Member, Class)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesH','MergeClassesH',(Member, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesH','MergeClassesH',(Member, Class), Arg])))).
check_MergeClassesJ_complete(Arg) :- forall((find(Member, Class)), ((snapshot((retractall(classArgs(factNOTMergeClasses/2, _)), retract(findint(Member, Class)), assert(findint(Member, Member)), (forall(fixupClasses(Class, Member, _, NewFact), assert(NewFact)); true), reasonMergeClasses_J(Member, Class)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesJ','MergeClassesJ',(Member, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesJ','MergeClassesJ',(Member, Class), Arg])))).
check_MergeClassesK_complete(Arg) :- forall((find(Member, Class)), ((snapshot((retractall(classArgs(factNOTMergeClasses/2, _)), retract(findint(Member, Class)), assert(findint(Member, Member)), (forall(fixupClasses(Class, Member, _, NewFact), assert(NewFact)); true), reasonMergeClasses_K(Member, Class)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesK','MergeClassesK',(Member, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesK','MergeClassesK',(Member, Class), Arg])))).
check_NOTMergeClasses_sound(Arg) :- forall((reasonNOTMergeClasses(Class1, Class2)), ((class(Class1), class(Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClasses','NOTMergeClasses',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClasses','NOTMergeClasses',(Class1, Class2), Arg])))).
check_NOTMergeClassesJ_sound(Arg) :- forall((reasonNOTMergeClasses_J(Class1, Class2)), ((class(Class1), class(Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesJ','NOTMergeClassesJ',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesJ','NOTMergeClassesJ',(Class1, Class2), Arg])))).
check_NOTMergeClassesC_sound(Arg) :- forall((reasonNOTMergeClasses_C(Class1, Class2)), ((class(Class1), class(Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesC','NOTMergeClassesC',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesC','NOTMergeClassesC',(Class1, Class2), Arg])))).
check_NOTMergeClassesE_sound(Arg) :- forall((reasonNOTMergeClasses_E(Class1, Class2)), ((class(Class1), class(Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesE','NOTMergeClassesE',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesE','NOTMergeClassesE',(Class1, Class2), Arg])))).
check_NOTMergeClassesF_sound(Arg) :- forall((reasonNOTMergeClasses_F(Class1, Class2)), ((class(Class1), class(Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesF','NOTMergeClassesF',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesF','NOTMergeClassesF',(Class1, Class2), Arg])))).
check_NOTMergeClassesG_sound(Arg) :- forall((reasonNOTMergeClasses_G(Class1, Class2)), ((class(Class1), class(Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesG','NOTMergeClassesG',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesG','NOTMergeClassesG',(Class1, Class2), Arg])))).
check_NOTMergeClassesI_sound(Arg) :- forall((reasonNOTMergeClasses_I(Class1, Class2)), ((class(Class1), class(Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesI','NOTMergeClassesI',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesI','NOTMergeClassesI',(Class1, Class2), Arg])))).
check_NOTMergeClassesK_sound(Arg) :- forall((reasonNOTMergeClasses_K(Class1, Class2)), ((class(Class1), class(Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesK','NOTMergeClassesK',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesK','NOTMergeClassesK',(Class1, Class2), Arg])))).
check_NOTMergeClassesL_sound(Arg) :- forall((reasonNOTMergeClasses_L(Class1, Class2)), ((class(Class1), class(Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesL','NOTMergeClassesL',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesL','NOTMergeClassesL',(Class1, Class2), Arg])))).
check_NOTMergeClassesM_sound(Arg) :- forall((reasonNOTMergeClasses_M(Class1, Class2)), ((class(Class1), class(Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesM','NOTMergeClassesM',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesM','NOTMergeClassesM',(Class1, Class2), Arg])))).
check_NOTMergeClassesO_sound(Arg) :- forall((reasonNOTMergeClasses_O(Class1, Class2)), ((class(Class1), class(Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesO','NOTMergeClassesO',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesO','NOTMergeClassesO',(Class1, Class2), Arg])))).
check_NOTMergeClassesP_sound(Arg) :- forall((reasonNOTMergeClasses_P(Class1, Class2)), ((class(Class1), class(Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesP','NOTMergeClassesP',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesP','NOTMergeClassesP',(Class1, Class2), Arg])))).
check_NOTMergeClassesQ_sound(Arg) :- forall((reasonNOTMergeClasses_Q(Class1, Class2)), ((class(Class1), class(Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesQ','NOTMergeClassesQ',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesQ','NOTMergeClassesQ',(Class1, Class2), Arg])))).
check_NOTMergeClassesR_sound(Arg) :- forall((reasonNOTMergeClasses_R(Class1, Class2)), ((class(Class1), class(Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesR','NOTMergeClassesR',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesR','NOTMergeClassesR',(Class1, Class2), Arg])))).
check_NOTMergeClasses_complete(Arg) :- forall((class(Class1), class(Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClasses','NOTMergeClasses',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClasses','NOTMergeClasses',(Class1, Class2), Arg])))).
check_NOTMergeClassesJ_complete(Arg) :- forall((class(Class1), class(Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_J(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesJ','NOTMergeClassesJ',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesJ','NOTMergeClassesJ',(Class1, Class2), Arg])))).
check_NOTMergeClassesC_complete(Arg) :- forall((class(Class1), class(Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_C(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesC','NOTMergeClassesC',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesC','NOTMergeClassesC',(Class1, Class2), Arg])))).
check_NOTMergeClassesE_complete(Arg) :- forall((class(Class1), class(Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_E(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesE','NOTMergeClassesE',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesE','NOTMergeClassesE',(Class1, Class2), Arg])))).
check_NOTMergeClassesF_complete(Arg) :- forall((class(Class1), class(Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_F(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesF','NOTMergeClassesF',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesF','NOTMergeClassesF',(Class1, Class2), Arg])))).
check_NOTMergeClassesG_complete(Arg) :- forall((class(Class1), class(Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_G(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesG','NOTMergeClassesG',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesG','NOTMergeClassesG',(Class1, Class2), Arg])))).
check_NOTMergeClassesI_complete(Arg) :- forall((class(Class1), class(Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_I(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesI','NOTMergeClassesI',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesI','NOTMergeClassesI',(Class1, Class2), Arg])))).
check_NOTMergeClassesK_complete(Arg) :- forall((class(Class1), class(Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_K(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesK','NOTMergeClassesK',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesK','NOTMergeClassesK',(Class1, Class2), Arg])))).
check_NOTMergeClassesL_complete(Arg) :- forall((class(Class1), class(Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_L(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesL','NOTMergeClassesL',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesL','NOTMergeClassesL',(Class1, Class2), Arg])))).
check_NOTMergeClassesM_complete(Arg) :- forall((class(Class1), class(Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_M(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesM','NOTMergeClassesM',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesM','NOTMergeClassesM',(Class1, Class2), Arg])))).
check_NOTMergeClassesO_complete(Arg) :- forall((class(Class1), class(Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_O(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesO','NOTMergeClassesO',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesO','NOTMergeClassesO',(Class1, Class2), Arg])))).
check_NOTMergeClassesP_complete(Arg) :- forall((class(Class1), class(Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_P(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesP','NOTMergeClassesP',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesP','NOTMergeClassesP',(Class1, Class2), Arg])))).
check_NOTMergeClassesQ_complete(Arg) :- forall((class(Class1), class(Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_Q(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesQ','NOTMergeClassesQ',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesQ','NOTMergeClassesQ',(Class1, Class2), Arg])))).
check_NOTMergeClassesR_complete(Arg) :- forall((class(Class1), class(Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_R(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesR','NOTMergeClassesR',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesR','NOTMergeClassesR',(Class1, Class2), Arg])))).
check_ClassCallsMethod_sound(Arg) :- forall((reasonClassCallsMethod(Class, Method, Offset)), ((factClassCallsMethod(Class, Method, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassCallsMethod','ClassCallsMethod',(Class, Method, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassCallsMethod','ClassCallsMethod',(Class, Method, Offset), Arg])))).
check_ClassCallsMethodB_sound(Arg) :- forall((reasonClassCallsMethod_B(Class, Method, Offset)), ((factClassCallsMethod(Class, Method, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassCallsMethodB','ClassCallsMethodB',(Class, Method, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassCallsMethodB','ClassCallsMethodB',(Class, Method, Offset), Arg])))).
check_ClassCallsMethodC_sound(Arg) :- forall((reasonClassCallsMethod_C(Class, Method, Offset)), ((factClassCallsMethod(Class, Method, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassCallsMethodC','ClassCallsMethodC',(Class, Method, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassCallsMethodC','ClassCallsMethodC',(Class, Method, Offset), Arg])))).
check_ClassCallsMethod_complete(Arg) :- forall((factClassCallsMethod(Class, Method, Offset)), ((snapshot((retract(factClassCallsMethod(Class, Method, Offset)), reasonClassCallsMethod(Class, Method, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ClassCallsMethod','ClassCallsMethod',(Class, Method, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ClassCallsMethod','ClassCallsMethod',(Class, Method, Offset), Arg])))).
check_ClassCallsMethodB_complete(Arg) :- forall((factClassCallsMethod(Class, Method, Offset)), ((snapshot((retract(factClassCallsMethod(Class, Method, Offset)), reasonClassCallsMethod_B(Class, Method, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ClassCallsMethodB','ClassCallsMethodB',(Class, Method, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ClassCallsMethodB','ClassCallsMethodB',(Class, Method, Offset), Arg])))).
check_ClassCallsMethodC_complete(Arg) :- forall((factClassCallsMethod(Class, Method, Offset)), ((snapshot((retract(factClassCallsMethod(Class, Method, Offset)), reasonClassCallsMethod_C(Class, Method, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ClassCallsMethodC','ClassCallsMethodC',(Class, Method, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ClassCallsMethodC','ClassCallsMethodC',(Class, Method, Offset), Arg])))).
check_CertainConstructorOrDestructor_sound(Arg) :- forall((certainConstructorOrDestructor(M)), (((factConstructor(M); factRealDestructor(M); factDeletingDestructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','CertainConstructorOrDestructor','CertainConstructorOrDestructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','CertainConstructorOrDestructor','CertainConstructorOrDestructor',(M), Arg])))).
check_CertainConstructorOrDestructor_complete(Arg) :- forall(((factConstructor(M); factRealDestructor(M); factDeletingDestructor(M))), ((snapshot((ignore(retract(factConstructor(M))), ignore(retract(factRealDestructor(M))), ignore(retract(realDeletingDestructor(M))), certainConstructorOrDestructor(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','CertainConstructorOrDestructor','CertainConstructorOrDestructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','CertainConstructorOrDestructor','CertainConstructorOrDestructor',(M), Arg])))).
