% GAME FUNCTIONS


createPlayerVsPlayer(Game):-
	defineEndPoins(Points),
	emptyBoard(EmptyBoard),
	putJokers(EmptyBoard, 5, Board),
	Game = [Board, [[14, 18], [14, 18]], player1, playerVSplayer, Points, []].
	
createPlayerVsPc(Game):-
	defineEndPoins(Points),
	write('Choose Player 2 difficult level: '), nl, definePcDifficultLevel(Level),
	emptyBoard(EmptyBoard),
	putJokers(EmptyBoard, 5, Board),
	Game = [Board, [[14, 18], [14, 18]], player1, playerVSpc, Points, [0, Level]].
	
createPcVsPc(Game):-
	defineEndPoins(Points),
	write('Choose Player 1 difficult level: '), nl, definePcDifficultLevel(Level1),
	write('Choose Player 2 difficult level: '), nl, definePcDifficultLevel(Level2),
	emptyBoard(EmptyBoard),
	putJokers(EmptyBoard, 5, Board),
	Game = [Board, [[14, 18], [14, 18]], player1, pcVSpc, Points, [Level1, Level2]].

	
	
%POINTS FUNCTIONS______________________________________________________________________________
%% 3 é representação interna de Player1
%% 3 é representação interna de Player2
%% 4 é representação interna de Joker

replacePiece([3,_], [-1,11], Game, NewGame):-
	decNumMarkersPlayer1(Game, Game1),
	incNumPiecesPlayer1(Game1, NewGame).
	
replacePiece([4,_], [-1,22], Game, NewGame):-
	decNumMarkersPlayer2(Game, Game1),
	incNumPiecesPlayer2(Game1, NewGame).

replacePiece([5,Y], [-1,Y], Game, Game).
replacePiece([X,Y], [X,Y], Game, Game).

fixLine([], [], X, X).
fixLine([L|Ls], [X|Xs], Game, NewGame):-
	replacePiece(L, X, Game, Game1),
	fixLine(Ls, Xs, Game1, NewGame).

fixBoard([],[], X, X).
fixBoard([Board|Boards], [NewBoard|NewBoards], Game, NewGame):-
	fixLine(Board, NewBoard, Game, X),
	fixBoard(Boards, NewBoards, X, NewGame).
	
%%__________________________________________________________________________ 	

assertNumJokers(Board, NewBoard):-
	countNumOfJokers(Board, Num),
	Num1 is 5 - Num,
	putPlayerJokers(Board, Num1, NewBoard).
	
assertNumJokersRandom(Board, NewBoard):-
	countNumOfJokers(Board, Num),
	Num1 is 5 - Num,
	putJokers(Board, Num1, NewBoard).
	
countNumOfJokersAux([],0).
	
countNumOfJokersAux([[0, _]|Ls], Num):-
	countNumOfJokersAux(Ls, Num1),
	Num is Num1 + 1.
countNumOfJokersAux([_|Ls], Num):-
	countNumOfJokersAux(Ls, Num).
	
countNumOfJokers([], 0).
countNumOfJokers([Board|Boards], Num):-
	countNumOfJokersAux(Board, NumAux),
	countNumOfJokers(Boards, NumAux1),
	Num is NumAux + NumAux1.
%%__________________________________________________________________________
	

	
replace(Board, Row, Col, NewBoard):-
	getMatrixElemAt(Row, Col, Board, Elem),
	getListElemAt(0, Elem, ResElem),
	replaceAux(ResElem, ElemToReplace),
	insertPiece(Board, ElemToReplace, Row, Col, NewBoard).	
	
replaceAux(1, 3).
replaceAux(2, 4).
replaceAux(0, 5).
replaceAux(X, X).
	
	

checkCond(Board, Piece, Row, Col):-
	getMatrixElemAt(Row, Col, Board, Elem),
	getListElemAt(0, Elem, ResElem),
	Piece2 is Piece + 2,
	(ResElem == Piece ; ResElem == 0 ; ResElem == 5 ; ResElem == Piece2).

%%_________________________________________________________________________________
endTurn(Game, NewGame):-
	getGameBoard(Game, Board),
	getGamePlayerTurn(Game, Player),
	((Player == player1, checkAll(Board, 1, Board1));
	(Player == player2, checkAll(Board, 2, Board1))),
	fixBoard(Board1, Board2, Game, Game1),
	assertNumJokers(Board2, NewBoard),
	setGameBoard(Game1, NewBoard, NewGame).
	
