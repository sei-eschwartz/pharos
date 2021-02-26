% Copyright 2017-2021 Carnegie Mellon University.

:- use_module(library(apply), [maplist/3]).

% ============================================================================================
% Options.
% ============================================================================================

:- dynamic logTrace/0 as opaque.

% A dynamically asserted option controlling whether guessing is enabled.
:- dynamic guessingDisabled/0 as opaque.

% Is the use of RTTI information during reasoning enabled?
:- dynamic rTTIEnabled/0 as opaque.

:- dynamic profilingEnabled/0.
:- dynamic deterministicEnabled/0.

% When an "upstream problem" occurs, by default we will terminate the analysis because it can
% take a very long time to find the problematic guess.  If this option is set, we will continue
% to backtrack until we fix the upstream problem.
:- dynamic backtrackForUpstream/0.

%:- ensure_loaded(rewrite_test).

% ============================================================================================
% Inputs facts.
% ============================================================================================

% Facts produced by the C++ component are all optional.  These facts are never asserted or
% change in any way during execution.

:- ensure_loaded(facts).

% For Debugging, not for rules!
%:- dynamic termDebug/2 as incremental.


% ============================================================================================
% Dynamically asserted facts.
% ============================================================================================

% These facts are asserted and retracted dynamically as the analysis executes.

:- dynamic factMethod/1 as (incremental, monotonic).
:- dynamic factNOTMethod/1 as incremental.
:- dynamic factConstructor/1 as (incremental, monotonic).
:- dynamic factNOTConstructor/1 as incremental.
:- dynamic factRealDestructor/1 as incremental.
:- dynamic factNOTRealDestructor/1 as incremental.
:- dynamic factDeletingDestructor/1 as incremental.
:- dynamic factNOTDeletingDestructor/1 as incremental.

:- dynamic factVirtualFunctionCall/5 as incremental.
:- dynamic factNOTVirtualFunctionCall/5 as incremental.
:- dynamic factVFTable/1 as incremental.
:- dynamic factNOTVFTable/1 as incremental.
:- dynamic factVFTableWrite/4 as (incremental,abstract(0)).
:- dynamic factVFTableOverwrite/4 as incremental.
:- dynamic factVFTableEntry/3 as (incremental, monotonic).
:- dynamic factNOTVFTableEntry/3 as incremental.
:- dynamic factVFTableSizeGTE/2 as (incremental, monotonic).
:- dynamic factVFTableSizeLTE/2 as (incremental, monotonic).

:- dynamic factVBTable/1 as incremental.
:- dynamic factNOTVBTable/1 as incremental.
:- dynamic factVBTableWrite/4 as incremental.
:- dynamic factVBTableEntry/3 as incremental.
:- dynamic factNOTVBTableEntry/3 as incremental.

:- dynamic factObjectInObject/3 as incremental.
:- dynamic factDerivedClass/3 as incremental.
:- dynamic factNOTDerivedClass/3 as incremental.
:- dynamic factEmbeddedObject/3 as incremental.
:- dynamic factNOTEmbeddedObject/3 as incremental.
:- dynamic factClassSizeGTE/2 as incremental.
:- dynamic factClassSizeLTE/2 as incremental.
:- dynamic factClassHasNoBase/1 as incremental.
:- dynamic factReusedImplementation/1 as incremental.
:- dynamic factClassHasUnknownBase/1 as incremental.
:- dynamic factNOTMergeClasses/2 as incremental.
:- dynamic factClassCallsMethod/2 as incremental.

% ============================================================================================
% Dynamically rewritten facts involving classes.
% ============================================================================================

% Because class identifiers change during analysis, these facts tell use which of the
% dyanmically asserted facts must be rewritten whenever a class identifier for a specific class
% changes.  See fixupClasses() in this file for the details of the rewriting.

classArgs(factEmbeddedObject/3, 1).
classArgs(factEmbeddedObject/3, 2).
classArgs(factObjectInObject/3, 1).
classArgs(factObjectInObject/3, 2).
classArgs(factDerivedClass/3, 1).
classArgs(factDerivedClass/3, 2).
classArgs(factNOTDerivedClass/3, 1).
classArgs(factNOTDerivedClass/3, 2).
classArgs(factClassHasNoBase/1, 1).
classArgs(factNOTMergeClasses/2, 1).
classArgs(factNOTMergeClasses/2, 2).
classArgs(factClassCallsMethod/2, 1).
classArgs(factClassSizeGTE/2, 1).
classArgs(factClassSizeLTE/2, 1).

