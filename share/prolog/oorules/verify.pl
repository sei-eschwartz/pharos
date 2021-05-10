:- module(verify,
          [ check_idg/0,
            check_table/1,              % :Goal
            check_tabled_pred/1,        % :Head
            check_tabled_preds/0,
            break/2                     % :Goal,+Count
          ]).
:- use_module(library(aggregate)).
:- use_module(library(debug)).
:- use_module(library(prolog_wrap)).
:- use_module(library(prolog_code)).
:- use_module(library(increval)).
:- use_module(library(prolog_stack)).
:- use_module(library(tables)).
:- use_module(library(tdump)).
:- use_module(library(ordsets)).
:- use_module(library(apply)).

:- set_prolog_flag(backtrace_goal_depth, 20).

:- meta_predicate
    break(0, +),
    check_table(0),
    check_tabled_pred(:).

:- multifile
    user:check_idg_hook/0.

user:check_idg_hook :-
    check_idg.

%!  check_idg
%
%   Verify the falsecount for all  nodes, reporting inconsistencies. The
%   falsecount of a node must equal  the number of invalid dependencies.
%   If there are dynamic dependencies the falsecount may be higher.

check_idg :-
    forall(idg_node(Node),
           check_idg(Node)).

idg_node(ATrie) :-
    '$tbl_variant_table'(VTrie),
    trie_gen(VTrie, _, ATrie).

check_idg(Node) :-
    table_variant(Node, Variant),
    predicate_property(Variant, dynamic),
    predicate_property(Variant, incremental),
    !.                                  % dynamic incremental predicate
check_idg(Node) :-
    aggregate_all(count, invalid_dependent(Node, _Dep), InvalidDeps),
    fc(Node, FalseCount),
    (   FalseCount >= InvalidDeps
    ->  true
    ;   print_message(error, invalid_idg(Node, FalseCount, InvalidDeps)),
        table_variant(Node, Variant),
        idg(user:Variant),
        backtrace(25),
        abort
    ).

invalid_dependent(Node, _Dep) :-
    '$idg_edge'(Node, dependent, DepTrie),
    '$idg_falsecount'(DepTrie, FC),
    FC > 0,
    table_variant(DepTrie, Variant),
    \+ predicate_property(Variant, dynamic).

fc(ATrie, FC) :-
    (   '$idg_falsecount'(ATrie, FC0)
    ->  FC = FC0
    ;   FC = 0
    ).

table_variant(ATrie, TM:Variant) :-
    '$tbl_table_status'(ATrie, _Status, TM:TVariant, _Return),
    (   TM:'$table_mode'(Variant, TVariant, _TModed)
    ->  true
    ;   Variant = TVariant
    ).

%!  check_tabled_preds
%
%   Enable check_tabled_pred/1 on all incremental   and monotonic tabled
%   predicates.

check_tabled_preds :-
    (   Pred = user:_,
        predicate_property(Pred, tabled),
        (   predicate_property(Pred, incremental)
        ->  true
        ;   predicate_property(Pred, monotonic)
        ),
        pi_head(PI, Pred),
        check_tabled_pred(PI),
        fail
    ;   true
    ).

%!  check_tabled_pred(:PI)
%
%   Check a single tabled predicate.  This   adds  a  wrapper around the
%   predicate that verifies the table  content   each  time the goal has
%   completed _and_ the table  is  complete.   We  then  get the correct
%   answers by running the goal  in  a   new  thread  (thus tabling from
%   scratch) and compare the content of the  table with the answers from
%   the thread.
%
%   The number of times a variant has   been  validated is maintained in
%   checked/3. Subsequently, break/2 may be  used to interrupt execution
%   just before the wrong evaluation.

check_tabled_pred(PI) :-
    pi_head(PI, Head),
    wrap_predicate(Head, check_tables, Wrapped,
                   verify:check_table(Head, Wrapped)),
    print_message(informational, checking_tables(PI)).

check_table(Head, Wrapped) :-
    maybe_break(Head),
    (   call(Wrapped)
    ;   current_table(Head, ATrie),
        '$tbl_table_status'(ATrie, complete),
        check_table(Head),
        fail
    ).

%!  check_table(:Goal)
%
%   Verify a table evaluates to the right answers.

