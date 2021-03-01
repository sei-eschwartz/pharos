:- dynamic profilingEnabled/0.
:- ensure_loaded(logging).
:- ensure_loaded(rules).
:- ensure_loaded(forward).
:- ensure_loaded(softcut).
:- ensure_loaded(class).
reasonForward :-
    once((concludeMethod(Out);
          concludeClassCallsMethod(Out)
        )),
    if_(call(Out),
        (logerrorln('An internal error occurred in OOAnalyzer. Please report this to the developers:~n~Q', Out),
         throw_with_backtrace(error(system_error(reasonForward), Out)))).
reasonForwardAsManyTimesAsPossible :-
    if_(reasonForward,
        reasonForwardAsManyTimesAsPossible,
        logdebugln('reasonForwardAsManyTimesAsPossible complete.')).
solve(Source) :-
    catch(solve_internal, E, (
                               throw(E)
         )),
    (loginfoln('Reasoning about object oriented constructs based on known facts ...'),
    logfatalln('No complete solution was found!')).
solve_internal :-
    (loginfoln('Reasoning about object oriented constructs based on known facts ...'),
    reasonForwardAsManyTimesAsPossible,
    logfatalln('No complete solution was found!')).