% ============================================================================================
% Guessed fact markers.
% ============================================================================================

% These are markers for which facts were determined by guessing rather than reasoning.  They
% cannot be used for determining which facts are certain to be true and which are not because
% once you've made a guess, there are many subsequent facts that are concluded on the basis of
% the guessed fact that will NOT be marked in this way.  But we can use these facts for feature
% such as measuring how many guesses were required to reach the final solution (and what types
% of guesses they were).  This could be statisically interseting in addition to provided
% details about where our logic was mostly likely to have initially introduce incorrect
% conclusions.
%
% Cory has been conflicted on whether these facts have any significant value and whether they
% should be consistently used or completely discarded.  The most recent conclusion was to get
% them back up to being consistently used and see if we can't develop more useful
% infrastructure around them.

:- dynamic doNotGuess/1 as incremental.
:- dynamic guessedMethod/1 as incremental.
:- dynamic guessedNOTMethod/1 as incremental.
:- dynamic guessedConstructor/1 as incremental.
:- dynamic guessedNOTConstructor/1 as incremental.
:- dynamic guessedRealDestructor/1 as incremental.
:- dynamic guessedNOTRealDestructor/1 as incremental.
:- dynamic guessedDeletingDestructor/1 as incremental.
:- dynamic guessedNOTDeletingDestructor/1 as incremental.
:- dynamic guessedVirtualFunctionCall/5 as incremental.
:- dynamic guessedNOTVirtualFunctionCall/5 as incremental.
:- dynamic guessedVFTable/1 as incremental.
:- dynamic guessedNOTVFTable/1 as incremental.
%:- dynamic guessedVFTableWrite/4. % Only concluded!
%:- dynamic guessedVFTableOverwrite/3. % Only concluded!
:- dynamic guessedVFTableEntry/3 as incremental.
:- dynamic guessedNOTVFTableEntry/3 as incremental.
:- dynamic guessedVBTable/1 as incremental.
:- dynamic guessedNOTVBTable/1 as incremental.
:- dynamic guessedVBTableWrite/4 as incremental.
%:- dynamic guessedVBTableEntry/3 as incremental. % Only concluded!
%:- dynamic guessedNOTVBTableEntry/3 as incremental. % Only concluded!
%:- dynamic guessedObjectInObject/3. % Only concluded!
:- dynamic guessedDerivedClass/3 as incremental.
:- dynamic guessedNOTDerivedClass/3 as incremental.
:- dynamic guessedEmbeddedObject/3 as incremental.
:- dynamic guessedNOTEmbeddedObject/3 as incremental.
%:- dynamic guessedClassSizeGTE/2. % Only concluded.
%:- dynamic guessedClassSizeLTE/2. % Only concluded.
:- dynamic guessedClassHasNoBase/1 as incremental.
:- dynamic guessedClassHasUnknownBase/1 as incremental.
:- dynamic guessedMergeClasses/2 as incremental.
:- dynamic guessedNOTMergeClasses/2 as incremental.
%:- dynamic factClassCallsMethod/2. % Only concluded.

% ============================================================================================
% Assorted declarations.
% ============================================================================================


% ============================================================================================
% Other modules.
% ============================================================================================

:- ensure_loaded(util).
:- ensure_loaded(logging).
:- ensure_loaded(webstat_helper).
:- ensure_loaded(initial).
:- ensure_loaded(rtti).
:- ensure_loaded(rules).
:- ensure_loaded(guess).
:- ensure_loaded(forward).
:- ensure_loaded(insanity).
:- ensure_loaded(complete).
:- ensure_loaded(final).
:- ensure_loaded(softcut).
:- ensure_loaded(class).
:- ensure_loaded(swihelp).

