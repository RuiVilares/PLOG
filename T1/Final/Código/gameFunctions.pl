% GAME FUNCTIONS


createPlayerVSPlayer(Game):-
	emptyBoard(Board),
	insertPiece(Board, 1, 0, 4, NewBoard1),
	insertPiece(NewBoard1, 1, 1, 3, NewBoard2),
	insertPiece(NewBoard2, 1, 2, 2, NewBoard3),
	insertPiece(NewBoard3, 1, 3, 1, NewBoard4),
	insertPiece(NewBoard4, 1, 4, 0, NewBoard5),
	once(printBoard(NewBoard5)),
	check5DiaLeft(NewBoard5, 1, 0, 4),
	%%checkX(NewBoard5, Piece, Row1, Col1),
	write('passou'), nl.
	%%checkPlus(NewBoard5, Piece, Row1, Col1).
	%%emptyBoard(Board),
	%%putJokers(Board, 5, NewBoard),
	%%printBoard(NewBoard),
	%%putPlayer1Marker(NewBoard, 0, 0, NewBoard1),
	%%putPlayer1Piece(NewBoard1, NewBoard2),
	%%printBoard(NewBoard2),
	%%getEndPoins(Game, Points),
	%%write(Points), nl, nl.
	
	
%POINTS FUNCTIONS______________________________________________________________________________

checkCond(Board, Piece, Row, Col):-
	getMatrixElemAt(Row, Col, Board, Elem),
	getListElemAt(0, Elem, ResElem),
	ResElem == Piece.


%% da coluna e linha 0 à 5

checkX(Board, Piece, Row, Col):-
	Row1 is Row + 1,
	Row2 is Row + 2,
	Col1 is Col + 1,
	Col2 is Col + 2,
	checkCond(Board, Piece, Row, Col),
	checkCond(Board, Piece, Row, Col2),
	checkCond(Board, Piece, Row2, Col2),
	checkCond(Board, Piece, Row2, Col),
	checkCond(Board, Piece, Row1, Col1).
	


%% da coluna e linha 1 à 6
	
checkPlus(Board, Piece, Row, Col):-
	Row1 is Row + 1,
	Row2 is Row + 2,
	Col0 is Col - 1,
	Col1 is Col + 1,
	checkCond(Board, Piece, Row, Col),
	checkCond(Board, Piece, Row1, Col),
	checkCond(Board, Piece, Row2, Col),
	checkCond(Board, Piece, Row1, Col0),
	checkCond(Board, Piece, Row1, Col1).

%coluna 0 a 3
%linha 0 a 7	
	
check5Hor(Board, Piece, Row, Col):-
	Col1 is Col + 1,
	Col2 is Col + 2,
	Col3 is Col + 3,
	Col4 is Col + 4,
	checkCond(Board, Piece, Row, Col),
	checkCond(Board, Piece, Row, Col1),
	checkCond(Board, Piece, Row, Col2),
	checkCond(Board, Piece, Row, Col3),
	checkCond(Board, Piece, Row, Col4).
	
%coluna 0 a 7
%linha 0 a 3	
	
check5Ver(Board, Piece, Row, Col):-
	Row1 is Row + 1,
	Row2 is Row + 2,
	Row3 is Row + 3,
	Row4 is Row + 4,
	checkCond(Board, Piece, Row, Col),
	checkCond(Board, Piece, Row1, Col),
	checkCond(Board, Piece, Row2, Col),
	checkCond(Board, Piece, Row3, Col),
	checkCond(Board, Piece, Row4, Col).
	
%coluna 0 a 3
%linha 0 a 3
check5DiaRight(Board, Piece, Row, Col):-
	Row1 is Row + 1,
	Col1 is Col + 1,
	Row2 is Row + 2,
	Col2 is Col + 2,
	Row3 is Row + 3,
	Col3 is Col + 3,
	Row4 is Row + 4,
	Col4 is Col + 4,
	checkCond(Board, Piece, Row, Col),
	checkCond(Board, Piece, Row1, Col1),
	checkCond(Board, Piece, Row2, Col2),
	checkCond(Board, Piece, Row3, Col3),
	checkCond(Board, Piece, Row4, Col4).
	
