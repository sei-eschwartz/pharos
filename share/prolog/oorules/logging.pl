numericLogLevel('INFO', 4).
logLevelEnabled(S) :-
    numericLogLevel(S, OtherLogLevel),
    logLevel(CurrentLogLevel),
    CurrentLogLevel >= OtherLogLevel.
logging_atom(Atom, Level) :-
    sub_atom(Atom, 0, _, _, log),
    numericLogLevel(Level, _).
goal_expansion(Goal, Out) :-
    functor(Goal, Name, _),
    logging_atom(Name, Level),
    (logLevelEnabled(Level) -> Out = Goal ; Out = true).