% ============================================================================================
% Version warning.
% ============================================================================================
version_check :-
    current_prolog_flag(version_data, swi(Major, Minor, Patch, _Extra)),
    current_prolog_flag(version, Version),
    Version < 80319,
    logwarnln("The version of SWI Prolog being used is version ~d.~d.~d.  This",
              [Major, Minor, Patch]),
    logwarnln("version does not contain bug fixes installed in version 8.3.19."),
    logwarnln("The lack of these fixes can cause problems in rare cases.  See"),
    logwarnln("https://github.com/cmu-sei/pharos/issues/156 for more details.").

version_check.

% These predicates are just named differently in SWI Prolog.
incr_assert(T)  :- assertz(T).
incr_asserta(T) :- asserta(T).
incr_retract(T) :- retract(T).

% ============================================================================================
% Solving main engine.
% ============================================================================================

:- set_flag(numfacts, 0).
:- set_flag(guesses, 0).
:- set_flag(reasonForwardSteps, 0).

% Numfacts keeps track of the number of currently recorded facts so we can show the user some
% progress.  Super fancy.
delta_con(Con, Delta):- get_flag(Con, Y), Z is Y + Delta, set_flag(Con, Z).

assert_helper(X) :-
    incr_asserta(X).
retract_helper(X) :-
    % In SWI Prolog, retract can have open choice points as a result of index/hash collisions.
    once(incr_retract(X)).

try_assert(X) :- X, !.
try_assert(X) :- try_assert_real(X).
try_assert_real(X) :- delta_con(numfacts, 1), assert_helper(X).

try_retract(X) :- not(X), !.
try_retract(X) :- try_retract_real(X).
try_retract_real(X) :- delta_con(numfacts, -1), retract_helper(X).

% This predicate looks for arguments that are defined in classArgs as representing classes.  It
% then looks for any argument that is equal to 'From', and modifies it to 'To' instead.  The
% idea is that this will be used to keep the dynamic database always referring to the latest
% representative for each class.
fixupClasses(From, To, OldTerm, NewTerm) :-
    classArgs(Pred/Arity, Index),
    functor(IntermediateOldTerm, Pred, Arity),

    % Ensure that the From argument is in the correct location for this replacement
    arg(Index, IntermediateOldTerm, From),

    % The IntermediateOldTerm must already be asserted, since we're going to end up retracting it.
    IntermediateOldTerm,

    %logtraceln('Considering class fact ~Q/~Q index ~Q from ~Q to ~Q in predicate ~Q',
    %           [Pred, Arity, Index, From, To, IntermediateOldTerm]),

    %logtraceln('Fixing up ~Q/~Q index ~Q from ~Q to ~Q in predicate ~Q',
    %           [Pred, Arity, Index, From, To, IntermediateOldTerm]),

    % fixupClasses is only correct if From appears in one location.  E.g., factDerivedClass(X,
    % X, 0) will cause us to leave facts around that still contain From.
    ((classArgs(Pred/Arity, OtherIndex), iso_dif(Index, OtherIndex), arg(OtherIndex, IntermediateOldTerm, To))
    ->
        (logerrorln('An internal error occurred in OOAnalyzer. Please report this to the developers:~n~Q', IntermediateOldTerm),
         throw_with_backtrace(error(system_error(fixupClasses, IntermediateOldTerm))))
    ;
    true),

    % Now we'll break it apart.
    IntermediateOldTerm =.. IntermediateOldTermElements,
    ListIndex is Index + 1,

    % Report what the terms list looks like before replacement
    %logtraceln('Fixing up position ~Q in old elements: ~Q'),
    %           [ListIndex, IntermediateOldTermElements]),

    % Replace From in IntermediateOldTermElements at ListIndex offset, with To, and return IntermediateNewTermElements.
    replace_ith(IntermediateOldTermElements, ListIndex, From, To, IntermediateNewTermElements),

    % Report what the terms list looks like after replacement
    %logtraceln('Fixing up position ~Q resulted in new elements: ~Q',
    %           [ListIndex, IntermediateNewTermElements]),

    % Combine NetTermElements back into a predicate that we can assert.
    IntermediateNewTerm =.. IntermediateNewTermElements,

    OldTerm=IntermediateOldTerm, NewTerm=IntermediateNewTerm.

logtraceClasses :-
    classArgs(Pred/Arity, Index),
    functor(OldTerm, Pred, Arity),
    OldTerm,
    arg(Index, OldTerm, From),
    find(From, From2),
    (From = From2 -> fail;
     logerrorln('~Q should be a class representative in ~Q argument ~Q but ~Q is the rep.',
                [From, OldTerm, Index, From2])).

