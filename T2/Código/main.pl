:- include('display.pl').
:- include('constraints.pl').

kropki(Size) :-
  Size > 1,
  retractall(horizontal(_,_,_)),
  retractall(vertical(_,_,_)),
  %assertDots(Board),
  %once(printBoard(Board)),
  once(printBoard(Board)).

kropki(_) :-
  write('Enter a value bigger than 1.'), nl,
  fail.
