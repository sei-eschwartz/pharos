% Copyright 2017-2020 Carnegie Mellon University.
% ============================================================================================
% Guessing rules.
% ============================================================================================

% TODO
% Should we use minof everywhere?
% Many cuts in this file are useless.

:- use_module(library(apply), [maplist/2]).
:- use_module(library(lists), [member/2, append/3]).

take(N, List, Prefix) :-
    length(Prefix, N),
    append(Prefix, _, List).

% We could consolidate reportFirstSeen here, but there might be some overhead from getting the
% predicate name?
reportGuess(Fact, Rule) :-
    countGuess,
    loginfoln('Guessing ~Q.', Fact),
    logtraceln('~Q proposing ~Q.', [Rule, Fact]).

% Because of the way that we're mixing specific guessing rules with more general guessing
% rules, SWI Prolog is complaining about non-contiugous rules, like so:
%   Clauses of Name/Arity are not together in the source-file
% This directive supresses those errors.
:- discontiguous(guessMethod/1).
:- discontiguous(guessConstructor/1).
:- discontiguous(guessClassHasNoBase/1).
:- discontiguous(guessMergeClasses/1).
:- discontiguous(guessLateMergeClasses/1).


countGuess :-
    delta_con(guesses, 1).

countGuess :-
    delta_con(guesses, -1),
    fail.

% Do not guess if either fact is already true, or if doNotGuess(Fact) exists.
:- meta_predicate
    doNotGuessHelper(0,0).
doNotGuessHelper(Fact, Fact2) :-
    (   block_deps(Fact)
    ->  fail
    ;   block_deps(doNotGuess(Fact))
    ->  fail
    ;   block_deps(Fact2)
    ->  fail
    ;   block_deps(doNotGuess(Fact2))
    ->  fail
    ;   true
    ).

% ejs 2/11/2021
% Guesses now return a list of guess goals that will be tried in order.

upstreamFail(Pos, _Neg) :-
    logwarnln('Something is wrong upstream: ~Q', Pos),
    fail.

tryOrNot(Pos, Neg, [Pos, Neg, upstreamFail(Pos, Neg)]).

% --------------------------------------------------------------------------------------------
% Try guessing that a virtual function call is correctly interpreted.
% --------------------------------------------------------------------------------------------
guessVirtualFunctionCall(Out) :-
    reportFirstSeen('guessVirtualFunctionCall'),
    minof((Insn, Constructor, OOffset, VFTable, VOffset),
          (likelyVirtualFunctionCall(Insn, Constructor, OOffset, VFTable, VOffset),
           not(factNOTConstructor(Constructor)),
           doNotGuessHelper(
                   factVirtualFunctionCall(Insn, Constructor, OOffset, VFTable, VOffset),
                   factNOTVirtualFunctionCall(Insn, Constructor, OOffset, VFTable, VOffset)))),

    tryOrNot(tryVirtualFunctionCall(Insn, Constructor, OOffset, VFTable, VOffset, guessVirtualFunctionCall),
             tryVirtualFunctionCall(Insn, Constructor, OOffset, VFTable, VOffset, guessVirtualFunctionCall),
             Out).

tryVirtualFunctionCall(Insn, Method, OOffset, VFTable, VOffset, Rule) :-
    reportGuess(factVirtualFunctionCall(Insn, Method, OOffset, VFTable, VOffset), Rule),
    try_assert(factVirtualFunctionCall(Insn, Method, OOffset, VFTable, VOffset)),
    try_assert(guessedVirtualFunctionCall(Insn, Method, OOffset, VFTable, VOffset)).

tryNOTVirtualFunctionCall(Insn, Method, OOffset, VFTable, VOffset, Rule) :-
    reportGuess(factNOTVirtualFunctionCall(Insn, Method, OOffset, VFTable, VOffset), Rule),
    try_assert(factNOTVirtualFunctionCall(Insn, Method, OOffset, VFTable, VOffset)),
    try_assert(guessedNOTVirtualFunctionCall(Insn, Method, OOffset, VFTable, VOffset)).

% --------------------------------------------------------------------------------------------
% Try guessing that a virtual function table is correctly identified.
% --------------------------------------------------------------------------------------------

guessVFTable(Out) :-
    reportFirstSeen('guessVFTable'),
    % See the commentary at possibleVFTable for how this goal constrains our guesses (and
    % ordering).
    possibleVFTable(VFTable),
    doNotGuessHelper(factVFTable(VFTable),
                     factNOTVFTable(VFTable)),

    tryOrNot(tryVFTable(VFTable, guessVFTable),
             tryNOTVFTable(VFTable, guessVFTable),
             Out).

tryVFTable(VFTable, Rule) :-
    reportGuess(factVFTable(VFTable), Rule),
    try_assert(factVFTable(VFTable)),
    try_assert(guessedVFTable(VFTable)),
    make(VFTable).

tryNOTVFTable(VFTable, Rule) :-
    reportGuess(factNOTVFTable(VFTable), Rule),
    try_assert(factNOTVFTable(VFTable)),
    try_assert(guessedNOTVFTable(VFTable)).


% --------------------------------------------------------------------------------------------
% Try guessing that a virtual base table is correctly identified.
% --------------------------------------------------------------------------------------------
guessVBTable(Out) :-
    reportFirstSeen('guessVBTable'),
    validVBTableWrite(_Insn, Method, _Offset, VBTable),
    factMethod(Method),
    doNotGuessHelper(factVBTable(VBTable),
                     factNOTVBTable(VBTable)),

    tryOrNot(tryVBTable(VBTable, guessVBTable),
             tryNOTVBTable(VBTable, guessVBTable),
             Out).

tryVBTable(VBTable, Rule) :-
    reportGuess(factVBTable(VBTable), Rule),
    try_assert(factVBTable(VBTable)),
    try_assert(guessedVBTable(VBTable)).

tryNOTVBTable(VBTable, Rule) :-
    reportGuess(factNOTVBTable(VBTable), Rule),
    try_assert(factNOTVBTable(VBTable)),
    try_assert(guessedNOTVBTable(VBTable)).

% --------------------------------------------------------------------------------------------
% Try guessing that a virtual function table entry is valid.
% --------------------------------------------------------------------------------------------

prioritizedVFTableEntry(VFTable, Offset, Entry) :-
    % First establish that the guess meets minimal requirements.
    possibleVFTableEntry(VFTable, Offset, Entry),
    factVFTable(VFTable),
    % Then that it's not already proved or disproved.
    doNotGuessHelper(factVFTableEntry(VFTable, Offset, Entry),
                     factNOTVFTableEntry(VFTable, Offset, Entry)).

% First priority guess, when we already know Entry is an OO method.
guessVFTableEntry1(VFTable, Offset, Entry) :-
    % Choose a prioritized VFTable entry to guess.
    prioritizedVFTableEntry(VFTable, Offset, Entry),

    % Prioritize guesses where we know that the method is actually an OO method first.  This
    % means that we're not really guessing whether this is a valid entry, we're just guessing
    % whether it's a valid entry in _this_ table.  This is a very safe guess.
    (factMethod(Entry); purecall(Entry)),

    % Prioritize guessing the largest likely offset first.  This clause leads to make fewer
    % guesses that that imply all of the smaller offsets.  This turns out to be important from
    % a performance perspective because it reduces the number of times we need to check the
    % entire system against the valid solution constraints.
    not((prioritizedVFTableEntry(VFTable, LargerOffset, _OtherEntry), LargerOffset > Offset)).

