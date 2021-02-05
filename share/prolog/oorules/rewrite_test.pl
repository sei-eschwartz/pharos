:- multifile classArgs/2.

:- table translateArgs/2.

% We translate class arguments in facts
translateArgs(A, B) :- classArgs(A, B).

% and in reason
translateArgs(Pred/Arity, Index) :-
    % If we see reasonFoo_A, translate it if factFoo is a class arg.
    sub_atom(Pred, 0, 6, _After1, reason),

    %writeln(Pred),
    sub_atom(Pred, 6, _Length, _After2, APrefix),
    %atom(APrefix),
    %format('A prefix: ~w~n', APrefix),
    atom_concat(fact, APrefix, TryPred),
    %format('Well? ~w~n', TryPred),
    classArgs(TryPred/Arity, Index),
    format('Success ~w!~n', TryPred).



user:term_expansion(Old, Old) :-
    %format('Term ~w~n', Old),
    fail.

user:goal_expansion(Old, New) :-
    functor(Old, Pred, Arity),
    %format('Goal ~w~n', Old),
    translateArgs(Pred/Arity, _Index),

    %format('You know Im gonna do it ~w~n', Old),

    translateFactCall(Old, New),

    format('~n~nFrom ~w to ~w~n~n~n', [Old, New]).

% Any time we are calling factFoo(X), we need to rewrite it as factFoo(_,X)

translateFactCall(OldFact, Out) :-
    OldFact =.. [Pred|Args],
    length(Args, Remaining),
    translateFactCall(OldFact, Pred/Remaining, Remaining, [], Out).

% Base case
translateFactCall(OldFact, Pred/Arity, 0, Accum, Out) :-
    !,

    Out =.. [Pred|Accum].

translateFactCall(OldFact, Pred/Arity, Remaining, Accum, Out) :-
    arg(Remaining, OldFact, Arg),

    % For normal arguments, we just append.  For class arguments, we duplicate.
    (translateArgs(Pred/Arity, Remaining)
    ->
        % Class arg
        append([_,Arg], Accum, NextAccum)
    ;
    % Normal arg
    NextAccum = [Arg|Accum]),

    Next is Remaining - 1,
    translateFactCall(OldFact, Pred/Arity, Next, NextAccum, Out).

%% Local Variables:
%% mode: prolog
%% End:
