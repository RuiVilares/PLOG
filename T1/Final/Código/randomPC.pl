
%put pc piece (player 2)
pcMove(Board, player1, NewBoard):-
	repeat,
		once(random(0, 8, Row)),
		once(random(0, 8, Col)),
		once(checkValidPosition(Board, Row, Col)),
		insertPiece(Board, 1, Row, Col, NewBoard),
	!.
	
pcMove(Board, player2, NewBoard):-
	repeat,
		once(random(0, 8, Row)),
		once(random(0, 8, Col)),
		once(checkValidPosition(Board, Row, Col)),
		insertPiece(Board, 2, Row, Col, NewBoard),
	!.

	
pcSmartMoveAlgorithm(Board, Player, NewBoard, Game):-
	findBestOption(Board, 20, Player, NewBoard, Game, -1).
	

findBestOption(Board, 0, _, Board, _, _).
findBestOption(Board, Num, Player, NewBoard, Game, Points):-
	Num > 0,
	Num1 is Num - 1,
	pcMove(Board, Player, BoardTemp),
	(
	Player == player1 ->
			(checkAll(BoardTemp, 1, BoardChecked));
	checkAll(BoardTemp, 2, BoardChecked)
	),
	fixBoard(BoardChecked, BoardFixed, Game, NewGame),
	(
	Player == player1 ->
			(getPontuationPlayer1(NewGame, Pontuation));
	(getPontuationPlayer2(NewGame, Pontuation))
	),
	(
	Pontuation > Points->
			(findBestOption(BoardFixed, Num1, Player, NewBoard, Game, Pontuation));
		findBestOption(Board, Num1, Player, NewBoard, Game, Points)
	).	

	
	
pcRandomMove(Game, NewGame):-
	getGameBoard(Game, Board), getGamePlayerTurn(Game, Player),
	clearConsole,
	printBoard(Board),
	printTurnInfo(Player, Game), nl, nl,
	pcMove(Board, Player, NewBoard),				
	decNumPiecesPlayer(Game, Player, Game1),
	setGameBoard(Game1, NewBoard, Game2),
	endRandomTurn(Game2, TempGame),
	changePlayer(TempGame, NewGame), !.
	

pcSmartMove(Game, NewGame):-
	getGameBoard(Game, Board), getGamePlayerTurn(Game, Player),
	clearConsole,
	printBoard(Board),
	printTurnInfo(Player, Game), nl, nl,
	pcSmartMoveAlgorithm(Board, Player, NewBoard, Game),
	decNumPiecesPlayer(Game, Player, Game1),
	setGameBoard(Game1, NewBoard, Game2),
	endRandomTurn(Game2, TempGame),
	changePlayer(TempGame, NewGame), !.