% Second priority guess, when we also have to guess that Entry is an OO method.
guessVFTableEntry2(VFTable, Offset, Entry) :-
    % Choose a prioritized VFTable entry to guess.
    prioritizedVFTableEntry(VFTable, Offset, Entry),

    % While using a weaker standard than the previous VFTableEntry guessing rule, this is also
    % reasonably safe, because we're only guessing entries where there's a plausible case that
    % the Entry is at least a function, and also probably a method.  This guess should be
    % eliminated in favor of the previous rule if possible, but in at least one case in the
    % test suite, we still need this rule because the last entry in the VFTable has no other
    % references and so we miss it entirely without this rule.
    possibleMethod(Entry),

    % Prioritize guessing the largest likely offset first.  This clause leads to make fewer
    % guesses that that imply all of the smaller offsets.  This turns out to be important from
    % a performance perspective because it reduces the number of times we need to check the
    % entire system against the valid solution constraints.
    not((prioritizedVFTableEntry(VFTable, LargerOffset, _OtherEntry), LargerOffset > Offset)).

guessVFTableEntry(Out) :-
    reportFirstSeen('guessVFTableEntry'),
    guessVFTableEntry1(VFTable, Offset, Entry),

    tryOrNot(tryVFTableEntry(VFTable, Offset, Entry, guessVFTableEntry1),
             tryNOTVFTableEntry(VFTable, Offset, Entry, guessVFTableEntry1),
             Out).

guessVFTableEntry(Out) :-
    guessVFTableEntry2(VFTable, Offset, Entry),

    tryOrNot(tryVFTableEntry(VFTable, Offset, Entry, guessVFTableEntry2),
             tryNOTVFTableEntry(VFTable, Offset, Entry, guessVFTableEntry2),
             Out).

tryVFTableEntry(VFTable, Offset, Entry, Rule) :-
    reportGuess(factVFTableEntry(VFTable, Offset, Entry), Rule),
    try_assert(factVFTableEntry(VFTable, Offset, Entry)),
    try_assert(guessedVFTableEntry(VFTable, Offset, Entry)).

tryNOTVFTableEntry(VFTable, Offset, Entry, Rule) :-
    reportGuess(factNOTVFTableEntry(VFTable, Offset, Entry), Rule),
    try_assert(factNOTVFTableEntry(VFTable, Offset, Entry)),
    try_assert(guessedNOTVFTableEntry(VFTable, Offset, Entry)).

% --------------------------------------------------------------------------------------------
% Try guessing that an embedded object offset zero is really an inheritance relationship.
% ED_PAPER_INTERESTING
% --------------------------------------------------------------------------------------------
guessDerivedClass(DerivedClass, BaseClass, Offset) :-
    reportFirstSeen('guessDerivedClass'),
    factObjectInObject(DerivedClass, BaseClass, Offset),
    is_current(DerivedClass),
    is_current(BaseClass),
    % Over time we've had a lot of different theories about whether we intended to limit this
    % guess to offset zero.  This logic says that the offset must either be zero, or have a
    % proven instance of inheritance at a lower address already.  This isn't strictly correct,
    % but it's sufficient to prevent the rule from making guesses in a really bad order (higher
    % offsets before offset zero).  We can tighten it further in the future, if needed.
    (Offset = 0; (factDerivedClass(DerivedClass, _BaseClass2, LowerO), LowerO < Offset)),
    doNotGuessHelper(factDerivedClass(DerivedClass, BaseClass, Offset),
                     factEmbeddedObject(DerivedClass, BaseClass, Offset)).

guessDerivedClass(Out) :-
    guessDerivedClass(DerivedClass, BaseClass, Offset),

    tryOrNot(tryDerivedClass(DerivedClass, BaseClass, Offset, guessDerivedClass),
             tryEmbeddedObject(DerivedClass, BaseClass, Offset, guessDerivedClass),
             Out).

tryEmbeddedObject(OuterClass, InnerClass, Offset, Rule) :-
    reportGuess(factEmbeddedObject(OuterClass, InnerClass, Offset), Rule),
    try_assert(factEmbeddedObject(OuterClass, InnerClass, Offset)),
    try_assert(guessedEmbeddedObject(OuterClass, InnerClass, Offset)).

tryDerivedClass(DerivedClass, BaseClass, Offset, Rule) :-
    reportGuess(factDerivedClass(DerivedClass, BaseClass, Offset), Rule),
    try_assert(factDerivedClass(DerivedClass, BaseClass, Offset)),
    try_assert(guessedDerivedClass(DerivedClass, BaseClass, Offset)).

%% guessEmbeddedObject :-
%%     % It's very clear that we don't want to restrict embedded objects to offset zero.  Perhaps
%%     % we'll eventually find that this rule and guessDerivedClass are really the same.
%%     factObjectInObject(DerivedClass, BaseClass, Offset),
%%     not(factDerivedClass(DerivedClass, BaseClass, Offset)),
%%     not(factEmbeddedObject(DerivedClass, BaseClass, Offset)),
%%     (
%%         % Only here we're guessing embedded object first!
%%         tryEmbeddedObject(DerivedClass, BaseClass, Offset);
%%         tryDerivedClass(DerivedClass, BaseClass, Offset);
%%         logwarnln('Something is wrong upstream: ~Q.',
%%                   invalidEmbeddedObject(DerivedClass, BaseClass, Offset)),
%%         fail
%%     ).

% --------------------------------------------------------------------------------------------
% Try guessing that an address is really method.
% --------------------------------------------------------------------------------------------

% This guess was: callingConvention(Method, '__thiscall'), methodMemberAccess(_I, M, O, _S)...
%
% But changing it to require validMethodMemberAccess is complete nonense, because we're now
% _requiring_ that factMethod() be true for the member access to be valid.  The size filter in
% this rule is more restrictive than the one in validMethodMemberAccess, so we're not really
% losing anything by testing the unvalidated member access.
%
% Requiring a validMethodMemberAccess is essentialy requiring that something in the object be
% accessed in the method.  The justification for using 100 as the limit for the offset size
% here is a bit complicated, but basically the thinking is that medium sized accesses are
% usually accompanied by at least one small access, and we can exclude a few more false
% positives by reducing the limit further beyond what would obviously be too limiting for
% validMethodMemberAccess.
guessMethodA(Method) :-
    callingConvention(Method, '__thiscall'),
    doNotGuessHelper(factMethod(Method),
                     factNOTMethod(Method)),
    % Intentionally use the _unvalidated_ access to guess that the Method is actually object
    % oriented.  This will be a problem as we export more facts where we don't have the correct
    % calling convention data (e.g. Linux executables)
    methodMemberAccess(_Insn, Method, Offset, _Size),
    Offset < 100.

guessMethod(Out) :-
    reportFirstSeen('guessMethod'),
    guessMethodA(Method),

    tryOrNot(tryMethod(Method, guessMethodA),
             tryNOTMethod(Method, guessMethodA),
             Out).

guessMethodB(Method) :-
    factMethod(Caller),
    % It is sufficient for __thiscall to be possible, since our confidence derives from Caller.
    % This rule currently needs to permit the slightly different ECX parameter standard.
    % This bug is wrapped up in std::_Yarn and std::locale in Lite/ooex7 (and oo and poly).
    (callingConvention(Caller, '__thiscall'); callingConvention(Caller, 'invalid')),
    funcParameter(Caller, 'ecx', ThisPtr1),
    thisPtrOffset(ThisPtr1, _Offset, ThisPtr2),
    thisPtrUsage(_Insn1, Caller, ThisPtr2, Method),
    doNotGuessHelper(factMethod(Method),
                     factNOTMethod(Method)).