endRandomTurn(Game, NewGame):-
	getGameBoard(Game, Board),
	getGamePlayerTurn(Game, Player),
	((Player == player1, checkAll(Board, 1, Board1));
	(Player == player2, checkAll(Board, 2, Board1))),
	fixBoard(Board1, Board2, Game, Game1),
	assertNumJokersRandom(Board2, NewBoard),
	setGameBoard(Game1, NewBoard, NewGame).
	
	

checkAll(Board, Piece, NewBoard):-
	checkAllX(Board, Piece, Board1),
	checkAllPlus(Board1, Piece, Board2),
	checkAll5Hor(Board2, Piece, Board3),
	checkAll5Ver(Board3, Piece, Board4),
	checkAll5DiaRight(Board4, Piece, Board5),
	checkAll5DiaLeft(Board5, Piece, NewBoard).


%% da coluna e linha 0 à 5
checkAllX(Board, Piece, NewBoard):-
	checkAllXAux(Board, Piece, 0, 0, NewBoard).
	
checkAllXAux(Board, Piece, 5, 5, NewBoard):-
	checkXAndReplace(Board, Piece, 5, 5, NewBoard).
	
checkAllXAux(Board, Piece, Row, 5, NewBoard):-
	checkXAndReplace(Board, Piece, Row, 5, NewBoard1),
	Row1 is Row + 1,
	Col1 is 0,
	checkAllXAux(NewBoard1, Piece, Row1, Col1, NewBoard).
	
checkAllXAux(Board, Piece, Row, Col, NewBoard):-
	checkXAndReplace(Board, Piece, Row, Col, NewBoard1),
	Col1 is Col + 1,
	checkAllXAux(NewBoard1, Piece, Row, Col1, NewBoard).


checkX(Board, Piece, Row, Col) :-
	Row1 is Row + 1,
	Row2 is Row + 2,
	Col1 is Col + 1,
	Col2 is Col + 2,
	checkCond(Board, Piece, Row, Col),
	checkCond(Board, Piece, Row, Col2),
	checkCond(Board, Piece, Row2, Col2),
	checkCond(Board, Piece, Row2, Col),
	checkCond(Board, Piece, Row1, Col1).
	
replaceX(Board, Row, Col, NewBoard):-
	Row1 is Row + 1,
	Row2 is Row + 2,
	Col1 is Col + 1,
	Col2 is Col + 2,
	replace(Board, Row, Col, Board1),
	replace(Board1, Row, Col2, Board2),
	replace(Board2, Row2, Col2, Board3),
	replace(Board3, Row2, Col, Board4),
	replace(Board4, Row1, Col1, NewBoard).

checkXAndReplace(Board, Piece, Row, Col, NewBoard):-
	checkX(Board, Piece, Row, Col),
	replaceX(Board, Row, Col, NewBoard).
	
checkXAndReplace(Board, _, _, _, Board).
	


%% da coluna e linha 1 à 6
checkAllPlus(Board, Piece, NewBoard):-
	checkAllPlusAux(Board, Piece, 0, 1, NewBoard).
	
checkAllPlusAux(Board, Piece, 5, 6, NewBoard):-
	checkAndReplacePlus(Board, Piece, 5, 6, NewBoard).
	
checkAllPlusAux(Board, Piece, Row, 6, NewBoard):-
	checkAndReplacePlus(Board, Piece, Row, 6, NewBoard1),
	Row1 is Row + 1,
	Col1 is 1,
	checkAllPlusAux(NewBoard1, Piece, Row1, Col1, NewBoard).
	
checkAllPlusAux(Board, Piece, Row, Col, NewBoard):-
	checkAndReplacePlus(Board, Piece, Row, Col, NewBoard1),
	Col1 is Col + 1,
	checkAllPlusAux(NewBoard1, Piece, Row, Col1, NewBoard).


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
	
replacePlus(Board, Row, Col, NewBoard):-
	Row1 is Row + 1,
	Row2 is Row + 2,
	Col0 is Col - 1,
	Col1 is Col + 1,
	replace(Board, Row, Col, Board1),
	replace(Board1, Row1, Col, Board2),
	replace(Board2, Row2, Col, Board3),
	replace(Board3, Row1, Col0, Board4),
	replace(Board4, Row1, Col1, NewBoard).
	
