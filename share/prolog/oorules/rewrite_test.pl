:- multifile classArgs/2.

user:term_expansion(Old, Old) :-
    %format('Term ~w~n', Old),
    fail.

user:goal_expansion(Old, New) :-
    functor(Old, Pred, Arity),
    %format('Goal ~w~n', Old),
    classArgs(Pred/Arity, _Index),

    %format('You know Im gonna do it ~w~n', Old),

    translateFactCall(Old, New),

    format('~n~nFrom ~w to ~w~n~n~n', [Old, New]).

% Any time we are calling factFoo(X), we need to rewrite it as factFoo(_,X)
%translateFactCall(OldFact, NewFact) :-
%    functor(Old, Pred, Arity),

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
    (classArgs(Pred/Arity, Remaining)
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
