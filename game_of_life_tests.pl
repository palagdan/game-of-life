:- load_files(game_of_life).
:- use_module(library(plunit)).
:- begin_tests(game_of_life_tests).

test(world_Print_TEST):-
  world_Print([
      [0,0,0,0,0],
      [0,0,0,0,0],
      [0,0,0,0,0],
      [0,0,0,0,0],
      [0,0,0,0,0]
      ]).
  test(cell_current_state_TEST):-
    World = [[0,0,0,0,0],
    [0,0,0,0,0],
    [0,0,0,0,0]],
    cell_current_state(World, 1, 2, State),
     !,
    State = 0.

  test(neighbours_counter_TEST):-
    World = [[0,0,0,0,0],
    [0,0,1,1,0],
    [0,0,1,0,0]],
    neighbours_counter(World,1,2,Amount),
    !,
    Amount = 2.

    %%NewState is equal to 1 and remains 1 in a new generation.
    test(cell_new_state_TEST1):-
      World = [[0,0,0,0,0],
      [0,0,1,1,0],
      [0,0,1,0,0]],
      cell_new_state(World,1,2,1,NewState),
      !,
      NewState = 1.

     %%NewState is equal to 0 and becomes 1 in a new generation.
    test(cell_new_state_TEST2):-
      World = [[0,0,0,0,0],
        [0,1,0,1,0],
        [0,0,1,0,0]],
      cell_new_state(World,1,2,0,NewState),
      !,
      NewState = 1.

      %%NewState is equal to 1 and becomes 0 in a new generation.
      test(cell_new_state_TEST3):-
        World = [[0,0,0,0,0],
          [0,0,1,0,0],
          [0,0,0,0,0]],
        cell_new_state(World,1,2,1,NewState),
        !,
        NewState = 0.

      test(state_controller_TEST):-
        World = [[0,0,0,0,0],
          [0,0,1,0,0],
          [0,0,0,0,0]],
        cell_current_state(World,1,2,State),
        cell_new_state(World,1,2,State,NewState),
        !,
        NewState = 0.

:- end_tests(game_of_life_tests).