% This is a helper predicate used by mergeClasses(M1, M2).  The messages are logged at the
% logtrace level, because there's quite a lot of them, but this is a fairly important set of
% messages, and it might really belong at the info level.

mergeClassBuilder((OldTerm,NewTerm), Out) :-
    Out =
    (logdebugln(true, 'Retracting ~Q and asserting ~Q ...', [OldTerm, NewTerm]),
     %try_retract(OldTerm),
     try_assert(NewTerm)).

% Explicitly merge two methods.  Only called from reasonAMergeClasses and tryAMergeClasses.
mergeClasses(M1, M2) :-
    iso_dif(M1, M2),
    makeIfNecessary(M1),
    makeIfNecessary(M2),
    find(M1, S1),
    find(M2, S2),
    S1 \= S2,

    (deterministicEnabled
     % If deterministicEnabled, use lower value as NewRep
     -> (S1 < S2 -> NewRep=S1; NewRep=S2)
     % Otherwise use M1
     ; (NewRep=S1)),

    % Compute OldRep
    (NewRep=S1 -> OldRep=S2; OldRep=S1),

    % If we fail, the only thing we want to backtrack over is the actions we took
    !,

    % We always use the identifier for the first one.  So this should be the NewRep
    % Note: We must be able to backtrack through this to restore classes on failure.
    union(NewRep, OldRep),

    loginfoln('Merging class ~Q into ~Q ...', [OldRep, NewRep]),

    % An empty vftable class can cause fixupClasses to fail
    (setof((OldTerm, NewTerm),
          fixupClasses(OldRep, NewRep, OldTerm, NewTerm),
          Set)
     ->
         true
     ;
     Set = []),

    maplist(mergeClassBuilder, Set, Actions),
    %logdebugln(Actions)

    all(Actions),

    (logLevelEnabled('TRACE')
     ->
         findall(NewRep, AllObjects),
         logtraceln('Objects now on ~Q: ~Q', [NewRep, AllObjects])
     ;
         true).

% It does not appear that the ordering of the reasoning rules is too important because we'll
% eventually complete all reasoning before going to to guessing.  On the other hand, reasoning
% in the correct order should spend less time evaluating rules that don't accomplish anything.

reasonForward :-
    logdebugln('Starting reasonForward.'),
    (delta_con(reasonForwardSteps, 1); (delta_con(reasonForwardSteps, -1), fail)),
    once((concludeMethod(Out);
          concludeVFTableOverwrite(Out);
          concludeVirtualFunctionCall(Out);
          concludeConstructor(Out);
          concludeNOTConstructor(Out);
          concludeVFTable(Out);
          concludeVFTableWrite(Out);
          concludeVFTableEntry(Out);
          concludeNOTVFTableEntry(Out);
          concludeVFTableSizeGTE(Out);
          concludeVFTableSizeLTE(Out);
          concludeVBTable(Out);
          concludeVBTableWrite(Out);
          concludeVBTableEntry(Out);
          concludeObjectInObject(Out);
          concludeDerivedClass(Out);
          concludeNOTDerivedClass(Out);
          concludeEmbeddedObject(Out);
          concludeNOTEmbeddedObject(Out);
          concludeDeletingDestructor(Out);
          concludeRealDestructor(Out);
          concludeNOTRealDestructor(Out);
          concludeClassSizeGTE(Out);
          concludeClassSizeLTE(Out);
          concludeClassHasNoBase(Out);
          concludeClassHasUnknownBase(Out);
          concludeReusedImplementation(Out);
          concludeNOTMergeClasses(Out);
          concludeMergeVFTables(Out);
          concludeMergeClasses(Out);
          concludeClassCallsMethod(Out)
        )),

    % At this point we have reasoned and produced a fact to assert.  We will not backtrack into
    % the reasoning because of once/1.

    % Go ahead and try_assert the fact.
    if_(call(Out),
        true,
        (logerrorln('An internal error occurred in OOAnalyzer. Please report this to the developers:~n~Q', Out),
         throw_with_backtrace(error(system_error(reasonForward), Out)))).

