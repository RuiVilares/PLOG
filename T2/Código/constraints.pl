:- use_module(library(clpfd)).
:- use_module(library(lists)).

createBoard(Size, Board) :-
	createBoardAux(Size, Size, [], Board).

createBoardAux(0, _, Board, Board).
createBoardAux(CurrentPos, Size, BoardTemp, Board) :-
	CurrentPos > 0,
	length(Row, Size),
	CurrentPos1 is CurrentPos - 1,
	createBoardAux(CurrentPos1, Size, [Row|BoardTemp], Board).

setDomain(_, []).
setDomain(Size, [Row|Board]) :-
	domain(Row, 1, Size),
	setDomain(Size, Board).

setDifferentRow([]).
setDifferentRow([Row|Board]) :-
	all_distinct(Row),
	setDifferentRow(Board).

setDifferentCol(Board, NewBoard) :-
	transpose(Board, NewBoard),
	setDifferentRow(NewBoard).

setDifferent(Board, NewBoard) :-
	setDifferentRow(Board),
	setDifferentCol(Board, NewBoard).

label([]).
label([Row|Board]) :-
	labeling([], Row),
	label(Board).

create(Size, Board) :-
	createBoard(Size, Board),
	setDomain(Size, Board),
	setDifferent(Board, NewBoard),
	label(NewBoard).