%coluna 4 a 7
%linha 4 a 7
check5DiaLeft(Board, Piece, Row, Col):-
	Row1 is Row + 1,
	Col1 is Col - 1,
	Row2 is Row + 2,
	Col2 is Col - 2,
	Row3 is Row + 3,
	Col3 is Col - 3,
	Row4 is Row + 4,
	Col4 is Col - 4,
	checkCond(Board, Piece, Row, Col),
	checkCond(Board, Piece, Row1, Col1),
	checkCond(Board, Piece, Row2, Col2),
	checkCond(Board, Piece, Row3, Col3),
	checkCond(Board, Piece, Row4, Col4).	
	
%%_______________________________________________________________________________________________________________
	
createPlayerVsBot(Game):-
	emptyBoard(Board).
	
createBotVsBot(Game):-
	emptyBoard(Board).

	

checkValidPosition(Board, Row, Col):-
	getMatrixElemAt(Row, Col, Board, Elem),
	getListElemAt(0, Elem, ResElem),
	ResElem == -1.
	
%% CHECK END CONDITIONS
checkEndConditions(Game):-
	checkPointsEnd(Game),
	checkPiecesEnd(Game),
	checkMarkersEnd(Game).
	
checkPointsEnd(Game):-
	getEndPoins(Game, Points),
	getPontuationPlayer1(Game, Pont1),
	getPontuationPlayer2(Game, Pont2),
	Pont1 < Points,
	Pont2 < Points.
	
checkPiecesEnd(Game):-
	getNumPiecesPlayer1(Game, Pieces1),
	getNumPiecesPlayer2(Game, Pieces2),
	Pieces1 > 0,
	Pieces2 > 0.
	
checkMarkersEnd(Game):-
	getNumMarkersPlayer1(Game, Markers1),
	getNumMarkersPlayer2(Game, Markers2),
	Markers1 > 0,
	Markers2 > 0.
		

defineEndPoins(Points):-
	repeat,
		write('Define end points: '),
		getInt(Points),
		discardInputChar,
		Points > 0,
		Points < 9, %% AQUI TEM DE SER 19 CORRIGIR (Problema ao ler dois digitos)__________________________________________________________________________
	!.

getEndPoins(Game, Points):-
	getListElemAt(4, Game, Points).
	

% JOKER FUCTIONS	
putJokers(X, 0, X).
	
putJokers(Board, Num, NewBoard):-
	Num > 0,
	Num1 is Num - 1,
	putRandomJoker(Board, X),
	putJokers(X, Num1, NewBoard).

	
putJoker(Board, NewBoard):-
	repeat,
		once(readCoords(Row, Col)),
		once(checkValidPosition(Board, Row, Col)),
		insertPiece(Board, 0, Row, Col, NewBoard),
	!.

putRandomJoker(Board, NewBoard):-
	repeat,
		once(random(0, 8, Row)),
		once(random(0, 8, Col)),
		once(checkValidPosition(Board, Row, Col)),
		insertPiece(Board, 0, Row, Col, NewBoard),
	!.

% MARKERS AND PIECES
putPlayer1Marker(Board, Row, Col, NewBoard):-
	insertMarker(Board, 11, Row, Col, NewBoard).
		
putPlayer2Marker(Board, Row, Col, NewBoard):-
	insertMarker(Board, 22, Row, Col, NewBoard).

putPlayer1Piece(Board, NewBoard):-
	repeat,
		once(readCoords(Row, Col)),
		once(checkValidPosition(Board, Row, Col)),
		insertPiece(Board, 1, Row, Col, NewBoard),
	!.	
	
putPlayer2Piece(Board, NewBoard):-
	repeat,
		once(readCoords(Row, Col)),
		once(checkValidPosition(Board, Row, Col)),
		insertPiece(Board, 2, Row, Col, NewBoard),
	!.
	
insertPiece(Board, Piece, Row, Col, NewBoard):-
	getMatrixElemAt(Row, Col, Board, Elem),
	getListElemAt(1, Elem, ResElem),
	setMatrixElemAtWith(Row, Col, [Piece, ResElem], Board, NewBoard).
	
insertMarker(Board, Marker, Row, Col, NewBoard):-
	getMatrixElemAt(Row, Col, Board, Elem),
	getListElemAt(0, Elem, ResElem),
	setMatrixElemAtWith(Row, Col, [ResElem, Marker], Board, NewBoard).

% INC AND DEC NUMERO PIECES OR MARKERS
getNumPiecesPlayer1(Game, Num):-
	getListElemAt(1, Game, Lista),
	getListElemAt(0, Lista, Player1),
	getListElemAt(0, Player1, Num).
	
getNumMarkersPlayer1(Game, Num):-
	getListElemAt(1, Game, Lista),
	getListElemAt(0, Lista, Player1),
	getListElemAt(1, Player1, Num).
	
