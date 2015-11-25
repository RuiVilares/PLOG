%Para testes
horizontal(-1,-1,_):-fail.
vertical(-1,-1,_):-fail.

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
	printLine(Line, 1, CurrentLine),
	CurrentLine1 is CurrentLine + 1,
	printBoardAux(Board, CurrentLine1).

printLineNumbers([], _, _) :-
	nl.
printLineNumbers([Elem|Line], LineNumber, ColNumber) :-
	write(' '),
	write(Elem),
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
	write('�').
printDotVertical(LineNumber, ColNumber) :-
	vertical(LineNumber, ColNumber, black),
	write('.').
printDotVertical(_, _) :-
	write('-').

printDotHorizontal(LineNumber, ColNumber) :-
	horizontal(LineNumber, ColNumber, white),
	write('�').
printDotHorizontal(LineNumber, ColNumber) :-
	horizontal(LineNumber, ColNumber, black),
	write('.').
printDotHorizontal(_, _) :-
	write('|').
