
%%return a state of cell in a current position
cell_current_state(World,Height,Width,State):-
  between(0,9,Height),
  between(0,9,Width),
  nth0(Height, World, HeightCells), %%nth0(?Index, ?List, ?Elem)
  nth0(Width,HeightCells,State). %%nth0(?Index, ?List, ?Elem)

%%cell that is not in a range is dead by default
cell_current_state(_,_,_,0).


%%find neighbours and count sum of their states
neighbours_counter(World,Height,Width,Amount):-
  Up is Height + 1,
  Down is Height - 1,
  Left is Width - 1,
  Right is Width + 1,

  cell_current_state(World,Up,Width,State1),
  cell_current_state(World,Down,Width,State2),
  cell_current_state(World,Height,Left,State3),
  cell_current_state(World,Height,Right,State4),
  cell_current_state(World,Up,Right,State5),
  cell_current_state(World,Up,Left,State6),
  cell_current_state(World,Down,Left,State7),
  cell_current_state(World,Down,Right,State8),
  Amount is State1 + State2 + State3 + State4 + State5 + State6 + State7 + State8.



%%we need to separate cells on dead and alive
%%for alive cells
cell_new_state(World,Height,Width,1,NewState):-
  neighbours_counter(World,Height,Width,Amount),
  ((Amount =:= 2 ; Amount =:= 3) -> NewState = 1 ; NewState = 0).

%%for dead cells
cell_new_state(World,Height,Width,0,NewState):-
  neighbours_counter(World,Height,Width,Amount),
  ( Amount =:= 3 -> NewState = 1 ; NewState = 0).

%%calculator of states.
state_controller(World,Height,Width,NewState):-
  cell_current_state(World,Height,Width,State),
  cell_new_state(World,Height,Width,State,NewState).

%%----------------------------------------------
%%generate new world
evolved_world(_,10,[]).
evolved_world(World,Height,[NewHeight|NewWorld]):-
  evolve_world_util(World,Height,0,NewHeight),
  NHeight is Height + 1,
  evolved_world(World,NHeight,NewWorld).

evolve_world_util(_,_,10,[]).
evolve_world_util(World,Height,Width,[State|NextState]):-
  state_controller(World,Height,Width,State),
  NewWidth is Width + 1,
  evolve_world_util(World,Height,NewWidth, NextState).

/*-----------------------------------------------
            print functions
-------------------------------------*/
%%when 2d array is printed we stop the recursion
world_Print([]):- nl.

%%every time we print the head of 2D array(the first array)
world_Print([H|T]):-
  write(H),
  nl,
  world_Print(T).
%%------------------------------------------

%%main loop for our game
game_loop(World):-
  world_Print(World),
  evolved_world(World,0,NewWorld),
  write('\33\[2J'),
  sleep(1),
  game_loop(NewWorld).


%%  main
main:-
  game_loop([
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,1,1,0,0,1,0,0,0],
      [0,0,1,0,0,0,1,1,0,0],
      [0,0,1,0,0,0,0,0,0,0],
      [0,0,1,0,0,0,0,1,0,0],
      [0,0,1,1,1,1,1,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0]
      ]).
