# Implementace Conways Game of Life
Conway’s Game of Life je jednoduchý celulární automat, který je Turing kompletní.

## Example usage

- First of all, you need to set 2d array like i did it below:
```prolog 
%%10X10 
main:-
  game_loop([
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,1,1,1,1,0,0,0],
      [0,0,1,0,0,0,0,1,0,0],
      [0,0,1,0,0,0,1,1,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,1,0,0,0,0,0,0,0],
      [0,0,1,1,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0]
      ]).
```

- Then you need to set height and width according to your size of 2D array. These two functions stop a recursion.
```prolog
%%height
evolved_world(_,10,[]).

%%width
evolve_world_util(_,_,10,[]).
```

- After all, in the function `cell_current_state` set `between` in range of (height  - 1) and (width - 1):
```prolog
cell_current_state(World,Height,Width,State):-
  between(0,9,Height),
  between(0,9,Width),
  nth0(Height, World, HeightCells), %%nth0(?Index, ?List, ?Elem)
  nth0(Width,HeightCells,State). 
  ```