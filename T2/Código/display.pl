%declaracao dos predicados dinamicos
:- dynamic horizontal/3, vertical/3.

printHorizontal(0) :-
	write('|'),
	nl.
printHorizontal(Size) :-
	Size > 0,
	write('|---'),
	Size1 is Size - 1,
	printHorizontal(Size1).

printBoard(Board) :-
	length(Board, Size),
	nl,
	printHorizontal(Size),
	printBoardAux(Board, 1),
	printHorizontal(Size).

printBoardAux([Line|[]], CurrentLine) :-
	write('|'),
	printLineNumbers(Line, CurrentLine, 1).

printBoardAux([Line|Board], CurrentLine) :-
	write('|'),
	printLineNumbers(Line, CurrentLine, 1),
	write('|'),
	printLine(Line, CurrentLine, 1),
	CurrentLine1 is CurrentLine + 1,
	printBoardAux(Board, CurrentLine1).

printElem(Elem) :-
	number(Elem),
	Elem < 10,
	write(' '),
	write(Elem).

printElem(Elem) :-
	number(Elem),
	write(Elem).

printElem(_) :-
	write('  ').

printLineNumbers([], _, _) :-
	nl.
printLineNumbers([Elem|Line], LineNumber, ColNumber) :-
	printElem(Elem),
	write(' '),
	printDotHorizontal(LineNumber, ColNumber),
	ColNumber1 is ColNumber + 1,
	printLineNumbers(Line, LineNumber, ColNumber1).

printLine([], _, _):-
	nl.
printLine([_|Line], LineNumber, ColNumber) :-
	write('-'),
	printDotVertical(LineNumber, ColNumber),
	write('-|'),
	ColNumber1 is ColNumber + 1,
	printLine(Line, LineNumber, ColNumber1).

printDotVertical(LineNumber, ColNumber) :-
	vertical(LineNumber, ColNumber, white),
	write('o').
printDotVertical(LineNumber, ColNumber) :-
	vertical(LineNumber, ColNumber, black),
	write('*').
printDotVertical(_, _) :-
	write('-').

printDotHorizontal(LineNumber, ColNumber) :-
	horizontal(LineNumber, ColNumber, white),
	write('o').
printDotHorizontal(LineNumber, ColNumber) :-
	horizontal(LineNumber, ColNumber, black),
	write('*').
printDotHorizontal(_, _) :-
	write('|').