check_table(Goal) :-
    thread_self(Me),
    Me == main,
    \+ ( current_prolog_flag(break_level, Level), Level > 0 ), % disable inside a break
    !,
    solutions_from_table(Goal, Answers),
    (   transaction_updates(Updates)
    ->  true
    ;   Updates = []
    ),
    thread_create(get_all_solutions(Goal, Updates, Me), Id, []),
    thread_get_message(answers(OkAnswers)),
    thread_join(Id),
    count(Goal, NthCall),
    (   maplist(=@=, OkAnswers, Answers)
    ->  true
    ;   format(user_error, 'Wrong answers for ~p (iteration ~d) ~n',
               [Goal, NthCall]),
        show_difference(Answers, OkAnswers),
        (   current_prolog_flag(break_level, _) % interactive
        ->  break
        ;   abort
	)
    ).
check_table(_).

solutions_from_table(Goal, Answers) :-
    get_call(Goal, Trie, Ret),
    findall(Goal, get_returns(Trie, Ret), Answers0),
    sort(Answers0, Answers).

all_solutions(Goal, Answers) :-
    forall(Goal, true),                 % fill the table
    assertion(\+ incr_is_invalid(Goal)),
    findall(Goal, Goal, Answers0),
    sort(Answers0, Answers).

get_all_solutions(Goal, [], SendTo) :-
    !,
    all_solutions(Goal, Answers),
    thread_send_message(SendTo, answers(Answers)).
get_all_solutions(Goal, Updates, SendTo) :-
    length(Updates, Count),
    snapshot(( format(user_error,
                      'Checking ~p; updating snapshot with ~D actions~n',
                      [Goal, Count]),
               maplist(copy_from_transaction, Updates),
               all_solutions(Goal, Answers),
               format(user_error,
                      'Snapshot re-evaluation of ~p done~n',
                      [Goal])
             )),
    thread_send_message(SendTo, answers(Answers)).

copy_from_transaction(asserta(ClauseRef)) :-
    '$tabling':'$clause'(Head, _Body, ClauseRef, _Bindings),
    asserta(Head).
copy_from_transaction(assertz(ClauseRef)) :-
    '$tabling':'$clause'(Head, _Body, ClauseRef, _Bindings),
    assertz(Head).
copy_from_transaction(erased(ClauseRef)) :-
    '$tabling':'$clause'(Head, _Body, ClauseRef, _Bindings),
    retractall(Head).

:- dynamic
    count_engine_store/1,
    checked/3,
    break/3.

%!  count(+Goal, -Count)
%
%   Count checks for Goal. This  is  tricky   as  the  evaluation can be
%   inside a transaction and we want to make the count global.  To do so
%   we use an engine.

count(Goal, Count) :-
    count_engine(Engine),
    engine_post(Engine, Goal, Count).

count_engine(Engine) :-
    count_engine_store(Engine),
    !.
count_engine(Engine) :-
    engine_create(x, do_count, Engine),
    asserta(count_engine_store(Engine)).

do_count :-
    engine_fetch(Goal),
    variant_sha1(Goal, Hash),
    (   retract(checked(Hash, Goal, Count0))
    ->  Count is Count0+1
    ;   Count = 1
    ),
    asserta(checked(Hash, Goal, Count)),
    engine_yield(Count),
    do_count.

:- initialization count(init, _).

%!  break(:Goal, +Count)
%
%   Break before the execution of the Count iteration to Goal.

break(Goal, Count) :-
    variant_sha1(Goal, Hash),
    asserta(break(Hash, Goal, Count)).

maybe_break(Goal) :-
    thread_self(main),
    variant_sha1(Goal, Hash),
    break(Hash, Goal, BreatAt),
    (   checked(Hash, Goal, Count0)
    ->  Count is Count0+1
    ;   Count = 1
    ),
    Count =:= BreatAt,
    !,
    format(user_error, 'Break on ~p, iteration ~D~n', [Goal, BreatAt]),
    break.
maybe_break(_).

show_difference(Answers, OkAnswers) :-
    length(Answers, Found),
    length(OkAnswers, Expected),
    ord_subtract(Answers, OkAnswers, Extra),
    ord_subtract(OkAnswers, Answers, Missing),
    format(user_error,
           'Expected ~D answers, found ~D~n\c
            Missing: ~p~n\c
            Extra:   ~p~n',
           [Expected, Found, Missing, Extra]).


		 /*******************************
		 *            MESSAGES		*
		 *******************************/

prolog:message(invalid_idg(Node, FalseCount, InvalidDeps)) -->
    { table_variant(Node, Variant) },
    [ '~p (~p) has falsecount ~D and ~D invalid dependencies'-
      [Node, Variant, FalseCount, InvalidDeps] ].
prolog:message(checking_tables(PI)) -->
    [ 'Checking tables for ~p'-[PI] ].
