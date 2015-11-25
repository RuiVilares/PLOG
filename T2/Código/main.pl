:- include('display.pl').
:- include('asserts.pl').
:- include('constraints.pl').

kropki(Size) :-
  Size > 1,
  retractall(horizontal(_,_,_)),
  retractall(vertical(_,_,_)),
  create(Size, Board),
  %once(printBoard(Board)),
  assertDots(Board),
  once(printBoard(Board)).

kropki(_) :-
  write('Enter a value bigger than 1.'), nl,
  fail.
