% AUXILIARY PRINT FUNCTIONS

printMatrix([]).
printMatrix([Line | Tail]):-
	printList(Line), nl,
	printMatrix(Tail).

printList([]).
printList([Head | Tail]):-
	write(Head),
	write(','),
	printList(Tail).
	
	
% BOARD PRINT FUNCTIONS

%traduz o atomo para peca de jogo
translateCodeToChar(-1, ' ').
translateCodeToChar(11, '*').
translateCodeToChar(22, ':').
translateCodeToChar(X, X).

%imprime as linhas horizontais
printHorizontalLine(0).
printHorizontalLine(NumberOfDashes) :-
	write('-'),
	N is NumberOfDashes - 1,
	printHorizontalLine(N).
horizontalLine(Number) :-
	Number < 8,
	write('|'),
	printHorizontalLine(63),
	write('|').
horizontalLine(_). %para a funcao nao falhar

%imprime as linhas verticais
printBeginning(_) :-
	write('| ').
printMiddle(_) :-
	write(' | ').
printEnd(_) :-
	write(' |').
toPrintMiddle(N) :-
	N > 0,
	N < 8,
	printMiddle(_).
toPrintMiddle(_). %para nao falhar
writeChar(_, 0). %caso base
writeChar(X, N) :-
	write(X),
	N1 is N - 1,
	writeChar(X, N1).

%imprime o tabuleiro
%65 tracos horizontais
printBoard(Board) :-
	printHorizontalLine(65),
	printBoardAux(Board,0),
	printHorizontalLine(65),
	nl.

%chamada auxiliar de 'printBoard' e que desenha (Board.length div 8) vezes
printBoardAux([],_).
printBoardAux([Line|Board], CurrentNumberVertical) :-
	printBlock(Line),
	Block is CurrentNumberVertical + 1,
	nl,
	horizontalLine(Block),
	printBoardAux(Board, Block).

%imprime todos os blocos de uma linha (horizontal)
printBlock(Line) :-
	nl,
	printBeginning(_), % '| '
	printLine1(Line, 0), %desenha primeira linha do bloco
	printEnd(_), nl, % ' |\n'
	printBeginning(_),
	printLine2(Line, 0), %desenha segunda linha do bloco
	printEnd(_), nl,
	printBeginning(_),
	printLine3(Line, 0), %desenha terceira linha do bloco
	printEnd(_).

%imprime a primeira linha do bloco
print1(' ', Tile) :-
	writeChar(Tile, 5).
print1(Cross, Tile) :-
	writeChar(Cross, 1), writeChar(Tile, 3), writeChar(Cross, 1).
printLine1([], _).
printLine1([Current|Line], N) :-
	toPrintMiddle(N),
	convertCode(Current, Cross, Tile),
	print1(Cross, Tile),
	N1 is N + 1,
	printLine1(Line, N1).

%imprime a segunda linha do bloco
print2(' ', Tile) :-
	writeChar(Tile, 5).
print2(Cross, Tile) :-
	writeChar(Tile, 2), writeChar(Cross, 1), writeChar(Tile, 2).
printLine2([], _).
printLine2([Current|Line], N) :-
	toPrintMiddle(N),
	convertCode(Current, Cross, Tile),
	print2(Cross, Tile),
	N1 is N + 1,
	printLine2(Line, N1).

%imprime a terceira linha do bloco
print3(' ', Tile) :-
	writeChar(Tile, 5).
print3(Cross, Tile) :-
	writeChar(Cross, 1), writeChar(Tile, 3), writeChar(Cross, 1).
printLine3([], _).
printLine3([Current|Line], N) :-
	toPrintMiddle(N),
	convertCode(Current, Cross, Tile),
	print3(Cross, Tile),
	N1 is N + 1,
	printLine3(Line, N1).

%traduz o atomo em peca de jogo
convertCode([Cross|Tile], X, Y) :-
	convertCodeAux(Cross, Tile, X, Y).

convertCodeAux(Cross, [Tile|_], X, Y) :-
	translateCodeToChar(Cross, X),
	translateCodeToChar(Tile, Y).