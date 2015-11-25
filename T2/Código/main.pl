:- include('constraints.pl').

kropki(Size) :-
	Size > 1,
	retractall(horizontal(_,_,_)),
	retractall(vertical(_,_,_)),
	create(Size, Board),
	%once(printBoard(Board)),
	assertDots(Board),
	%once(printBoard(Board)),
	createBoard(Size, BoardToSolve),
	once(printBoard(BoardToSolve)),
	solveUser(Size, BoardToSolve),
	once(printBoard(BoardToSolve)).

kropki(_) :-
  write('Enter a value bigger than 1.'), nl,
  fail.
