% ============================================================================================
% Rules for tracking which methods are assigned to which classes.
% ============================================================================================

% This predicate always holds the current mapping of objects to class.
:- dynamic findint_current/2 as (incremental).

% This predicate holds the current and previous mapping of objects to class.
:- dynamic findint/2 as (incremental, monotonic).

:- use_module(library(apply), [maplist/2, include/3]).
:- use_module(library(lists), [member/2]).

make(M) :-
    try_assert(findint(M, M)),
    try_assert(findint_current(M, M)).

unionhelp(Rold, Rnew, M) :-
    % Remove the current mapping
    try_retract(findint_current(M, Rold)),
    % Add the new mappings
    try_assert(findint(M, Rnew)),
    try_assert(findint_current(M, Rnew)).

union(M1, M2) :-

    % Rnew is the new representative for everybody!
    find_current(M1, Rnew),
    % Rold is the old representative
    find_current(M2, Rold),

    % Let's move all the members in S2 to S1.
    findall(M2, S2),

    maplist(unionhelp(Rold, Rnew),
            S2).

makeIfNecessary(M) :-
    findint(M, _S) -> true;
    (make(M),
     logerror('Error: Unknown method '), logerrorln(M)).

find(M, R) :-
    findint(M, R).

find_current(M, R) :-
    findint_current(M, R).

is_current(C) :-
    findint_current(C, C).

findVFTable(V, R) :-
    findint(V, R),
    factVFTable(V).

findVFTable_current(V, R) :-
    find_current(V, R),
    factVFTable(V).

findVFTable(VFTable, Offset, Class) :-
    findVFTable(VFTable, Class),
    factVFTableWrite(_Insn, Method, Offset, VFTable),
    find(Method, Class).

findVFTable_current(VFTable, Offset, Class) :-
    findVFTable_current(VFTable, Class),
    factVFTableWrite(_Insn, Method, Offset, VFTable),
    find_current(Method, Class).

findMethod(M, R) :-
    findint(M, R),
    factMethod(M).

findMethod_current(M, R) :-
    find_current(M, R),
    factMethod(M).

% XXX: I think this is ok for current?

% Find all objects on M's class
findall(M, S) :-
    find(M, R),
    setof(X, find(X, R), S).

% Filter out non-methods...
findallMethods(C, O) :- findall(C, L), include(factMethod, L, O).

numberOfMethods(C, O) :- findallMethods(C, L),
                         length(L, O).

findAllClasses(S) :-
    setof(C, M^find(M, C), S).

class(C) :-
    findAllClasses(S),
    member(C, S).

/* Local Variables:   */
/* mode: prolog       */
/* fill-column:    95 */
/* comment-column: 0  */
/* End:               */
