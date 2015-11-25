:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(between)).
:- use_module(library(aggregate)).
:- include('display.pl').
:- include('asserts.pl').

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
	transpose(Board, NewBoard1),
	setDifferentRow(NewBoard1),
	transpose(NewBoard1, NewBoard).

setDifferent(Board, NewBoard) :-
	setDifferentRow(Board),
	setDifferentCol(Board, NewBoard).

deleteIndex([_|L],0,L).
deleteIndex([H|Rest],Index,[H|NewList]) :-
	NewIndex is Index - 1,
	deleteIndex(Rest,NewIndex,NewList).

sel(Vars,Selected,Rest) :-
	length(Vars,N1),
	N is N1 - 1,
	random(0,N,RandomIndex),
	nth0(RandomIndex,Vars,Selected),
	var(Selected),
	deleteIndex(Vars,RandomIndex,Rest).

labelCreate([]).
labelCreate([Row|Board]) :-
	labeling([variable(sel)], Row),
	labelCreate(Board).

create(Size, Board) :-
	createBoard(Size, Board),
	setDomain(Size, Board),
	setDifferent(Board, NewBoard),
	labelCreate(NewBoard).

labelSolve([]).
labelSolve([Row|Board]) :-
	labeling([], Row),
	labelSolve(Board).

setAsserts(_, Size, Size, Size).
setAsserts(Board, Size, Col, Size) :-
	Col1 is Col + 1,
	getMatrixElemAt(Size, Col, Board, Elem),
	getMatrixElemAt(Size, Col1, Board, ElemRight),
	dotHor(Elem, ElemRight, Size, Col),
	setAsserts(Board, Size, Col1, Size).

setAsserts(Board, Row, Size, Size) :-
	Row1 is Row + 1,
	getMatrixElemAt(Row, Size, Board, Elem),
	getMatrixElemAt(Row1, Size, Board, ElemDown),
	dotVer(Elem, ElemDown, Row, Size),
	setAsserts(Board, Row1, 1, Size).

setAsserts(Board, Row, Col, Size) :-
	Col1 is Col + 1,
	Row1 is Row + 1,
	getMatrixElemAt(Row, Col, Board, Elem),
	getMatrixElemAt(Row, Col1, Board, ElemRight),
	getMatrixElemAt(Row1, Col, Board, ElemDown),
	dotHor(Elem, ElemRight, Row, Col),
	dotVer(Elem, ElemDown, Row, Col),
	setAsserts(Board, Row, Col1, Size).

dotHor(Elem, ElemRight, Row, Col):-
	horizontal(Row, Col, black),
	Elem #= ElemRight * 2 #\/ ElemRight #= Elem * 2.

dotHor(Elem, ElemRight, Row, Col):-
	horizontal(Row, Col, white),
	Elem #= ElemRight + 1 #\/ Elem #= ElemRight - 1.

dotHor(_, _, _, _).

dotVer(Elem, ElemDown, Row, Col):-
	vertical(Row, Col, black),
	Elem #= ElemDown * 2 #\/ ElemDown #= Elem * 2.

dotVer(Elem, ElemDown, Row, Col):-
	vertical(Row, Col, white),
	Elem #= ElemDown + 1 #\/ Elem #= ElemDown - 1.

dotVer(_, _, _, _).

solveUser(Size, Board) :-
	length(Board, Size),
	setDomain(Size, Board),
	setDifferent(Board, SolvedBoard),
	setAsserts(SolvedBoard, 1, 1, Size),
	labelSolve(SolvedBoard).
