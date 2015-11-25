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
	transpose(Board, NewBoard),
	setDifferentRow(NewBoard).

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

label([]).
label([Row|Board]) :-
	labeling([variable(sel)], Row),
	label(Board).

create(Size, Board) :-
	createBoard(Size, Board),
	setDomain(Size, Board),
	setDifferent(Board, NewBoard),
	label(NewBoard),
	printBoard(Board).

solve(Board, SolvedBoard) :-
	length(Board, Size),
	setDomain(Size, SolvedBoardTemp),
	setDifferent(SolvedBoardTemp, SolvedBoard),
	
	label(SolvedBoard).