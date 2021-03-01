:- module(verify,
          [ check_idg/0,
            check_tabled_preds/0,
            break/2                     % :Goal,+Count
          ]).
check_tabled_preds :-
    (   Pred = user:_,
        (   predicate_property(Pred, incremental)
        ),
        pi_head(PI, Pred),
        check_tabled_pred(PI),
        fail
    ).
check_tabled_pred(PI) :-
    pi_head(PI, Head),
    wrap_predicate(Head, check_tables, Wrapped,
                   verify:check_table(Head, Wrapped)),
    (   call(Wrapped)
    ;   current_table(Head, ATrie),
        check_table(Head),
        fail
    ).
check_table(Goal) :-
    (   OkAnswers == Answers
    ;   format(user_error, 'Wrong answers for ~p (iteration ~d) ~n',
               [Goal, NthCall]),
        abort
    ).