% Reason forward as many times as possible.  It's ok if we can't reason forward any more.  But
% if we _backtrack_ and can't reason forward, it means that we've exhausted this search tree,
% and we should fail to our caller.  The if_ handles that, since if reasonForward suceeds once,
% we will keep searching for alternatives.  If no alternative is found, it will fail because it
% committed to the first branch.
reasonForwardAsManyTimesAsPossible :-
    logtraceln('reasonForwardAsManyTimesAsPossible'),
    %(sanityChecks -> true; (logwarnln('Failed sanity check during forward reasoning'),
    %                       throw_with_backtrace(error(system_error(reasonForwardAsManyTimesAsPossible))))),
    if_(reasonForward,
        reasonForwardAsManyTimesAsPossible,
        logdebugln('reasonForwardAsManyTimesAsPossible complete.')).

% Go forward: Make a guess, reason forward, and then sanity check
tryAGuess(Out) :-
    logtraceln('reasoningLoop: guess'),
    guess(Out),
    get_flag(numfacts, N),
    progress(N).

guessReasonAndCheck(Guess) :-
    logdebugln('Going to make guess ~Q', Guess),
    transaction(guessReasonAndCheckGuarded(Guess)),
    (   backtrackForUpstream
    ->  % If we reach this point, reasoningLoop has terminated since we called it inside the
        % transaction
        true
    ;   % If we are not backtracking, we eagerly cut here to avoid wasting a lot of memory.
        !,
        reasoningLoop
    ).

guessReasonAndCheckGuarded(Guess) :-
    (   call(Guess),
        sanityChecksOrRevert,
        logdebugln('reasoningLoop: reasonForardAsManyTimesAsPossible'),
        reasonForwardAsManyTimesAsPossible,
        sanityChecksOrRevert,
        logdebugln('reasoningLoop: post-reason sanityChecks'),
        (   sanityChecks
        ->  loginfoln('Constraint checks succeeded, guess accepted!')
        ;   logwarnln('Constraint checks failed, retracting guess!'),
            fail
        ),
        % If we want to be able to backtrack upstream, we should resume reasoning
        % inside the transaction here.  Right? XXX
        (   backtrackForUpstream
        ->  reasoningLoop
        ;   % If we don't want to backtrack upstream, we let the transaction close and
            % then reason...
            true
        )
    ).

sanityChecksOrRevert :-
    updated(Variants),
    loginfoln(true, 'Affected variants: ~p', [Variants]),
    (   sanityChecks
    ->  loginfoln('Constraint checks succeeded, proceeding to reason forward!')
    ;   logwarnln('Constraint checks failed, retracting guess!'),
        invalidate(Variants),
        fail
    ).

updated(Variants) :-
    transaction_updates(Updates),
    maplist(clause_head, Updates, AllVariants),
    variant_set(AllVariants, Variants).

clause_head(asserta(ClauseRef), Head) :-
    '$tabling':'$clause'(Head, _Body, ClauseRef, _Bindings).
clause_head(assertz(ClauseRef), Head) :-
    '$tabling':'$clause'(Head, _Body, ClauseRef, _Bindings).
clause_head(erased(ClauseRef), Head) :-
    '$tabling':'$clause'(Head, _Body, ClauseRef, _Bindings).

variant_set(List, Set) :-
    sort(List, Sorted),
    variant_set_(Sorted, Set).

variant_set_([], []).
variant_set_([H|T0], [H|T]) :-
    skip_same_variant(H, T0, T1),
    variant_set_(T1, T).

skip_same_variant(V, [H|T0], T) :-
    V =@= H,
    !,
    skip_same_variant(V, T0, T).
skip_same_variant(_, List, List).

invalidate(Variants) :-
    debug(invalidate, 'Invalidating ~p', [Variants]),
    maplist(invalidate_one, Variants).

invalidate_one(Head) :-
    predicate_property(Head, monotonic),
    !,
    '$tabling':mon_invalidate_dependents(Head).
invalidate_one(Head) :-
    predicate_property(Head, incremental),
    !,
    '$tabling':dyn_changed_pattern(Head).
invalidate_one(_).


