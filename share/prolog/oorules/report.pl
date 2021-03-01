:- ensure_loaded(setup).
psolve_no_halt(X) :-
    (profilingEnabled ->
         setup_call_cleanup(
             remove_alarm(Id));
     solve(ooscript)),
    !.