checkAndReplacePlus(Board, Piece, Row, Col, NewBoard):-
	checkPlus(Board, Piece, Row, Col),
	replacePlus(Board, Row, Col, NewBoard).

checkAndReplacePlus(Board, _, _, _, Board).

%coluna 0 a 3
%linha 0 a 7
checkAll5Hor(Board, Piece, NewBoard):-
	checkAll5HorAux(Board, Piece, 0, 0, NewBoard).
	
checkAll5HorAux(Board, Piece, 7, 3, NewBoard):-
	checkAndReplace5Hor(Board, Piece, 7, 3, NewBoard).
	
checkAll5HorAux(Board, Piece, Row, 3, NewBoard):-
	checkAndReplace5Hor(Board, Piece, Row, 3, NewBoard1),
	Row1 is Row + 1,
	Col1 is 0,
	checkAll5HorAux(NewBoard1, Piece, Row1, Col1, NewBoard).
	
checkAll5HorAux(Board, Piece, Row, Col, NewBoard):-
	checkAndReplace5Hor(Board, Piece, Row, Col, NewBoard1),
	Col1 is Col + 1,
	checkAll5HorAux(NewBoard1, Piece, Row, Col1, NewBoard).
	
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
	
replace5Hor(Board, Row, Col, NewBoard):-
	Col1 is Col + 1,
	Col2 is Col + 2,
	Col3 is Col + 3,
	Col4 is Col + 4,
	replace(Board, Row, Col, Board1),
	replace(Board1, Row, Col1, Board2),
	replace(Board2, Row, Col2, Board3),
	replace(Board3, Row, Col3, Board4),
	replace(Board4, Row, Col4, NewBoard).
	
checkAndReplace5Hor(Board, Piece, Row, Col, NewBoard):-
	check5Hor(Board, Piece, Row, Col),
	replace5Hor(Board, Row, Col, NewBoard).

checkAndReplace5Hor(Board, _, _, _, Board).
	
%coluna 0 a 7
%linha 0 a 3
checkAll5Ver(Board, Piece, NewBoard):-
	checkAll5VerAux(Board, Piece, 0, 0, NewBoard).
	
checkAll5VerAux(Board, Piece, 3, 7, NewBoard):-
	checkAndReplace5Ver(Board, Piece, 3, 7, NewBoard).
	
checkAll5VerAux(Board, Piece, Row, 7, NewBoard):-
	checkAndReplace5Ver(Board, Piece, Row, 7, NewBoard1),
	Row1 is Row + 1,
	Col1 is 0,
	checkAll5VerAux(NewBoard1, Piece, Row1, Col1, NewBoard).
	
checkAll5VerAux(Board, Piece, Row, Col, NewBoard):-
	checkAndReplace5Ver(Board, Piece, Row, Col, NewBoard1),
	Col1 is Col + 1,
	checkAll5VerAux(NewBoard1, Piece, Row, Col1, NewBoard).
	
	
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
	
replace5Ver(Board, Row, Col, NewBoard):-
	Row1 is Row + 1,
	Row2 is Row + 2,
	Row3 is Row + 3,
	Row4 is Row + 4,
	replace(Board, Row, Col, Board1),
	replace(Board1, Row1, Col, Board2),
	replace(Board2, Row2, Col, Board3),
	replace(Board3, Row3, Col, Board4),
	replace(Board4, Row4, Col, NewBoard).
	
checkAndReplace5Ver(Board, Piece, Row, Col, NewBoard):-
	check5Ver(Board, Piece, Row, Col),
	replace5Ver(Board, Row, Col, NewBoard).
	
checkAndReplace5Ver(Board, _, _, _, Board).
	
%coluna 0 a 3
%linha 0 a 3
checkAll5DiaRight(Board, Piece, NewBoard):-
	checkAll5DiaRightAux(Board, Piece, 0, 0, NewBoard).
	
checkAll5DiaRightAux(Board, Piece, 3, 3, NewBoard):-
	checkAndReplace5DiaRight(Board, Piece, 3, 3, NewBoard).
	
