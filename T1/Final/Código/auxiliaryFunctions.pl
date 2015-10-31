% CONTAINER AUXILIRY FUNCTIONS
	
%getMatrixElemAt(Row, Col, Matrix, Result)
getMatrixElemAt(0, Col, [X|_], Elem):-
	getListElemAt(Col, X, Elem).
getMatrixElemAt(Row, Col, [_|Y], Elem):-
	Row > 0,
	Row1 is Row-1,
	getMatrixElemAt(Row1, Col, Y, Elem).

%getListElemAt(Pos, List, Result)
getListElemAt(0, [X|_], X).
getListElemAt(Pos, [_|Y], Elem):-
	Pos > 0,
	Pos1 is Pos-1,
	getListElemAt(Pos1, Y, Elem).

%setMatrixElemAtWith(Row, Col, Elem, Matrix, ResMatrix)
setMatrixElemAtWith(0, Col, Elem, [X|Y], [Z|Y]):-
	setListElemAtWith(Col, Elem, X, Z).
setMatrixElemAtWith(Row, Col, Elem, [X|Y], [X|W]):-
	Row > 0,
	Row1 is Row-1,
	setMatrixElemAtWith(Row1, Col, Elem, Y, W).

%setListElemAtWith(Pos, Elem, List, ResList)
setListElemAtWith(0, Elem, [_|L], [Elem|L]).
setListElemAtWith(Pos, Elem, [H|L], [H|ResL]):-
	Pos > 0,
	Pos1 is Pos-1,
	setListElemAtWith(Pos1, Elem, L, ResL).

%replaceMatrixElemWith(PrevElem, NextElem, CurrentMatrix, ResMatrix)
replaceMatrixElemWith(_, _, [], []).
replaceMatrixElemWith(Prev, Next, [Line|RL], [ResLine|ResRL]):-
	replaceListElemWith(Prev, Next, Line, ResLine),
	replaceMatrixElemWith(Prev, Next, RL, ResRL).

%replaceListElemWith(PrevElem, NextElem, CurrentList, ResList)
replaceListElemWith(_, _, [], []).
replaceListElemWith(Prev, Next, [Prev|L1], [Next|L2]):-
	replaceListElemWith(Prev, Next, L1, L2).
replaceListElemWith(Prev, Next, [C|L1], [C|L2]):-
	C \= Prev,
	replaceListElemWith(Prev, Next, L1, L2).


% INITIALIZE RANDOM SEED

initializeRandom:-
	now(Usec), Seed is Usec mod 30269,
	getrand(random(X, Y, Z, _)),
	setrand(random(Seed, X, Y, Z)), !.

% CLEAN CONSOLE	
	
clearConsole:-
	clearConsole(40), !.

clearConsole(0).

clearConsole(N):-
	nl,
	N1 is N-1,
	clearConsole(N1).


% INPUT FUNCTIONS	
	
getChar(Input):-
	get_char(Input),
	get_char(_).

getCode(Input):-
	get_code(TempInput),
	get_code(_),
	Input is TempInput - 48.

getInt(Input):-
	get_code(TempInput),
	Input is TempInput - 48.

discardInputChar:-
	get_code(_).
	
pressEnterToContinue:-
	write('Press ENTER to continue'), nl,
	waitForEnter, !.

waitForEnter:-
	get_char(_).