% When reasoning, if we ever run out of guesses, we are done!  Otherwise, we execute the rest
% of the loop, but we must preserve choice points so that we can backtrack to the latest guess
% even if that is in another loop iteration.
reasoningLoop :-
    if_(tryAGuess(Out),
        (is_list(Out)
        ->
            % If Out is a list of goals (it should always be), then we try them in
            % order until we find one that works.
            member(Guess, Out),
            guessReasonAndCheck(Guess)
        ;
        % If Out is a legacy goal, just call it.
        throw_with_backtrace(error(system_error(badGuess, Out)))),
        %guessReasonAndCheck(Out)),
        % If we can't guess, exit with true.  Cut so we don't trigger the second rule.
        (!, loginfoln('reasoningLoop: There are no possible guesses remaining'))).

% If we have reached this point, sanity checks have initially passed but we have
% backtracked here, which means an upstream problem caused us to backtrack.  This is
% controlled by the backtrackForUpstream/0 option.
reasoningLoop :-
    backtrackForUpstream ->
        loginfoln('reasoningLoop: Backtracking into reasoningLoop/0 to fix an upstream problem.'),
        fail
    ;
    logfatalln('Refusing to backtrack into reasoningLoop to fix an upstream problem because backtrackForUpstream/0 is not set.'),
    logfatalln('This likely indicates that there is a problem with the OO rules.'),
    logfatalln('Please report this failure to the Pharos developers!'),
    throw_with_backtrace(error(system_error(upstreamProblem))).