checkAll5DiaRightAux(Board, Piece, Row, 3, NewBoard):-
	checkAndReplace5DiaRight(Board, Piece, Row, 3, NewBoard1),
	Row1 is Row + 1,
	Col1 is 0,
	checkAll5DiaRightAux(NewBoard1, Piece, Row1, Col1, NewBoard).
	
checkAll5DiaRightAux(Board, Piece, Row, Col, NewBoard):-
	checkAndReplace5DiaRight(Board, Piece, Row, Col, NewBoard1),
	Col1 is Col + 1,
	checkAll5DiaRightAux(NewBoard1, Piece, Row, Col1, NewBoard).
	
	

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
	
replace5DiaRight(Board, Row, Col, NewBoard):-
	Row1 is Row + 1,
	Col1 is Col + 1,
	Row2 is Row + 2,
	Col2 is Col + 2,
	Row3 is Row + 3,
	Col3 is Col + 3,
	Row4 is Row + 4,
	Col4 is Col + 4,
	replace(Board, Row, Col, Board1),
	replace(Board1, Row1, Col1, Board2),
	replace(Board2, Row2, Col2, Board3),
	replace(Board3, Row3, Col3, Board4),
	replace(Board4, Row4, Col4, NewBoard).
	
checkAndReplace5DiaRight(Board, Piece, Row, Col, NewBoard):-
	check5DiaRight(Board, Piece, Row, Col),
	replace5DiaRight(Board, Row, Col, NewBoard).
	
checkAndReplace5DiaRight(Board, _, _, _, Board).
	
%coluna 4 a 7
%linha 4 a 7
checkAll5DiaLeft(Board, Piece, NewBoard):-
	checkAll5DiaLeftAux(Board, Piece, 0, 4, NewBoard).
	
checkAll5DiaLeftAux(Board, Piece, 4, 7, NewBoard):-
	checkAndReplace5DiaLeft(Board, Piece, 4, 7, NewBoard).
	
checkAll5DiaLeftAux(Board, Piece, Row, 7, NewBoard):-
	checkAndReplace5DiaLeft(Board, Piece, Row, 7, NewBoard1),
	Row1 is Row + 1,
	Col1 is 4,
	checkAll5DiaLeftAux(NewBoard1, Piece, Row1, Col1, NewBoard).
	
checkAll5DiaLeftAux(Board, Piece, Row, Col, NewBoard):-
	checkAndReplace5DiaLeft(Board, Piece, Row, Col, NewBoard1),
	Col1 is Col + 1,
	checkAll5DiaLeftAux(NewBoard1, Piece, Row, Col1, NewBoard).

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
	
replace5Left(Board, Row, Col, NewBoard):-
	Row1 is Row + 1,
	Col1 is Col - 1,
	Row2 is Row + 2,
	Col2 is Col - 2,
	Row3 is Row + 3,
	Col3 is Col - 3,
	Row4 is Row + 4,
	Col4 is Col - 4,
	replace(Board, Row, Col, Board1),
	replace(Board1, Row1, Col1, Board2),
	replace(Board2, Row2, Col2, Board3),
	replace(Board3, Row3, Col3, Board4),
	replace(Board4, Row4, Col4, NewBoard).

checkAndReplace5DiaLeft(Board, Piece, Row, Col, NewBoard):-
	check5DiaLeft(Board, Piece, Row, Col),
	replace5Left(Board, Row, Col, NewBoard).
	
checkAndReplace5DiaLeft(Board, _, _, _, Board).
	
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
		write('Define end points(--): '),
		getInt(Points1),
		getInt(Points2),
		discardInputChar,
		Points3 is Points1 * 10,
		Points	is Points3 + Points2,
		Points > 0,
		Points < 19,
	!.
	
definePcDifficultLevel(Level):-
	repeat,
		write('> '), 
		getInt(Level),
		discardInputChar,
		Level > 0,
		Level < 3,
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
	
putPlayerJokers(X, 0, X).
putPlayerJokers(Board, Num, NewBoard):-
	Num > 0,
	Num1 is Num - 1,
	putJoker(Board, X),
	putPlayerJokers(X, Num1, NewBoard).

	
putJoker(Board, NewBoard):-
	printBoard(Board),
	repeat,
		once(readCoords(Row, Col)),
		once(checkValidPosition(Board, Row, Col)),
		once(checkPatern(Board, Row, Col)),
		insertPiece(Board, 0, Row, Col, NewBoard),
	!.