getNumPiecesPlayer2(Game, Num):-
	getListElemAt(1, Game, Lista),
	getListElemAt(1, Lista, Player2),
	getListElemAt(0, Player2, Num).
	
getNumMarkersPlayer2(Game, Num):-
	getListElemAt(1, Game, Lista),
	getListElemAt(1, Lista, Player2),
	getListElemAt(1, Player2, Num).
	
setNumPiecesPlayer1(Game, Num, NewGame):-
	getListElemAt(1, Game, Lista),
	getListElemAt(0, Lista, Player1),
	setListElemAtWith(0, Num, Player1, ResPlayer1),
	setListElemAtWith(0, ResPlayer1, Lista, ResLista),
	setListElemAtWith(1, ResLista, Game, NewGame).
	
setNumPiecesPlayer2(Game, Num, NewGame):-
	getListElemAt(1, Game, Lista),
	getListElemAt(1, Lista, Player2),
	setListElemAtWith(0, Num, Player2, ResPlayer2),
	setListElemAtWith(1, ResPlayer2, Lista, ResLista),
	setListElemAtWith(1, ResLista, Game, NewGame).
	
setNumMarkersPlayer1(Game, Num, NewGame):-
	getListElemAt(1, Game, Lista),
	getListElemAt(0, Lista, Player1),
	setListElemAtWith(1, Num, Player1, ResPlayer1),
	setListElemAtWith(0, ResPlayer1, Lista, ResLista),
	setListElemAtWith(1, ResLista, Game, NewGame).
	
setNumMarkersPlayer2(Game, Num, NewGame):-
	getListElemAt(1, Game, Lista),
	getListElemAt(1, Lista, Player2),
	setListElemAtWith(1, Num, Player2, ResPlayer2),
	setListElemAtWith(1, ResPlayer2, Lista, ResLista),
	setListElemAtWith(1, ResLista, Game, NewGame).

decNumPiecesPlayer1(Game, NewGame):-
	getNumPiecesPlayer1(Game, Num),
	Num1 is Num - 1,
	setNumPiecesPlayer1(Game, Num1, NewGame).
	
decNumPiecesPlayer2(Game, NewGame):-
	getNumPiecesPlayer2(Game, Num),
	Num1 is Num - 1,
	setNumPiecesPlayer2(Game, Num1, NewGame).
	
decNumMarkersPlayer1(Game, NewGame):-
	getNumMarkersPlayer1(Game, Num),
	Num1 is Num - 1,
	setNumMarkersPlayer1(Game, Num1, NewGame).
	
decNumMarkersPlayer2(Game, NewGame):-
	getNumMarkersPlayer2(Game, Num),
	Num1 is Num - 1,
	setNumMarkersPlayer2(Game, Num1, NewGame).
	
incNumPiecesPlayer1(Game, NewGame):-
	getNumPiecesPlayer1(Game, Num),
	Num1 is Num + 1,
	setNumPiecesPlayer1(Game, Num1, NewGame).
	
incNumPiecesPlayer2(Game, NewGame):-
	getNumPiecesPlayer2(Game, Num),
	Num1 is Num + 1,
	setNumPiecesPlayer2(Game, Num1, NewGame).
	
incNumMarkersPlayer1(Game, NewGame):-
	getNumMarkersPlayer1(Game, Num),
	Num1 is Num + 1,
	setNumMarkersPlayer1(Game, Num1, NewGame).
	
incNumMarkersPlayer2(Game, NewGame):-
	getNumMarkersPlayer2(Game, Num),
	Num1 is Num + 1,
	setNumMarkersPlayer2(Game, Num1, NewGame).
	
	
%GET PONTUATION	
getPontuationPlayer1(Game, Pont):-
	getNumMarkersPlayer1(Game, Num),
	Pont is 18 - Num.
	
getPontuationPlayer2(Game, Pont):-
	getNumMarkersPlayer2(Game, Num),
	Pont is 18 - Num.



	
	
%BOARD FUNCTIONS
getGameBoard(Game, Board):-
	getListElemAt(0, Game, Board).
	
setGameBoard(Game, Board, ResGame):-
		setListElemAtWith(0, Board, Game, ResGame).
	
emptyBoard([
			[[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1]],
			[[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1]],
			[[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1]],
			[[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1]],
			[[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1]],
			[[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1]],
			[[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1]],
			[[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1],[-1,-1]]
			]).	
			
