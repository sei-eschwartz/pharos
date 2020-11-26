:- use_module(library(prolog_codewalk)).

/** <module> Analysis dependencies

The predicate guess/0 implements guesses. It calls guess*(-Out), where
Out is a goal realizing the guess.


*/

% :- debug(depends).

%!  guess(-Guess, -Goal) is nondet.
%
%   True when Goal is produced by Guess

guess(Guess, Goal) :-
    clause(guess, Body),
    body_term_calls(Body, once(Guesses)),
    !,
    semicolon_list(Guesses, List),
    member(Guess, List),
    (   arg(1, Guess, Out),
        clause(Guess, GuessBody),
        body_term_calls(GuessBody, Out2 = Goal0),
        Out == Out2
    ->  Goal = Goal0
    ;   Goal = ?
    ).

:- dynamic
    call_edge/2.

%!  uses(+Callee, -Caller) is nondet.
%
%   True  when  Caller  calls  Callee.  Both  arguments  are  _predicate
%   indicators_.

uses(Callee, Caller) :-
    pi_head(Callee, Goal),
    calls_pi(Goal, Caller).

%!  asserts(?Asserted, -Caller) is nondet.
%
%   True  if  Asserted  is  asserted  by   Caller.  Both  arguments  are
%   _predicate indicators_.

asserts(Asserted, Caller) :-
    var(Asserted),
    !,
    calls_pi(try_assert(Goal), Caller),
    pi_head(Asserted, Goal).
asserts(Asserted, Caller) :-
    pi_head(Asserted, Goal),
    calls_pi(try_assert(Goal), Caller).

calls_pi(Goal, CallerPI) :-
    distinct(CallerPI, (calls(Goal, Caller), pi_head(CallerPI, Caller))).

calls(Goal, Caller) :-
    prolog_walk_code([ module(user),
                       trace_reference(user:Goal),
                       source(false),
                       on_trace(hit)
                     ]),
    findall(Callee-Caller, retract(call_edge(Callee, Caller)), Pairs),
    member(Goal-Caller, Pairs).

hit(user:Callee, user:Caller, Location) :-
    debug(depends, '~p calls ~p at ~p', [Caller, Callee, Location]),
    assertz(call_edge(Callee, Caller)).

%!  input(?Term)
%
%   True if Term is external input to the program

input(callingConvention(_Ptr, _Convention)).
input(callParameter(_Ptr1, _Ptr2, _How, _SV)).
input(callReturn(_Ptr1, _Ptr2, _How, _SV)).
input(callTarget(_Ptr1, _Ptr2, _Ptr3)).
input(fileInfo(_Hash, _File)).
input(funcOffset(_Insn, _Function, _Method, _Offset)).
input(funcParameter(_Ptr, _Reg, _SV)).
input(funcReturn(_Ptr, _Reg, _SV)).
input(initialMemory(_Ptr1, _Ptr2)).
input(insnCallsDelete(_Ptr1, _Ptr2, _SV)).
input(methodMemberAccess(_Ptr1, _Ptr2, _Hex1, _Hex2)).
input(noCallsAfter(_Ptr)).
input(noCallsBefore(_Ptr)).
input(possibleVirtualFunctionCall(_Ptr1, _Ptr2, _SV, _, _)).
input(returnsSelf(y_Ptr)).
input(thisPtrAllocation(_Ptr1, _Ptr2, _SV, _, _)).
input(thisPtrUsage(_Ptr1, _Ptr2, _SV, _Ptr3)).
input(thunk(_Ptr1, _Ptr2)).
input(uninitializedReads(_Ptr)).
