concludeMethod(Out) :-
    setof(Method,
          (reasonMethod(Method),
           loginfoln('Concluding ~Q.', factMethod(Method))),
          MethodSets),
    Out = ((all(ActionSets),
            makeObjects(MethodSets))).
