/*
	Exemplo:
	printBoards([1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8],[a,b,c,d,e,f,g,h]).
	    1  2  3  4  5  6  7  8  
	  --------------------------
	1 | 1  2  3  4  5  6  7  8 |
	2 | 1  2  3  4  5  6  7  8 |
	3 | 1  2  3  4  5  6  7  8 |
	4 | 1  2  3  4  5  6  7  8 |
	5 | 1  2  3  4  5  6  7  8 |
	6 | 1  2  3  4  5  6  7  8 |
	7 | 1  2  3  4  5  6  7  8 |
	8 | 1  2  3  4  5  6  7  8 |
	  --------------------------

		1  2  3  4  5  6  7  8  
	  --------------------------
	1 | a  b  c  d  e  f  g  h |
	  --------------------------
*/

%imprime o numero de colunas
printHorizontalBorder(1) :- 
	write('    1  2  3  4  5  6  7  8  '),
	nl,
	printHorizontalBorder(2).

%imprime a borda de cima e de baixo
printHorizontalBorder(_) :- 
	write('  --------------------------').

%imprimir os tabuleiros
%chama primeiro o tabuleiro das cruzes e depois o dos quadrados
printBoards(BoardX, BoardT) :-
	\+ number(BoardT), %verifica se nao e numero por causa das chamadas recursivas
	printHorizontalBorder(1), %imprime a linha do topo (numeros e linha)
	nl,
	printBoards(BoardX, 0, 1), %imprime o tabuleiro
	printHorizontalBorder(2), %imprime a linha de baixo
	nl, nl,
	printHorizontalBorder(1), %aqui começa o processo de imprimir um novo tabuleiro
	nl,
	printBoards(BoardT, 0, 1),
	printHorizontalBorder(2).
	
printBoards([],_,_). %caso base (o tabuleiro ja acabou (para imprimir))
%[X|Xs] -> tabuleiro
%N -> numero da coluna (para imprimir as bordas e inicias e finais da linha)
%Line -> numero da linha para imprimir os numeros das linhas corretos antes das linhas
printBoards([X|Xs],N, Line) :-
	printBorderInitial(N, Line),
	%imprime o numero
	write(' '),
	write(X),
	write(' '),
	printBorderFinal(N),
	N1 is mod(N + 1, 8), %avanca a coluna
	Line1 is Line + 1, %avanca a linha (linha atual = (Line mod 8) + 1)
	printBoards(Xs, N1, Line1).
	
printBorderInitial(0, Line) :-
	LineNumber is div(Line, 8) + 1,
	write(LineNumber),
	write(' |').
printBorderInitial(_, _).

printBorderFinal(7) :-
	write('|'),
	nl.
printBorderFinal(_).