% --------------------------------------------------------------------------------------------
% The performance of our code is highly dependent on the ordering of these guesses.  Making bad
% guesses early causes lots of backtracking which preforms poorly.  The current ordering is not
% well justified, but rather a hodge-podge of experimental results and gut feelings.  Cory has
% no idea how to reason through this properly, so he's just going to take some notes.
guess(Out) :-
        logdebugln('~@Starting guess. There are currently ~D guesses.',
                   [get_flag(guesses, Guesses), Guesses]),
        % These three guesses are first on the principle that guesing them has lots of
        % consequences, and that they're probably not wrong, so there's little harm in guessing
        % them first.
        once((guessVirtualFunctionCall(Out);
              guessVFTable(Out);
              guessVBTable(Out);
              guessDerivedClass(Out);

              % Guess that methods really are methods.  Currently the ordering for this rule
              % was pretty random -- in time to guessing VFTable entries?
              guessMethod(Out);

              % Guessing VFTables needed to be moved earlier than it used to be because we
              % corrected some defects in VFTable forward reasoning that made guessing much
              % more important.   It's unclear if it needs to be this early, but results were
              % definitely better here than later.
              guessVFTableEntry(Out);

              % Perhaps both of these should be guessed at once?  They're so closely related
              % that we might get better results from requiring both or none...  But how to do
              % that?  These area guessed before constructors in particular because the prevent
              % some bas constructor guesses.
              guessDeletingDestructor(Out);
              guessRealDestructor(Out);

              % Constructors are very important guesses that can sometimes be reasoned soundly
              % in the presence of virtual function tables, but we often have to guess when
              % there are not tables.
              guessConstructor(Out);

              % This is a fairly solid rule that used to be forward reasoning until it was
              % found to be incorrect in certain rare cases.  It has to be before
              % ClassHasNoBase because it will cause confusion about embedded object versus
              % inheritance if it's after.
              guessNOTMergeClasses(Out);

              % This is a very important (and very speculative) guess that's required to make a
              % lot of forward progress. :-( It's a very likely source of backtracking.  Its
              % relationship with guessing constructors is very unclear.  We probably need to
              % have a fairly complete set of constructors to derive base class relationships
              % which prevent bad no-base guesses.
              guessClassHasNoBase(Out);

              % Guess some less likely constructors after having finished reasoning through the
              % likely implications of the inheritance of the more likely constuctor guesses.
              guessUnlikelyConstructor(Out);

              % This shuold probably be the very last guess because a lot of it is pretty
              % arbitrary.  Alternatively we could break the different ways of proposing
              % guesses into different rules and make higher confidence guesses earlier and
              % lower confidence guesses later.  Right now, that's handled by clause ordering
              % within this one rule, which precludes us from splitting it up.
              guessMergeClasses(Out);

              % Only after we've merged all the methods into the classes should we take wild
              % guesses at real destructors.
              guessFinalDeletingDestructor(Out);
              % RealDestructorChange! (uncomment next line and add semicolon above)
              %guessFinalRealDestructor(Out)

              % These rules must come very late, but before guessCommitClassHasNoBase.  See
              % guess.pl for more commentary.
              guessLateMergeClasses(Out);

              % As the very last guess, explicitly guess factClassHasNoBase(Class) for any
              % class that we have not identified a base class for.
              guessCommitClassHasNoBase(Out)


             )).

% Actually check to see if the solution is complete.
checkCompleteness :-
    loginfo('Checking for completeness...'),
    not(completeClassHasNoSpecificBase),
    loginfoln('passed').

% This is desired logging level in numeric form when in prolog mode.  It's not used in C++
% mode, but it's in this file because it need to be called early in both modes.
:- dynamic logLevel/1.
setDefaultLogLevel :-
    logLevel(_) -> true ;
    (numericLogLevel('WARN', N),
     assert(logLevel(N)),
     loginfoln('Setting default log level to ~d', [N])
    ).

initialSanityChecks :-
    sanityChecks -> true;
    logfatalln('Initial sanity check failed, indicating the OO rules are incorrect.'),
    logfatalln('Please report this failure to the Pharos developers!'),
    throw_with_backtrace(error(system_error(initialSanityChecks))).

% The Source should either be ooanalyzer_tool or ooscript, and is only used right now to pick
% the relevant error message when we run out of table or stack space.
solve(Source) :-
    catch(solve_internal, E, (
                               % Handle the different exceptions
                               ( E = error(resource_error(private_table_space), _) -> complain_table_space(Source)
                               ; E = error(resource_error(stack), _) -> complain_stack_size(Source)
                               ; true
                               ),
                               % In all cases rethrow the exception
                               throw(E)
         )),
    % We should never backtrack past this point
    !.

complain_table_space(ooanalyzer_tool) :-
    logfatalln('Ran out of private table space.  Re-run, increasing the table'),
    logfatalln('size with the option `--option prolog_table_space=<value>`, using'),
    logfatalln('a value that is greater than that reported by `--dump-config`.').

complain_table_space(ooscript) :-
    logfatalln('Ran out of private table space.  Re-run, increasing the table'),
    logfatalln('size by passing a larger value for --table-space.').

complain_table_space(X) :-
    logfatalln('Ran out of private table space when running unknown ''~p''.', [X]),
    logfatalln('Something went terribly wrong.  File a bug.').

complain_stack_size(ooanalyzer_tool) :-
    logfatalln('Ran out of Prolog stack space.  Re-run, increasing the stack'),
    logfatalln('size with the option `--option prolog_stack_limit=<value>`, using'),
    logfatalln('a value that is greater than that reported by `--dump-config`.').

complain_stack_size(ooscript) :-
    logfatalln('Ran out of Prolog stack space.  Re-run, increasing the stack'),
    logfatalln('size by passing a larger value for --stack-limit.').

complain_stack_size(X) :-
    logfatalln('Ran out of Prolog stack space when running unknown ''~p''.', [X]),
    logfatalln('Something went terribly wrong.  File a bug.').

% Solve when guessing is disabled
solve_internal :-
    setDefaultLogLevel,
    version_check,
    guessingDisabled,
    !,
    (loginfoln('Reasoning about object oriented constructs based on known facts ...'),
    reportRTTIResults,
    reportStage('Initial reasoning'),
    reasonForwardAsManyTimesAsPossible,
    reportStage('Initial reasoning complete'),
    initialSanityChecks,
    loginfoln('Guessing was disabled, finalizing answer.')
    ;
    logfatalln('No complete solution was found!')).

% Solve when guessing is enabled
solve_internal :-
    !,
    (loginfoln('Reasoning about object oriented constructs based on known facts ...'),
    reportRTTIResults,
    reportStage('Initial reasoning'),
    reasonForwardAsManyTimesAsPossible,
    reportStage('Initial reasoning complete'),
    initialSanityChecks,
    loginfoln('Making new hypothetical guesses ...'),
    reasoningLoop,
    loginfoln('No plausible guesses remain, finalizing answer.')
    ;
    logfatalln('No complete solution was found!')).

/* Local Variables:   */
/* mode: prolog       */
/* fill-column:    95 */
/* comment-column: 0  */
/* End:               */
