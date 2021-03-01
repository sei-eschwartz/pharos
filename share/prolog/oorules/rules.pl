:- table reasonMethod_A/1 as incremental.
reasonMethod(Method) :-
    (   reasonMethod_A(Method)
    ).
reasonMethod_A(Method) :-
    factMethod(Method).