% Guess that calls passed offsets into existing objects are methods.  This rule is not
% literally true, but objects are commonly in other objects.
guessMethod(Out) :-
    guessMethodB(Method),

    tryOrNot(tryMethod(Method, guessMethodB),
             tryNOTMethod(Method, guessMethodB),
             Out).

% This guess is required (at least for our test suite) in cases where there's no certainty in
% the calling convention, and effectively no facts that would allow us to reach the conclusion
% logically.
% ED_PAPER_INTERESTING
guessMethodC(Method) :-
    callingConvention(Method, '__thiscall'),
    doNotGuessHelper(factMethod(Method),
                     factNOTMethod(Method)),
    % Also intentionally an unvalidated methodMemberAccess because we're guessing the
    % factMethod() that is required for the validMethodMemberAccess.
    methodMemberAccess(_Insn1, Method, Offset, _Size1),
    Offset < 100,
    validFuncOffset(_Insn2, Caller, Method, _Size2),
    factMethod(Caller).

guessMethod(Out) :-
    guessMethodC(Method),

    tryOrNot(tryMethod(Method, guessMethodC),
             tryNOTMethod(Method, guessMethodC),
             Out).

% More kludgy guessing rules. :-( This one is based on thre premise that a cluster of three or
% more nearly OO methods is not a conincidence. A better fix would be for at least one of the
% methods to be detected unambiguously as __thiscall, or to find dataflow from an already true
% method.
:- table guessMethodD/1 as incremental.
guessMethodD(Method) :-
    callingConvention(Method, '__thiscall'),
    doNotGuessHelper(factMethod(Method),
                     factNOTMethod(Method)),
    validMethodMemberAccess(_Insn0, Method, Offset, _Size0),
    Offset < 100,
    validFuncOffset(_Insn1, Caller1, Method, _Size1),
    validFuncOffset(_Insn2, Caller2, Method, _Size2),
    iso_dif(Caller1, Caller2),
    validFuncOffset(_Insn3, Caller3, Method, _Size3),
    iso_dif(Caller1, Caller3).

guessMethod(Out) :-
    guessMethodD(Method),
    tryOrNot(tryMethod(Method, guessMethodD),
             tryNOTMethod(Method, guessMethodD),
             Out).

% A variation of the previous rule using thisPtrUsage and passing around a this-pointer to
% multiple methods.  Just guess the first and the rest will follow...
:- table guessMethodE/1 as incremental.
guessMethodE(Method) :-
    callingConvention(Method, '__thiscall'),
    doNotGuessHelper(factMethod(Method),
                     factNOTMethod(Method)),
    validMethodMemberAccess(_Insn0, Method, Offset, _Size0),
    Offset < 100,
    thisPtrUsage(_Insn1, Caller, ThisPtr, Method),
    thisPtrUsage(_Insn2, Caller, ThisPtr, Method2),
    iso_dif(Method, Method2),
    thisPtrUsage(_Insn3, Caller, ThisPtr, Method3),
    iso_dif(Method, Method3).


guessMethod(Out) :-
    guessMethodE(Method),

    tryOrNot(tryMethod(Method, guessMethodE),
             tryNOTMethod(Method, guessMethodE),
             Out).

% Another case where we're trying to implement the reasoning that there's a lot of stuff
% suggesting that it's a method.  In this case, it's a possible constructor with memory
% accesses.
guessMethodF(Method) :-
    callingConvention(Method, '__thiscall'),
    doNotGuessHelper(factMethod(Method),
                     factNOTMethod(Method)),
    validMethodMemberAccess(_Insn1, Method, Offset, _Size1),
    Offset < 100,
    (possibleConstructor(Method); possibleDestructor(Method)).

guessMethod(Out) :-
    guessMethodF(Method),

    tryOrNot(tryMethod(Method, guessMethodF),
             tryNOTMethod(Method, guessMethodF),
             Out).

% Also guess possible constructors and destructors with calls from known methods.
guessMethodG(Method) :-
    callingConvention(Method, '__thiscall'),
    doNotGuessHelper(factMethod(Method),
                     factNOTMethod(Method)),
    thisPtrUsage(_Insn, Caller, _ThisPtr2, Method),
    factMethod(Caller),
    (possibleConstructor(Method); possibleDestructor(Method)).

guessMethod(Out) :-
    guessMethodG(Method),

    tryOrNot(tryMethod(Method, guessMethodG),
             tryNOTMethod(Method, guessMethodG),
             Out).

tryMethod(Method, Rule) :-
    reportGuess(factMethod(Method), Rule),
    try_assert(factMethod(Method)),
    try_assert(guessedMethod(Method)),
    make(Method).

tryNOTMethod(Method, Rule) :-
    reportGuess(factNOTMethod(Method), Rule),
    try_assert(factNOTMethod(Method)),
    try_assert(guessedNOTMethod(Method)).

% --------------------------------------------------------------------------------------------
% Try guessing that method is a constructor.
% --------------------------------------------------------------------------------------------

% Prefer guessing methods that have confirmed vftable writes first?  It's not clear that this
% was needed, but it doesn't seem harmful provided that we backtrack correctly (and not
% repeatedly, which is why I added the cut).

% We have three approximate indicators of constructor-ness:
%
% 1. The method appears in a _possible_ VFTable, which is strongly negative because we can't
%    presently propose any legitimate reason why that should happen if the method was truly a
%    constructor.
%
% 2. The method has VFTable writes which proves that it's either a constructor or destructor,
%    making our guess much better (at least 50/50) and probably even better if the next
%    indicator is also true.
%
% 3. The method has reads of members that it did not initialize.  This is not allowed for
%    constructors unless the method called the parent constructor which initialized the member.
%    While not impossible this situation is less likely (and probably eliminates many
%    destructors).  Guessing NOTConstructor based on uninitialized reads doesn't work because
%    we have test cases that initialize dervied members from base members.
%
% We're going to prioritize them in roughly that order...  There's still some debate about the
% optimal order of the latter two incicators based on various arguments which cases are more
% common and so forth...

% Perfect virtual case, not in a vftable, writes a vftable, and has no uninitalized reads.
% ED_PAPER_INTERESTING
guessConstructor1(Method) :-
    factMethod(Method),
    possibleConstructor(Method),
    not(possiblyVirtual(Method)),
    factVFTableWrite(_Insn, Method, _ObjectOffset, _VFTable2),
    not(uninitializedReads(Method)),
    doNotGuessHelper(factConstructor(Method),
                     factNOTConstructor(Method)).

guessConstructor(Out) :-
    reportFirstSeen('guessConstructor'),
    guessConstructor1(Method),

    tryOrNot(tryConstructor(Method, guessConstructor1),
             tryNOTConstructor(Method, guessConstructor1),
             Out).