putRandomJoker(Board, NewBoard):-
	repeat,
		once(random(0, 8, Row)),
		once(random(0, 8, Col)),
		once(checkValidPosition(Board, Row, Col)),
		once(checkPatern(Board, Row, Col)),
		insertPiece(Board, 0, Row, Col, NewBoard),
	!.
	
%_______________________________________________________________________________________________
checkAllXJoker(Board, Piece):-
	checkAllXAuxJoker(Board, Piece, 0, 0).
	
checkAllXAuxJoker(Board, Piece, 5, 5):-
	checkX(Board, Piece, 5, 5).
	
checkAllXAuxJoker(Board, Piece, Row, 5):-
	checkX(Board, Piece, Row, 5),
	Row1 is Row + 1,
	Col1 is 0,
	checkAllXAuxJoker(Board, Piece, Row1, Col1).
	
checkAllXAuxJoker(Board, Piece, Row, Col):-
	checkX(Board, Piece, Row, Col),
	Col1 is Col + 1,
	checkAllXAuxJoker(Board, Piece, Row, Col1).	
	
	
	
	
checkAllPlusJoker(Board, Piece):-
	checkAllPlusAuxJoker(Board, Piece, 0, 1).
	
checkAllPlusAuxJoker(Board, Piece, 5, 6):-
	checkPlus(Board, Piece, 5, 6).
	
checkAllPlusAuxJoker(Board, Piece, Row, 6):-
	checkPlus(Board, Piece, Row, 6),
	Row1 is Row + 1,
	Col1 is 1,
	checkAllPlusAuxJoker(Board, Piece, Row1, Col1).
	
checkAllPlusAuxJoker(Board, Piece, Row, Col):-
	checkPlus(Board, Piece, Row, Col),
	Col1 is Col + 1,
	checkAllPlusAuxJoker(Board, Piece, Row, Col1).
	
	
	

checkAll5HorJoker(Board, Piece):-
	checkAll5HorAuxJoker(Board, Piece, 0, 0).
	
checkAll5HorAuxJoker(Board, Piece, 7, 3):-
	check5Hor(Board, Piece, 7, 3).
	
checkAll5HorAuxJoker(Board, Piece, Row, 3):-
	check5Hor(Board, Piece, Row, 3),
	Row1 is Row + 1,
	Col1 is 0,
	checkAll5HorAuxJoker(Board, Piece, Row1, Col1).
	
checkAll5HorAuxJoker(Board, Piece, Row, Col):-
	check5Hor(Board, Piece, Row, Col),
	Col1 is Col + 1,
	checkAll5HorAuxJoker(Board, Piece, Row, Col1).
	

	
checkAll5VerJoker(Board, Piece):-
	checkAll5VerAuxJoker(Board, Piece, 0, 0).
	
checkAll5VerAuxJoker(Board, Piece, 3, 7):-
	check5Ver(Board, Piece, 3, 7).
	
checkAll5VerAuxJoker(Board, Piece, Row, 7):-
	check5Ver(Board, Piece, Row, 7, Board),
	Row1 is Row + 1,
	Col1 is 0,
	checkAll5VerAuxJoker(Board, Piece, Row1, Col1).
	
checkAll5VerAuxJoker(Board, Piece, Row, Col):-
	check5Ver(Board, Piece, Row, Col),
	Col1 is Col + 1,
	checkAll5VerAuxJoker(Board, Piece, Row, Col1).	
	
	
checkAll5DiaRightJoker(Board, Piece):-
	checkAll5DiaRightAuxJoker(Board, Piece, 0, 0).
	
checkAll5DiaRightAuxJoker(Board, Piece, 3, 3):-
	check5DiaRight(Board, Piece, 3, 3).
	
checkAll5DiaRightAuxJoker(Board, Piece, Row, 3):-
	check5DiaRight(Board, Piece, Row, 3),
	Row1 is Row + 1,
	Col1 is 0,
	checkAll5DiaRightAuxJoker(Board, Piece, Row1, Col1).
	
checkAll5DiaRightAuxJoker(Board, Piece, Row, Col):-
	check5DiaRight(Board, Piece, Row, Col),
	Col1 is Col + 1,
	checkAll5DiaRightAuxJoker(Board, Piece, Row, Col1).



