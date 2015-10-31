
%put pc piece (player 2)
pcMove(Board, NewBoard):-
	repeat,
		once(random(0, 8, Row)),
		once(random(0, 8, Col)),
		once(checkValidPosition(Board, Row, Col)),
		insertPiece(Board, 2, Row, Col, NewBoard),
	!.

%returns a valid list of NumBoards that the pc can play
%this predicate can be omitted
%and only used the pcValidMovesAux
%this function is useful for debug
pcValidMoves(Board, NumBoards, NewBoards) :-
	emptyBoard(Board),
	pcValidMovesAux(Board, NumBoards, NewBoards),
	printNew(NewBoards).

%print a list of boards (temporary)
printNew([]).
printNew([X|Xs]) :-
	%write(X),nl,nl,nl,
	printBoard(X),
	printNew(Xs).

%returns a valid list of NumBoards that the pc can play
pcValidMovesAux(X, 0, []).
pcValidMovesAux(Board, NumBoards, [BoardTemp|NewBoards]) :-
	NumBoards > 0,
	N is NumBoards - 1,
	pcMove(Board, BoardTemp),
	pcValidMovesAux(Board, N, NewBoards).