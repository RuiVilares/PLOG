% GAME FUNCTIONS


createPlayerVSPlayer(Game):-
	emptyBoard(Board),
	putJokers(Board, 5, NewBoard),
	putPlayer1Marker(NewBoard, 0, 0, NewBoard1),
	putPlayer1Piece(NewBoard1, NewBoard2),
	printBoard(NewBoard2).
	
	
	
	
createPlayerVsBot(Game):-
	emptyBoard(Board).
	
createBotVsBot(Game):-
	emptyBoard(Board).


putJokers(X, 0, X).
	
putJokers(Board, Num, NewBoard):-
	Num > 0,
	Num1 is Num - 1,
	putRandomJoker(Board, X),
	putJokers(X, Num1, NewBoard).

	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TESTAR ISTO A VER SE FUNCIONA
checkValidPosition(Board, Row, Col):-
	getMatrixElemAt(Row, Col, Board, Elem),
	getListElemAt(0, Elem, ResElem),
	ResElem == -1.

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

% INC AND DEC PIECES OR MARKERS

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
	
getPontuationPlayer1(Game, Pont):-
	getNumMarkersPlayer1(Game, Num),
	Pont is 18 - Num.
	
getPontuationPlayer2(Game, Pont):-
	getNumMarkersPlayer2(Game, Num),
	Pont is 18 - Num.



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
			