checkAll5DiaLeftJoker(Board, Piece):-
	checkAll5DiaLeftAuxJoker(Board, Piece, 0, 4).
	
checkAll5DiaLeftAuxJoker(Board, Piece, 4, 7):-
	check5DiaLeft(Board, Piece, 4, 7).
	
checkAll5DiaLeftAuxJoker(Board, Piece, Row, 7):-
	check5DiaLeft(Board, Piece, Row, 7),
	Row1 is Row + 1,
	Col1 is 4,
	checkAll5DiaLeftAuxJoker(Board, Piece, Row1, Col1).
	
checkAll5DiaLeftAuxJoker(Board, Piece, Row, Col):-
	check5DiaLeft(Board, Piece, Row, Col),
	Col1 is Col + 1,
	checkAll5DiaLeftAuxJoker(Board, Piece, Row, Col1).
	
	
checkPatern(Board, Row, Col):-
	insertPiece(Board, 0, Row, Col, NewBoard),
	(\+ checkAllXJoker(NewBoard, 1)), (\+ checkAllXJoker(NewBoard, 2)),
	(\+ checkAllPlusJoker(NewBoard, 1)), (\+ checkAllPlusJoker(NewBoard, 2)),
	(\+ checkAll5HorJoker(NewBoard, 1)), (\+ checkAll5HorJoker(NewBoard, 2)),
	(\+ checkAll5VerJoker(NewBoard, 1)), (\+ checkAll5VerJoker(NewBoard, 2)),
	(\+ checkAll5DiaRightJoker(NewBoard, 1)), (\+ checkAll5DiaRightJoker(NewBoard, 2)),
	(\+ checkAll5DiaLeftJoker(NewBoard, 1)), (\+ checkAll5DiaLeftJoker(NewBoard, 2)). 
	
%%_______________________________________________________________________________________________________________

% MARKERS AND PIECES
	
putPlayer1Marker(Board, Row, Col, NewBoard):-	
	getMatrixElemAt(Row, Col, Board, Elem),
	getListElemAt(0, Elem, ResElem),
	putPlayerMarker(Board, ResElem, Row, Col, NewBoard).
		
putPlayer2Marker(Board, Row, Col, NewBoard):-
	getMatrixElemAt(Row, Col, Board, Elem),
	getListElemAt(0, Elem, ResElem),
	putPlayerMarker(Board, ResElem, Row, Col, NewBoard).

putPlayerPiece(Board, player1,NewBoard):-
	putPlayer1Piece(Board, NewBoard).
	
putPlayerPiece(Board, player2,NewBoard):-
	putPlayer2Piece(Board, NewBoard).
	
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
	setMatrixElemAtWith(Row, Col, [-1, Marker], Board, NewBoard).

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

decNumPiecesPlayer(Game, player1, NewGame):-
	decNumPiecesPlayer1(Game, NewGame).	
	
decNumPiecesPlayer(Game, player2, NewGame):-
	decNumPiecesPlayer2(Game, NewGame).

decNumMarkersPlayer(Game, player1, NewGame):-
	decNumMarkersPlayer1(Game, NewGame).	
	
decNumMarkersPlayer(Game, player2, NewGame):-
	decNumMarkersPlayer2(Game, NewGame).
	
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
		
getGameMode(Game, Mode):-
	getListElemAt(3, Game, Mode).
	
getGamePlayerTurn(Game, Player):-
	getListElemAt(2, Game, Player).

setGamePlayerTurn(Game, Player, ResGame):-
	setListElemAtWith(2, Player, Game, ResGame).

getGamePc1Level(Game, Level):-
	getListElemAt(5, Game, Res),
	getListElemAt(0, Res, Level).

getGamePc2Level(Game, Level):-
	getListElemAt(5, Game, Res),
	getListElemAt(1, Res, Level).
	
getGamePcLevel(Game, Level):-
	getGamePlayerTurn(Game, Player),
	Player == player1,
	getGamePc1Level(Game, Level),
	write(Level), nl.
	
getGamePcLevel(Game, Level):-
	getGamePlayerTurn(Game, Player),
	Player == player2,
	getGamePc2Level(Game, Level),
	write(Level), nl.
	
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
			
