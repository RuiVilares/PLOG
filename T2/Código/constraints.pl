:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(between)).
:- use_module(library(aggregate)).
:- include('display.pl').
:- include('asserts.pl').

%cria um tabuleiro de tamanho Size
%Size deve estar instaciado, mas Board não
%um tabuleiro é uma lista (linhas) de listas (colunas)
createBoard(Size, Board) :-
	createBoardAux(Size, Size, [], Board).

%este predicado e auxiliar do predicado createBoard de modo a poder proporcionar uma abstração para o utilizador
%CurrentPos e a linha atual
%Size e o tamanho da linha
%BoardTemp e o tabuleiro atual temporario
%Board vai ser o tabuleiro final instanciado
createBoardAux(0, _, Board, Board).
createBoardAux(CurrentPos, Size, BoardTemp, Board) :-
	CurrentPos > 0,
	length(Row, Size),
	CurrentPos1 is CurrentPos - 1,
	createBoardAux(CurrentPos1, Size, [Row|BoardTemp], Board).

%definicao do dominio de cada lista (linha) de 1 ate Size
setDomain(_, []).
setDomain(Size, [Row|Board]) :-
	domain(Row, 1, Size),
	setDomain(Size, Board).

%retricao de que cada linha deve ter todos os valores diferentes
setDifferentRow([]).
setDifferentRow([Row|Board]) :-
	all_distinct(Row),
	setDifferentRow(Board).

%restricao de que cada coluna deve ter valores diferentes
setDifferentCol(Board, NewBoard) :-
	transpose(Board, NewBoard1),
	setDifferentRow(NewBoard1),
	transpose(NewBoard1, NewBoard).

%restricao do tabuleiro com os valores de cada linha e cada coluna diferentes entre si
setDifferent(Board, NewBoard) :-
	setDifferentRow(Board),
	setDifferentCol(Board, NewBoard).

%apaga o elemento numero Index da lista do primeiro argumento
deleteIndex([_|L],0,L).
deleteIndex([H|Rest],Index,[H|NewList]) :-
	NewIndex is Index - 1,
	deleteIndex(Rest,NewIndex,NewList).

%seleciona um elemento da lista Vars
%Rest passa a ser a lista Vars sem esse elemento
sel(Vars,Selected,Rest) :-
	length(Vars,N1),
	N is N1 - 1,
	random(0,N,RandomIndex),
	nth0(RandomIndex,Vars,Selected),
	var(Selected),
	deleteIndex(Vars,RandomIndex,Rest).

%faz o labeling de cada linha
%escolhe o proximo elemento de forma aleatoria
labelCreate(Board) :-
	append(Board, B),
	labeling([variable(sel)], B).

%cria um tabuleiro de tamanho Size para ser resolvido
create(Size, Board) :-
	createBoard(Size, Board),
	setDomain(Size, Board),
	setDifferent(Board, NewBoard),
	labelCreate(NewBoard).

%faz o labeling para resolver o tabuleiro com as restricoes anteriormente criadas
labelSolve(Board) :-
	append(Board, B),
	labeling([ffc], B).

%cria as restricoes dos pontos brancos e pretos
setAsserts(_, Size, Size, Size).
setAsserts(Board, Size, Col, Size) :-
	Col1 is Col + 1,
	getMatrixElemAt(Size, Col, Board, Elem),
	getMatrixElemAt(Size, Col1, Board, ElemRight),
	dotHor(Elem, ElemRight, Size, Col),
	setAsserts(Board, Size, Col1, Size).

%cria as restricoes dos pontos brancos e pretos
setAsserts(Board, Row, Size, Size) :-
	Row1 is Row + 1,
	getMatrixElemAt(Row, Size, Board, Elem),
	getMatrixElemAt(Row1, Size, Board, ElemDown),
	dotVer(Elem, ElemDown, Row, Size),
	setAsserts(Board, Row1, 1, Size).

%cria as restricoes dos pontos brancos e pretos
setAsserts(Board, Row, Col, Size) :-
	Col1 is Col + 1,
	Row1 is Row + 1,
	getMatrixElemAt(Row, Col, Board, Elem),
	getMatrixElemAt(Row, Col1, Board, ElemRight),
	getMatrixElemAt(Row1, Col, Board, ElemDown),
	dotHor(Elem, ElemRight, Row, Col),
	dotVer(Elem, ElemDown, Row, Col),
	setAsserts(Board, Row, Col1, Size).

%verifica se existe uma restricao horizontalmente com ponto preto
dotHor(Elem, ElemRight, Row, Col):-
	horizontal(Row, Col, black),
	Elem #= ElemRight * 2 #\/ ElemRight #= Elem * 2.

%verifica se existe uma restricao horizontalmente com ponto branco
dotHor(Elem, ElemRight, Row, Col):-
	horizontal(Row, Col, white),
	Elem #= ElemRight + 1 #\/ Elem #= ElemRight - 1.

%nao existe nenhuma restricao horizontalmente
dotHor(_, _, _, _).

%verifica se existe uma restricao verticalmente com ponto preto
dotVer(Elem, ElemDown, Row, Col):-
	vertical(Row, Col, black),
	Elem #= ElemDown * 2 #\/ ElemDown #= Elem * 2.

%verifica se existe uma restricao verticalmente com ponto branco
dotVer(Elem, ElemDown, Row, Col):-
	vertical(Row, Col, white),
	Elem #= ElemDown + 1 #\/ Elem #= ElemDown - 1.

%nao existe nenhuma restricao verticalmente
dotVer(_, _, _, _).

%resolve e cria um tabuleiro com as restricoes criadas anteriormente
solveUser(Size, Board) :-
	length(Board, Size),
	setDomain(Size, Board),
	setDifferent(Board, SolvedBoard),
	setAsserts(SolvedBoard, 1, 1, Size),
	labelSolve(SolvedBoard).