% Likely virtual case, not in a vftable, writes a vftable, but has unitialized reads.
guessConstructor2(Method) :-
    factMethod(Method),
    possibleConstructor(Method),
    not(possiblyVirtual(Method)),
    factVFTableWrite(_Insn, Method, _ObjectOffset, _VFTable2),
    % We don't whether their were unitialized reads or not.  Presumably we called our parent
    % constructor (which kind of makes sense giving that we've already got virtual methods).
    doNotGuessHelper(factConstructor(Method),
                     factNOTConstructor(Method)).

guessConstructor(Out) :-
    guessConstructor2(Method),

    tryOrNot(tryConstructor(Method, guessConstructor2),
             tryNOTConstructor(Method, guessConstructor2),
             Out).

% Normal non-virtual case, not in a vftable, doesn't write a vftable, and has no uninitialized
% reads.
% ED_PAPER_INTERESTING
guessConstructor3(Method) :-
    factMethod(Method),
    possibleConstructor(Method),
    not(possiblyVirtual(Method)),
    % This case is for constructors of non-virtual classes.
    not(uninitializedReads(Method)),
    doNotGuessHelper(factConstructor(Method),
                     factNOTConstructor(Method)).

guessConstructor(Out) :-
    guessConstructor3(Method),

    tryOrNot(tryConstructor(Method, guessConstructor3),
             tryNOTConstructor(Method, guessConstructor3),
             Out).

% Unusual non-virtual case presumably with inheritance -- not in a vftable, doesn't write a
% vftable, but has uninitialized reads.  It's very likely that this class has a base, but we
% don't capture that implication well right now.
guessConstructor4(Method) :-
    factMethod(Method),
    possibleConstructor(Method),
    not(possiblyVirtual(Method)),
    % This case is for constructors of non-virtual classes with uninitalized reads.
    doNotGuessHelper(factConstructor(Method),
                     factNOTConstructor(Method)).

guessUnlikelyConstructor(Out) :-
    reportFirstSeen('guessUnlikelyConstructor'),
    guessConstructor4(Method),

    tryOrNot(tryConstructor(Method, guessConstructor4),
             tryNOTConstructor(Method, guessConstructor4),
             Out).

tryConstructor(Method, Rule) :-
    reportGuess(factConstructor(Method), Rule),
    try_assert(factConstructor(Method)),
    try_assert(guessedConstructor(Method)).

tryNOTConstructor(Method, Rule) :-
    reportGuess(factNOTConstructor(Method), Rule),
    try_assert(factNOTConstructor(Method)),
    try_assert(guessedNOTConstructor(Method)).

% --------------------------------------------------------------------------------------------
% Try guessing that constructor has no base class.
% --------------------------------------------------------------------------------------------

% First guess constructors with a single VFTable write...  Because constructors with multiple
% vftable writes are more likely to have base classes.
% ED_PAPER_INTERESTING
guessClassHasNoBaseB(Class) :-
    factConstructor(Constructor),
    find_current(Constructor, Class),

    factVFTableWrite(_Insn1, Constructor, 0, VFTable),
    not((
               factVFTableWrite(_Insn2, Constructor, _Offset1, OtherVFTable),
               iso_dif(VFTable, OtherVFTable)
       )),

    not(factDerivedClass(Class, _BaseClass, _Offset2)),
    doNotGuessHelper(factClassHasNoBase(Class),
                     factClassHasUnknownBase(Class)).

guessClassHasNoBase(Out) :-
    reportFirstSeen('guessClassHasNoBase'),
    guessClassHasNoBaseB(Class),

    tryOrNot(tryClassHasNoBase(Class, guessClassHasNoBaseB),
             tryClassHasUnknownBase(Class, guessClassHasNoBaseB),
             Out).


% Then guess classes regardless of their VFTable writes.
% ED_PAPER_INTERESTING
guessClassHasNoBaseC(Class) :-
    factConstructor(Constructor),
    find_current(Constructor, Class),
    not(factDerivedClass(Class, _BaseClass, _Offset)),
    doNotGuessHelper(factClassHasNoBase(Class),
                     factClassHasUnknownBase(Class)).

guessClassHasNoBase(Out) :-
    guessClassHasNoBaseC(Class),

    tryOrNot(tryClassHasNoBase(Class, guessClassHasNoBaseC),
             tryClassHasUnknownBase(Class, guessClassHasNoBaseC),
             Out).

tryClassHasNoBase(Class, Rule) :-
    reportGuess(factClassHasNoBase(Class), Rule),
    try_assert(factClassHasNoBase(Class)),
    try_assert(guessedClassHasNoBase(Class)).

tryClassHasUnknownBase(Class, Rule) :-
    reportGuess(factClassHasUnknownBase(Class), Rule),
    try_assert(factClassHasUnknownBase(Class)),
    try_assert(guessedClassHasUnknownBase(Class)).


% This is also used to guess factClassHasNoBase, but is one of the last guesses made in the
% system.  The idea is simply to guess factClassHasNoBase for any class that does not have an
% identified base.
guessClassHasNoBaseSpecial(Class) :-
    % Class is a class
    class_current(Class),

    % Class does not have any base classes
    not(factDerivedClass(Class, _Base, _Offset)),

    % XXX: If we're at the end of reasoning and there is an unknown base, is that OK?  Should
    % we leave it as is?  Try really hard to make a guess?  Or treat it as a failure?
    doNotGuessHelper(factClassHasNoBase(Class),
                     factClassHasUnknownBase(Class)).

guessCommitClassHasNoBase(Out) :-
    reportFirstSeen('guessCommitClassHasNoBase'),
    guessClassHasNoBaseSpecial(Class),

    tryOrNot(tryClassHasNoBase(Class, guessCommitClassHasNoBase),
             tryClassHasUnknownBase(Class, guessCommitClassHasNoBase),
             Out).

% The following merge guesses should occur late so that we can identify all classes which have
% base classes.  This will allow the best guesses from guessLateMergeClassesF1 to fire.
% guessLateMergeClassesF2 then makes the remaining guesses for singleton methods in vftables of
% derived classes.

% We previously tried to make these guesses using HasNoBase, which often comes from
% guessCommitClassHasNoBase.  But we observed instances where HasNoBase would be guessed
% incorrectly on a singleton class, which would then prevent the singleton from being correctly
% merged to its vftable.  So we instead wait for a while and use the absence of a base class as
% the criterion for F1.

% If we have VFTable that is NOT associated with a class because there's no factVFTableWrite,
% factClassCallsMethod is not true...  The problem here is that we don't which method call
% which other methods (the direction of the call).  But we still have a very strong suggestion
% that methods in the VFTable are related in someway.  As a guessing rule a reasonable
% compromize is to say that any class that is still assigned to itself, is better off (from an
% edit distance perspective) grouped with the otehr methods.
guessLateMergeClassesF2(Class, Method) :-
    % There are two different entries in the same VFTable...
    reasonMethodInVFTable(VFTable, _Offset1, Method),

    % One of the methods is in a class all by itself right now.
    findall(Method, [Method]),
    findVFTable_current(VFTable, Class),

    checkMergeClasses(Class, Method).

guessLateMergeClassesF1(Class, Method) :-
    guessLateMergeClassesF2(Class, Method),

    % If a method is in the vftable of a derived and base class, we should give priority to the
    % base class.
    not(factDerivedClass(Class, _BaseClass, _Offset)).

guessLateMergeClasses(Out) :-
    reportFirstSeen('guessLateMergeClassesF1'),
    minof((Class, Method),
          guessLateMergeClassesF1(Class, Method)),
    !,

    tryOrNot(tryMergeClasses(Class, Method, guessLateMergeClasses1),
             tryNOTMergeClasses(Class, Method, guessLateMergeClasses1),
             Out).

guessLateMergeClasses(Out) :-
    reportFirstSeen('guessLateMergeClassesF2'),
    minof((Class, Method),
          guessLateMergeClassesF2(Class, Method)),
    !,

    tryOrNot(tryMergeClasses(Class, Method, guessLateMergeClasses2),
             tryNOTMergeClasses(Class, Method, guessLateMergeClasses2),
             Out).

% ejs 1/27/21 This rule used to be a normal merge guess instead of a late merge guess.  But we
% ran into a bug in #158 in which we incorrectly merged a base constructor with a derived
% constructor.  The base was never allocated, and had many classes derived from it.  Later
% because of size reasoning we detected a contradiction.  We believe that the late merge
% guesses occur after guesses about embedding and inheritance, so this allows us to explicitly
% make a guess about inheritance first and use better suited guessing rules than
% LateMergeClassesG.

% And finally just guess regardless of derived class facts.
% ED_PAPER_INTERESTING
guessLateMergeClassesG(Class1, Class2) :-
    factClassCallsMethod(Class1, Method),
    is_current(Class1),
    not(purecall(Method)), % Never merge purecall methods into classes.
    % Same reasoning as in guessMergeClasses_B...
    not(symbolProperty(Method, virtual)),
    find_current(Method, Class2),
    checkMergeClasses(Class1, Class2).

guessLateMergeClasses(Out) :-
    reportFirstSeen('guessLateMergeClassesG'),
    minof((Class, Method),
          guessLateMergeClassesG(Class, Method)),
    !,

    tryOrNot(tryMergeClasses(Class, Method, guessLateMergeClassesG),
             tryNOTMergeClasses(Class, Method, guessLateMergeClassesG),
             Out).


% --------------------------------------------------------------------------------------------
% Various rules for guessing method to class assignments...
% --------------------------------------------------------------------------------------------

% There's a very common paradigm where one constructor calls another constructor, and this
% represents either an embedded object or an inheritance relationship (aka ObjectInObject).
% This rule is strong enough that for a long time it was a forward reasoning rule, until Cory
% realized that technically the required condition was factNOTMergeClasses() instead of just
% currently being on different classes.  Because we needed to make this guess, the weaker logic
% was moved here.
% Ed: This is a guess because Constructor1 could be calling Constructor2 on the same class.
% ED_PAPER_INTERESTING
guessNOTMergeClasses(OuterClass, InnerClass) :-
    reportFirstSeen('guessNOTMergeClasses'),
    % We are certain that this member offset is passed to InnerConstructor.
    validFuncOffset(_CallInsn, OuterConstructor, InnerConstructor, _Offset),
    factConstructor(OuterConstructor),
    factConstructor(InnerConstructor),
    iso_dif(InnerConstructor, OuterConstructor),
    % They're not currently on the same class...
    find_current(InnerConstructor, InnerClass),
    find_current(OuterConstructor, OuterClass),
    iso_dif(OuterClass, InnerClass),

    not(uninitializedReads(InnerConstructor)),

    % We've not already concluded that they're different classes.
    doNotGuessHelper(factNOTMergeClasses(OuterClass, InnerClass),
                     factNOTMergeClasses(InnerClass, OuterClass)).


% The symmetry on guessNOTMergeClasses above was a little tricky, and a correction was required
% to pass tests, resulting in this possibly suboptimal approach?
guessNOTMergeClassesSymmetric(Class1, Class2) :-
    guessNOTMergeClasses(A, B),
    sort_tuple((A, B), (Class1, Class2)),
    % Debugging.
    %logtraceln('~Q.', guessNOTMergeClasses(Class1, Class2)),
    true.

guessNOTMergeClasses(Out) :-
    guessNOTMergeClassesSymmetric(Class1, Class2),

    tryOrNot(tryNOTMergeClasses(Class1, Class2, guessNOTMergeClasses),
             tryMergeClasses(Class1, Class2, guessNOTMergeClasses),
             Out).

% This is one of the strongest of several rules for guessing arbitrary method assignments.  We
% know that the method is very likely to be assigned to one of the two constructors, so we
% should guess both right now.  We don't technically know that it's assign to one or the other,
% because a method might be conflicted between multiple classes.  Perhaps a lot of conflicted
% methods with the same constructors should suggest a class merger between the constructors
% instead (for performance reasons)?
% Ed: Why does it matter that there are two constructors?

% 1/27/21: We found in issue #150 that this rule made an incorrect guess that eventually
% resulted in a contradiction.  Cory wrote: 'The proposed description of what happened is that
% 0x401ce0 is a method on an STL class, and that many classes in the program embed this STL
% class at various offsets. guessMergeClassesA is incorrectly triggering based on this method
% occuring at offset zero in multiple classes, when 0x401ce0 defintely should NOT cause class
% merges.'  Cory reflected that he thought this rule was probably too specific, and might not
% be needed anymore now that we improved some other rules.  Testing showed that disabling it
% largely had positive effects, and fixed the problem in #150.

%% guessMergeClassesA(Class1, MethodClass) :-
%%     factMethod(Method),
%%     not(purecall(Method)), % Never merge purecall methods into classes.
%%     validFuncOffset(_Insn1, Constructor1, Method, 0),
%%     validFuncOffset(_Insn2, Constructor2, Method, 0),
%%     iso_dif(Constructor1, Constructor2),
%%     factConstructor(Constructor1),
%%     factConstructor(Constructor2),
%%     find(Constructor1, Class1),
%%     find(Constructor2, Class2),
%%     find(Method, MethodClass),
%%     iso_dif(Class1, Class2),
%%     iso_dif(Class1, Method),
%%     % This rule is symmetric because Prolog will try binding the same method to Constructor2 on
%%     % one evluation, and Constructor1 on the next evaluation, so even though the rule is also
%%     % true for Constructor2, that case will be handled when it's bound to Constructor.
%%     checkMergeClasses(Class1, MethodClass),
%%     logwarnln('Proposing ~Q.', factMergeClasses_A(Constructor1, Constructor2, Method, Class1, MethodClass)).

%% guessMergeClasses(Out) :-
%%     reportFirstSeen('guessMergeClassesA'),
%%     minof((Class, Method),
%%           guessMergeClassesA(Class, Method)),
%%     !,
%%     OneTuple=[(Class, Method)],
%%     Out = tryBinarySearch(tryMergeClasses, tryNOTMergeClasses, OneTuple, 1).

% Another good guessing heuristic is that if a virtual call was resolved through a specific
% VFTable, and there's nothing contradictory, try assigning the call to the class that it was
% resolved through.  Technically, I think this is a case of choosing arbitrarily between
% multiple valid solutions.  It might be possible to prove which constructor the method is on.

% This fact was a sub-computation of guessMergeClassesB that added a lot of overhead.  By
% putting it in a separate fact, we can make it a trigger-based fact that is maintained with
% low overhead.

% XXX: Should this be in rules.pl?
:- table reasonMethodInVFTable/4 as monotonic.
reasonMethodInVFTable(VFTable, Offset, Method, Entry) :-
    factVFTableEntry(VFTable, Offset, Entry),
    dethunk(Entry, Method),
    not(purecall(Entry)),
    not(purecall(Method)).

reasonMethodInVFTable(VFTable, Offset, Method) :-
    reasonMethodInVFTable(VFTable, Offset, Method, _Entry).

guessMergeClassesB(Class1, Class2) :-
    factVFTableEntry(VFTable, _VFTableOffset, Entry1),
    not(purecall(Entry1)), % Never merge purecall methods into classes.
    dethunk(Entry1, Method1),
    factMethod(Method1),
    not(purecall(Method1)), % Never merge purecall methods into classes.

    % A further complication arose in this guessing heuristic.  It appears that if the method
    % in question is actually an import than this rule is not always true.  For example, in
    % 2010/Debug/ooex7, 0x41138e thunks to 0x414442 which thunks to 0x41d42c which is the
    % import for std::exception::what().  Blocking this guess prevents us from assigning it to
    % the wrong class, but it would be better to just assign it to the right class with a
    % strong reasoning rule.  We don't have one of those for this case yet because we don't
    % have the vftable for the method that's imported...
    not(symbolProperty(Method1, virtual)),

    find_current(Method1, Class1),

    % Which class is VFTable associated with?
    findVFTable_current(VFTable, Class2),

    iso_dif(Class1, Class2),

    % The method is allowed to appear in other VFTables, but only if they are on the same
    % class.  Ed conjectures this is necessary for multiple inheritance.  When adding thunk
    % support, Cory decided to allow the second entry to differ so long as it resolved to the
    % same place.  It's unclear if this is really correct.

    forall(reasonMethodInVFTable(OtherVFTable, _Offset, Method1),
           findVFTable_current(OtherVFTable, Class2)),

    checkMergeClasses(Class1, Class2),
    % There is extra information here so we'll leave this.
    logtraceln('Proposing ~Q.', factMergeClasses_B(Method1, VFTable, Class1, Class2)).

guessMergeClasses(Out) :-
    reportFirstSeen('guessMergeClassesB'),
    minof((Class, Method),
          guessMergeClassesB(Class, Method)),
    !,

    tryOrNot(tryMergeClasses(Class, Method, guessMergeClassesB),
             tryNOTMergeClasses(Class, Method, guessMergeClassesB),
             Out).

% A Derived class calls a method.  Does that method belong to the base or derived class?

% 1. If the called method does not install any base class vftables, guess that the method is on the derived class.
% 2. If the called method installs a base VFTable, guess that the method belongs on the base class.
% 3. Guess that the called method is on the derived class.
% 4. Finally guess that the called method is on the base class.
% Note: Although it seems like #1 is redundant, removing #1 changes the order in which guesses
% are made which causes unit tests to fail.

% If the called method does not install any base class vftables and there are no other derived
% classes that call the method, guess that the method is on the derived class.
guessMergeClassesC1(DerivedClass, CalledClass) :-
    % A derived class calls a method
    factClassCallsMethod(DerivedClass, CalledMethod),
    not(purecall(CalledMethod)), % Never merge purecall methods into classes.
    factDerivedClass(DerivedClass, BaseClass, Offset),
    is_current(DerivedClass),
    is_current(BaseClass),
    find_current(CalledMethod, CalledClass),

    % The called method does NOT install any vftables that are on the base class.
    not((
               find_current(BaseVFTable, BaseClass),
               factVFTableWrite(_Insn, CalledMethod, Offset, BaseVFTable)
       )),
    % There does NOT exist a distinct class that also calls the called method.  If this
    % happens, there is ambiguity about which derived class the CalledMethod should be placed
    % on, so it should probably go on the base.
    %% not((
    %%            factClassCallsMethod(DerivedClass2, CalledMethod),
    %%            iso_dif(DerivedClass, DerivedClass2),
    %%            factNOTMergeClasses(DerivedClass, DerivedClass2)
    %%    )),
    % ejs 10/8/2020 This rule is a bit difficult to understand, particularly because of the
    % multiple factClassCallsMethod check that is intended to detect multiple derived classes.
    % We found that a new reasoning rule covered some of the same cases and is easier to
    % understand, reasonNOTMergeClasses_R.  We are not sure if this completely covers this
    % rule, so we are just commenting it out for now.  Although we expected to be able to
    % comment out this rule (guessMergeClassesC1) completely, there is apparently an implied
    % ordering dependency.  So we are leaving this rule here.

    checkMergeClasses(DerivedClass, CalledClass),
    logtraceln('Proposing ~Q.', factMergeClasses_C1(DerivedClass, CalledClass, CalledMethod,
                                                    BaseClass, Offset)).

guessMergeClasses(Out) :-
    reportFirstSeen('guessMergeClassesC1'),
    minof((Class, Method),
          guessMergeClassesC1(Class, Method)),
    !,

    tryOrNot(tryMergeClasses(Class, Method, guessMergeClassesC1),
             tryNOTMergeClasses(Class, Method, guessMergeClassesC1),
             Out).

% If the called method installs a base VFTable, guess that the method belongs on the base class.
guessMergeClassesC2(BaseClass, CalledClass) :-
    factClassCallsMethod(DerivedClass, CalledMethod),
    not(purecall(CalledMethod)), % Never merge purecall methods into classes.
    factDerivedClass(DerivedClass, BaseClass, Offset),
    is_current(DerivedClass),
    is_current(BaseClass),
    find_current(CalledMethod, CalledClass),

    % The CalledMethod installs a VFTable on the base class
    find_current(BaseVFTable, BaseClass),
    factVFTableWrite(_Insn, CalledMethod, Offset, BaseVFTable),

    checkMergeClasses(BaseClass, CalledClass),
    logtraceln('Proposing ~Q.', factMergeClasses_C2(BaseClass, CalledClass, CalledMethod,
                                                    DerivedClass, Offset)).

guessMergeClasses(Out) :-
    reportFirstSeen('guessMergeClassesC2'),
    minof((Class, Method),
          guessMergeClassesC2(Class, Method)),
    !,

    tryOrNot(tryMergeClasses(Class, Method, guessMergeClassesC2),
             tryNOTMergeClasses(Class, Method, guessMergeClassesC2),
             Out).

% If we haven't made a guess about the called method, guess that it is on the derived class.
guessMergeClassesC3(DerivedClass, CalledClass) :-
    factClassCallsMethod(DerivedClass, CalledMethod),
    not(purecall(CalledMethod)), % Never merge purecall methods into classes.
    factDerivedClass(DerivedClass, BaseClass, Offset),
    is_current(DerivedClass),
    is_current(BaseClass),
    find_current(CalledMethod, CalledClass),
    checkMergeClasses(DerivedClass, CalledClass),
    logtraceln('Proposing ~Q.', factMergeClasses_C3(DerivedClass, CalledClass, CalledMethod,
                                                    BaseClass, Offset)).

guessMergeClasses(Out) :-
    reportFirstSeen('guessMergeClassesC3'),
    minof((Class, Method),
          guessMergeClassesC3(Class, Method)),
    !,

    tryOrNot(tryMergeClasses(Class, Method, guessMergeClassesC3),
             tryNOTMergeClasses(Class, Method, guessMergeClassesC3),
             Out).

% If we still haven't made a guess about the called method, guess that it is on the base class.
guessMergeClassesC4(BaseClass, CalledClass) :-
    factClassCallsMethod(BaseClass, CalledMethod),
    not(purecall(CalledMethod)), % Never merge purecall methods into classes.
    factDerivedClass(DerivedClass, BaseClass, Offset),
    is_current(DerivedClass),
    is_current(BaseClass),
    find_current(CalledMethod, CalledClass),
    checkMergeClasses(BaseClass, CalledClass),
    logtraceln('Proposing ~Q.', factMergeClasses_C4(BaseClass, CalledClass, CalledMethod,
                                                    DerivedClass, Offset)).

guessMergeClasses(Out) :-
    reportFirstSeen('guessMergeClassesC4'),
    minof((Class, Method),
          guessMergeClassesC4(Class, Method)),
    !,

    tryOrNot(tryMergeClasses(Class, Method, guessMergeClassesC4),
             tryNOTMergeClasses(Class, Method, guessMergeClassesC4),
             Out).


% Try guessing that a VFTable belongs to a method.

% Say that a VFTable is installed by multiple methods.  If all of these methods are on the same
% class, it's a fair bet that the VFTable corresponds to that class.  This is implemented in
% reasonVFTableBelongsToClass.  But if the methods are not (currently) known to be on the same
% class, it's less clear what to do.  One situation we've observed is when a destructor is not
% merged.  There is some ambiguity because destructors are optimized more.  If a destructor
% installs a VFTable, we can't tell if the destructor is for that VFTable's class, or if the
% destructor is on a derived class (and the base destructor was inlined).  This guess
% identifies this situation.  We initially guess that the two class fragments are on the same
% class.  If that fails, we guess that the class identified by the destructor is derived from
% the other class.

% XXX: We may be able to do additional reasoning based on whether the
% classes have bases or not.  But this is probably handled by sanity
% checks too
guessMergeClassesG(Class1, Class2) :-
    % A constructor/destructor installs a VFTable
    factVFTableWrite(_Insn, Method, Offset, VFTable),
    find_current(Method, Class1),

    % This guessing rule is only for destructors, because VFTableOverwrite logic works for
    % constructors (see reasonVFTableBelongsToClass).
    factNOTConstructor(Method),

    % Which other classes also install this VFTable
    setof(Class,
          Insn2^Offset2^Method2^(
              factVFTableWrite(Insn2, Method2, Offset2, VFTable),
              not(factVFTableOverwrite(Method2, _OtherVFTable, VFTable, Offset2)),
              find_current(Method2, Class),
              iso_dif(Class1, Class)),
          ClassSet),

    logtraceln('~Q is installed by destructor ~Q and these other classes: ~Q',
               [factVFTableWrite(Method, Offset, VFTable), Method, ClassSet]),

    (ClassSet = [Class2]
     ->
         checkMergeClasses(Class1, Class2),
         logtraceln('guessMergeClassesG had one candidate class: ~Q.', [Class2]),
         logtraceln('Proposing ~Q.', factMergeClasses_G(Class1, Class2))
     ;
     % We will merge with the largest class
     % XXX: This could be implemented more efficiently using a maplist/2 and a sort.
     % Select a class
     % XXX This is currently disabled
     fail
     %% member(Class2, ClassSet),
     %% % How big is it?
     %% numberOfMethods(Class2, Class2Size),
     %% % There is no one bigger
     %% forall(member(OtherClass, ClassSet),
     %%        (numberOfMethods(OtherClass, OtherClassSize),
     %%         not(OtherClassSize > Class2Size))),

     %% checkMergeClasses(Class1, Class2),
     %% logdebugln('guessMergeClassesG had more than one candidate class.  Merging with the largest class ~Q.', [Class2])
    ).

guessMergeClasses(Out) :-
    reportFirstSeen('guessMergeClassesG'),
    minof((Class, Method),
          guessMergeClassesG(Class, Method)),
    !,

    tryOrNot(tryMergeClasses(Class, Method, guessMergeClassesG),
             tryNOTMergeClasses(Class, Method, guessMergeClassesG),
             Out).


checkMergeClasses(Method1, Method2) :-
    iso_dif(Method1, Method2),
    find_current(Method1, Class1),
    find_current(Method2, Class2),
    % They're not already on the same class...
    iso_dif(Class1, Class2),
    % They're not already proven NOT to be on the same class.
    doNotGuessHelper(factNOTMergeClasses(Class1, Class2),
                     factNOTMergeClasses(Class2, Class1)),
    % XXX: Check factMergeClasses?
    % Now relationships between the classes are not allowed either.
    not(reasonClassRelationship(Class1, Class2)),
    not(reasonClassRelationship(Class2, Class1)).

% If we are merging classes that have already been merged, just ignore it.
tryMergeClasses(Method1, Method2, _Rule) :-
    find_current(Method1, Class),
    find_current(Method2, Class),
    logerrorln('tryMergeClasses on same class'),
    throw_with_backtrace(error(system_error(tryMergeClasses, Method1, Method2, Class))),
    !.

tryMergeClasses(Method1, Method2, Rule) :-
    find_current(Method1, Class1),
    find_current(Method2, Class2),
    reportGuess(mergeClasses(Class1, Class2), Rule),
    mergeClasses(Class1, Class2),
    try_assert(guessedMergeClasses(Class1, Class2)).

tryNOTMergeClasses(Method1, Method2, Rule) :-
    find_current(Method1, Class1),
    find_current(Method2, Class2),
    reportGuess(factNOTMergeClasses(Class1, Class2), Rule),
    try_assert(factNOTMergeClasses(Class1, Class2)),
    try_assert(guessedNOTMergeClasses(Class1, Class2)).

% --------------------------------------------------------------------------------------------
% Try guessing that method is a real destructor.
% --------------------------------------------------------------------------------------------
guessRealDestructor(Out) :-
    reportFirstSeen('guessRealDestructor'),
    minof(Method,
          (likelyDeletingDestructor(DeletingDestructor, Method),
           % Require that we've already confirmed the deleting destructor.
           factDeletingDestructor(DeletingDestructor),
           doNotGuessHelper(factRealDestructor(Method),
                            factNOTRealDestructor(Method)))),

    tryOrNot(tryRealDestructor(Method, guessRealDestructor),
             tryNOTRealDestructor(Method, guessRealDestructor),
             Out).

% Establish that the candidate meets minimal requirements.
minimalRealDestructor(Method) :-
    possibleDestructor(Method),
    doNotGuessHelper(factRealDestructor(Method),
                     factNOTRealDestructor(Method)),

    % Trying a different approach to blocking singletons here.  Many singletons have no
    % interprocedural flow at all, and so also have no call before AND no calls after.
    % This causes a significant regression (at least by itself), F=0.43 -> F=0.36.
    % Even as an ordering rule this appears to be harmful... F=0.46 -> F=0.42 why?
    % not(noCallsBefore(Method)),

    % Destructors can't take multiple arguments (well except for when they have virtual bases),
    % but this should at least get us closer...
    not((
               funcParameter(Method, Position, _SV),
               iso_dif(Position, ecx)
       )),

    % There must be at least one other method besides this one on the class.  There's a strong
    % tendency to turn every singleton method into real destructor without this constraint.
    find(Method, Class),
    find(Other, Class),
    iso_dif(Other, Method),
    true.

% Prioritize methods called by deleteing destructors.
guessFinalRealDestructor(Out) :-
    minimalRealDestructor(Method),
    callTarget(_Insn, OtherDestructor, Method),
    factDeletingDestructor(OtherDestructor),

    tryOrNot(tryRealDestructor(Method, guessFinalRealDestructor1),
             tryNOTRealDestructor(Method, guessFinalRealDestructor1),
             Out).

% Prioritize methods that call other real destructors.
guessFinalRealDestructor(Out) :-
    minimalRealDestructor(Method),
    callTarget(_Insn, Method, OtherDestructor),
    factRealDestructor(OtherDestructor),

    tryOrNot(tryRealDestructor(Method, guessFinalRealDestructor2),
             tryNOTRealDestructor(Method, guessFinalRealDestructor2),
             Out).

% Prioritize methods that do not call delete to avoid confusion with deleting destructors.
% This eliminates a couple of false positives in the fast test suite.
guessFinalRealDestructor(Out) :-
    minimalRealDestructor(Method),
    not(insnCallsDelete(_Insn, Method, _SV)),

    tryOrNot(tryRealDestructor(Method, guessFinalRealDestructor3),
             tryNOTRealDestructor(Method, guessFinalRealDestructor3),
             Out).

% Guess if it meets the minimal criteria.
guessFinalRealDestructor(Out) :-
    minimalRealDestructor(Method),

    tryOrNot(tryRealDestructor(Method, guessFinalRealDestructor4),
             tryNOTRealDestructor(Method, guessFinalRealDestructor4),
             Out).

tryRealDestructor(Method, Rule) :-
    reportGuess(factRealDestructor(Method), Rule),
    try_assert(factRealDestructor(Method)),
    try_assert(guessedRealDestructor(Method)).

tryNOTRealDestructor(Method, Rule) :-
    reportGuess(factNOTRealDestructor(Method), Rule),
    try_assert(factNOTRealDestructor(Method)),
    try_assert(guessedNOTRealDestructor(Method)).

% --------------------------------------------------------------------------------------------
% Try guessing that method is a deleting destructor.
% --------------------------------------------------------------------------------------------

% The criteria for guessing deleting destructors...

% This rule guesses we're a destructor because we install a vftable and appear to be virtual.
% We can't tell if we're a deleting or real destructor, but if we guess wrong we'll almost
% always know immediately because of reasonNOTRealDestructor_H and
% reasonNOTDeletingDestructor_F.
likelyAVirtualDestructor(Method) :-
    % Standard destructor requirement
    noCallsAfter(Method),
    % We install a vftable
    certainConstructorOrDestructor(Method),
    % And we're probably a virtual method
    possiblyVirtual(Method).

guessDeletingDestructor(Out) :-
    reportFirstSeen('guessDeletingDestructor'),
    likelyAVirtualDestructor(Method),
     doNotGuessHelper(factDeletingDestructor(Method),
                      factNOTDeletingDestructor(Method)),
    !,

    tryOrNot(tryDeletingDestructor(Method, guessDeletingDestructor1),
             tryNOTDeletingDestructor(Method, guessDeletingDestructor1),
             Out).

guessDeletingDestructor(Out) :-
    minof(Method,
          (likelyDeletingDestructor(Method, _RealDestructor),
           doNotGuessHelper(factDeletingDestructor(Method),
                            factNOTDeletingDestructor(Method)))),
    !,

    tryOrNot(tryDeletingDestructor(Method, guessDeletingDestructor2),
             tryNOTDeletingDestructor(Method, guessDeletingDestructor2),
             Out).

guessFinalDeletingDestructor(Out) :-
    reportFirstSeen('guessFinalDeletingDestructor'),
    possibleDestructor(Method),
    doNotGuessHelper(factDeletingDestructor(Method),
                     factNOTDeletingDestructor(Method)),

    insnCallsDelete(_Insn2, Method, _SV),

    % guessDeletingDestructor requires a call to a real destructor.  This rule relaxes that a
    % bit, by ensuring we don't call any non-real destructors.  So calling a real destructor
    % will trigger this rule, but it is not necessary.
    not((
               callTarget(_Insn1, Method, Called),
               not(factRealDestructor(Called))
       )),

    !,
    tryOrNot(tryDeletingDestructor(Method, guessFinalDeletingDestructor1),
             tryNOTDeletingDestructor(Method, guessFinalDeletingDestructor1),
             Out).

%
guessFinalDeletingDestructor(Out) :-
    % Establish that the candidate meets minimal requirements.
    possibleDestructor(Method),
    doNotGuessHelper(factDeletingDestructor(Method),
                     factNOTDeletingDestructor(Method)),

    % The calls delete requirement was what was needed to keep false positives down.
    insnCallsDelete(_DeleteInsn, Method, _SV),

    % If the method occurs twice in a single VFTable, wildly guess that it's a deleting
    % destructor based entirely on a common phenomenon in the Visual Studio compiler.

    % There are two thunks to Method in VFTable
    reasonMethodInVFTable(VFTable, Offset1, Method),
    % XXX: By binding to _Other_Method instead of Method on the next line, we are preserving a
    % known bug because it seems to produce better results for destructors.
    reasonMethodInVFTable(VFTable, Offset2, _Other_Method),
    iso_dif(Offset1, Offset2),

    % For this rule to apply, there has to be two different entries that thunk to Method
    factVFTableEntry(VFTable, Offset1, Entry1),
    factVFTableEntry(VFTable, Offset2, Entry2),

    % We are not sure if the entry actually has to differ or not.  We should experiment with
    % whether removing the next line improves accuracy.
    iso_dif(Entry1, Entry2),

    !,
    tryOrNot(tryDeletingDestructor(Method, guessFinalDeletingDestructor2),
             tryNOTDeletingDestructor(Method, guessFinalDeletingDestructor2),
             Out).

tryDeletingDestructor(Method, Rule) :-
    reportGuess(factDeletingDestructor(Method), Rule),
    try_assert(factDeletingDestructor(Method)),
    try_assert(guessedDeletingDestructor(Method)).

tryNOTDeletingDestructor(Method, Rule) :-
    reportGuess(factNOTDeletingDestructor(Method), Rule),
    try_assert(factNOTDeletingDestructor(Method)),
    try_assert(guessedNOTDeletingDestructor(Method)).

% A helper for guessing deleting destructors.
:- table likelyDeletingDestructor/2 as incremental.

likelyDeletingDestructor(_, RealDestructor) :-
    ground(RealDestructor),
    throw_with_backtrace(error(uninstantiation_error(RealDestructor),
                               likelyDeletingDestructor/2)).

likelyDeletingDestructor(DeletingDestructor, RealDestructor) :-
    % Deleting destructors must call the real destructor (we think).  Usually offset is zero,
    % but there are some unusual cases where there are multiple calls to real destructors, and
    % only one has offset zero and we missed it because we're not handling imported OO methods
    % correctly.  A cheap hack to just be a little looser here and accept any calls to
    % destructors. Note we do NOT bind _RealDestructor.  See note below.
    validFuncOffset(_RealDestructorInsn1, DeletingDestructor, _RealDestructor, _Offset1),

    % This indicates that the method met some basic criteria in C++.
    possibleDestructor(DeletingDestructor),
    % That's not already certain to NOT be a deleting destructor.
    not(factNOTDeletingDestructor(DeletingDestructor)),
    % And the deleting destructor must also call delete (we think), since that's what makes it
    % deleting.  Using this instead of the more complicated rule below led toa very slight
    % improvement in the fast test suite F=0.43 -> F=0.44.
    insnCallsDelete(DeleteInsn, DeletingDestructor, _SV),
    % This condition is complicated.  We want to ensure that the thing actually being deleted
    % is the this-pointer passed to the deleting destructor.  But the detection of parameters
    % to delete is sometimes complicated, and a non-trivial number of our facts are still
    % reporting "invalid".  While the real fix is to always have correct parameter values for
    % delete(), in the mean time lets try accepting an fact-generation failure as well, but not
    % a pointer that's known to be unrelated).

    % This rule currently needs to permit the slightly different ECX parameter standard.  An
    % example is std::basic_filebuf:~basic_filebuf in Lite/oo.
    (callingConvention(DeletingDestructor, '__thiscall'); callingConvention(DeletingDestructor, 'invalid')),
    funcParameter(DeletingDestructor, 'ecx', ThisPtr),
    (
        insnCallsDelete(DeleteInsn, DeletingDestructor, ThisPtr);
        insnCallsDelete(DeleteInsn, DeletingDestructor, invalid)
    ),

    % Phew. Everything up until this point has been about the _deleting destructor_.  We
    % intentionally did _not_ bind RealDestructor.  Now that we've checked out the deleting
    % destructor, let's look for any possible real destructor.
    validFuncOffset(_RealDestructorInsn2, DeletingDestructor, RealDestructor, _Offset2),

    % And while it's premature to require the real destructor to be certain, it shouldn't be
    % disproven.
    possibleDestructor(RealDestructor),
    not(factNOTRealDestructor(RealDestructor)),
    true.

%% Local Variables:
%% mode: prolog
%% End:
