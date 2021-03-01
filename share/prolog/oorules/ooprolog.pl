#!/usr/bin/env swipl
:- prolog_load_context(directory, Dir),
   assert(base_directory(Dir)).
:- initialization(main, main).

nohalt :-
    set_prolog_flag(toplevel_goal, prolog).
check_option(X, O) :-
    option(X, O),
    X =.. [_, Y],
    \+ var(Y).
setup_oorules_path(_) :-
    base_directory(Dir), !,
    working_directory(CWD, CWD),
    assertz(file_search_path(pharos, CWD)).
          absolute_file_name(CDir, Dir))).

ooprolog_opts_spec(
    [
      [opt(facts), longflags([facts]), shortflags(['f']),
       type(atom), help('input facts file')],
      [opt(results), longflags([results]), shortflags(['r']),
       type(atom), help(['path for Prolog results',
                         'output when used with --facts',
                         'input when not used with --facts'])],

      [opt(rtti), longflags([rtti]), shortflags(['R']), type(boolean),
       default(true), help('enable RTTI analysis')],
      [opt(guess), longflags([guess]), shortflags(['G']), type(boolean),
       default(true), help('enable guessing')],
      [opt(loglevel), longflags(['log-level']), shortflags([l]),
       type(integer), default(3), help('logging level (0-7)')],

      [opt(verify), longflags([verify]), type(boolean),
       default(false), help('automatically verify tables')],

      [opt(help), longflags([help]), shortflags(['h']), type(boolean),
       help('output this message')]
    ]).

                  [Thing, Val]), halt(1))).

parse_options(OptsSpec, Args, Opts, Positional) :-
    %% opt_parse/4 outputs the option help to user_error when an unknown option is passed.  The
    setup_call_cleanup(
        (set_stream(user_error, alias(saved_user_error)),
         open_null_stream(Null),
         set_stream(Null, alias(user_error))),
        catch(opt_parse(OptsSpec, Args, Opts, Positional), E, true),
        (set_stream(saved_user_error, alias(user_error)),
         close(Null))),
    (var(E), ! ;
     exit_failure).


run_with_backtrace(X) :-
    catch_with_backtrace(
        X, Exception,
        (print_message(error, Exception), (globalHalt -> halt(1) ; true))).

main :-
    set_prolog_flag(color_term, true),
    current_prolog_flag(argv, Argv),
    source_file(main, Script),
    catch(main([Script|Argv]), E,
          (print_message(error, E), halt(1))).

main([Script|Args]) :-
    ooprolog_opts_spec(OptsSpec), !,
    parse_options(OptsSpec, Args, Opts, Positional),
    main([script(Script)|Opts], Positional).
% How can we do this better?
:- [v].

main(Opts, []) :-
    load(Opts),
    (   option(load_only(true), Opts)
    ->  asserta(runOptions(Opts))
    ;   option(verify(true), Opts)
    ->  d, run(Opts)
    ;   run(Opts)
    ).

load(Opts) :-
    setup_oorules_path(Opts), !,
    option(rtti(RTTI), Opts),
    option(guess(Guess), Opts),
    (   option(halt(true), Opts),
        \+ option(load_only(true), Opts)
    ->  assert(globalHalt)
    ;   nohalt
    ),
    option(loglevel(Loglevel), Opts),
    assert(logLevel(Loglevel)),
    consult([pharos(report), pharos(oojson), pharos(validate)]),
    ignore(RTTI -> assert(rTTIEnabled)),
    (Guess, ! ; assert(guessingDisabled)).

run(Opts) :-
    generate_results(Opts),
    generate_json(Opts),
    validate_results(Opts).
generate_results(Opts) :-
    check_option(facts(Facts), Opts),
    option(results(Results), Opts), !,
    setup_call_cleanup(
        open(Facts, read, FactStream),
        setup_call_cleanup(
            (var(Results) -> open_null_stream(ResultStream) ;
             open(Results, write, ResultStream)),
            with_output_to(ResultStream,
                           run_with_backtrace(psolve_no_halt(stream(FactStream)))),
            close(ResultStream)),
        close(FactStream)).

