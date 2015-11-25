:- include('constraints.pl').
:- include('display.pl').

kropki(Size) :-
  Size > 1,
  create(Size, Board).
  %printBoard(Board),
  %assertDots(Board),
  %printBoard(Board).

kropki(_) :-
  write('Enter a value bigger than 1.'), nl.
