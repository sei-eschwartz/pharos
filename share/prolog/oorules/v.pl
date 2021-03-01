:- module(v,
          [ d/0,
            queued_from/1
          ]).
:- use_module(verify).

:- meta_predicate
    queued_from(0).

/** <module> Setup debugging

Usage:

    ooprolog --load_only ...
    ?- [v].
    ?- d.
    ?- run.

Edit d/0 as needed for current task.
*/

%!  d
%
%   Setup debugging as we want it now.

d :-
    check_tabled_preds,
    debug,
    clr,
%   break(user:reasonObjectInObject(_,_,_), 7),
%   debug(tabling(reeval)),
%   trace('$tabling':mon_propagate/3),
%   trace(system:'$mono_idg_changed'/2),
%   trace(system:'$tbl_monotonic_add_answer'/2),
    protocol(x),
    at_halt(noprotocol).

%!  queued_from(+Variant)
%
%   Show answers queued on depedencies to Variant

queued_from(Variant) :-
    get_call(Variant, ATrie, _Ret),
    (   '$idg_mono_affects_lazy'(ATrie, SrcTrie, Dep, _DepRef, Answers),
        maplist(clause_head, Answers, Heads),
        format('From ~p: ~p~nDep: ~p~n', [SrcTrie, Heads, Dep]),
        fail
    ;   true
    ).

clause_head(ClauseRef, Head) :-
    '$tabling':'$clause'(Head, _Body, ClauseRef, _Bindings).

user:portray(Addr) :-
    integer(Addr),
    Addr > 100000,
    Addr < 1<<30,
    format('0x~16r', [Addr]).
user:portray(ClauseRef) :-
    blob(ClauseRef, clause),
    clause_head(ClauseRef, Head),
    format('~w=>(~p)', [ClauseRef, Head]).
