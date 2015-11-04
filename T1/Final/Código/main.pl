% INCLUDES
:- use_module(library(random)).
:- use_module(library(system)).
:- include('menu.pl').
:- include('auxiliaryFunctions.pl').
:- include('printFunctions.pl').
:- include('gameFunctions.pl').
:- include('randomPC.pl').

% START GAME
modx:-
	initializeRandom,
	mainMenu.
	startPlayerVSPlayer.

	
	
% PLAYER 
player(player1).
player(player2).

getPlayerName(player1, 'Player 1').
getPlayerName(player2, 'Player 2').

%PIECES & MARKERS
piece(p1Piece).
piece(p2Piece).

marker(p1Marker).
marker(p2Marker).



pieceIsOwnedBy(p1Piece, player1).
pieceIsOwnedBy(p1Marker, player1).
pieceIsOwnedBy(p2Piece, player2).
pieceIsOwnedBy(p2Marker, player2).


% GAME MODE
gameMode(playerVSplayer).
gameMode(playerVSpc).
gameMode(pcVSpc).

% INPUT FUNCTIONS
insertPiece(Row, Col):-
	readCoords(Row, Col), nl.

readCoords(Row, Col):-
	write('Line: '),
	getInt(SrcRow),
	
	discardInputChar,
	write('Col: '),
	getInt(SrcCol),

	discardInputChar,

	Row is SrcRow-1,
	Col is SrcCol-1.
	
	
% NORMAL GAME	
playGame(Game):-
	checkEndConditions(Game),
	(
		% pc vs pc
		(getGameMode(Game, Mode), Mode == pcVSpc) -> (
			(getGamePcLevel(Game, Level), Level == 1) -> (pcRandomMove(Game, NewGame), pressEnterToContinue, playGame(NewGame), !);
			(getGamePcLevel(Game, Level), Level == 2) -> (pcSmartMove(Game, NewGame), pressEnterToContinue, playGame(NewGame), !)
		);
		% player vs. player or player vs. bot
		(
			humanTurn(Game, ResGame),
			(
				% player vs player
				(getGameMode(Game, Mode), Mode == playerVSplayer) -> (playGame(ResGame), !);

				% player vs pc
				(getGamePcLevel(ResGame, Level), Level == 1) -> (pcRandomMove(ResGame, NewGame), pressEnterToContinue, playGame(NewGame), !);
				(getGamePcLevel(ResGame, Level), Level == 2) -> (pcSmartMove(ResGame, NewGame), pressEnterToContinue, playGame(NewGame), !)
			)
		)
	).
	
% END GAME
playGame(Game):-
	clearConsole,
	getGameBoard(Game, Board), 
	printBoard(Board),
	getPontuationPlayer1(Game, Pont1),
	getPontuationPlayer2(Game, Pont2),
	% check which player won
	getGamePlayerTurn(Game, Player),
	(
		(Pont1 > Pont2 ->
			(write('# Game over. Player 1 won, congratulations!'), nl));
		(Pont1 < Pont2 ->
			(write('# Game over. Player 2 won, congratulations!'), nl));
		(getNumPiecesPlayer1(Game, Num1), getNumPiecesPlayer2(Game, Num2),
			(Num1 @>  Num2 ->
			(write('# Game over. Player 1 won, Player 1 was more unused pieces'), nl));
			(Num1 @< Num2 ->
			(write('# Game over. Player 2 won, Player 2 was more unused pieces'), nl))
		)
	),
	nl,
	pressEnterToContinue, !.
	
humanTurn(Game, ResGame):-
	getGameBoard(Game, Board), getGamePlayerTurn(Game, Player),
	
	clearConsole,
	printBoard(Board),
	printTurnInfo(Player, Game), nl, nl,
	putPlayerPiece(Board, Player, NewBoard),
	decNumPiecesPlayer(Game, Player, Game1),
	setGameBoard(Game1, NewBoard, Game2),
	endTurn(Game2, TempGame),
	changePlayer(TempGame, ResGame), !.
	
printTurnInfo(player1, Game):-
	write('Player 1 info:'), nl,
	getNumPiecesPlayer1(Game, Pieces),
	getNumMarkersPlayer1(Game, Markers),
	getPontuationPlayer1(Game, Pont),
	write('> Pieces: '), write(Pieces), nl,
	write('> Markers: '), write(Markers), nl,
	write('> Pontuation: '), write(Pont), nl.

printTurnInfo(player2, Game):-
	write('Player 2 info:'), nl,
	getNumPiecesPlayer2(Game, Pieces),
	getNumMarkersPlayer2(Game, Markers),
	getPontuationPlayer2(Game, Pont),
	write('> Pieces: '), write(Pieces), nl,
	write('> Markers: '), write(Markers), nl,
	write('> Pontuation: '), write(Pont), nl.
	
changePlayer(Game, ResGame):-
	getGamePlayerTurn(Game, Player),
	(
		Player == player1 ->
			NextPlayer = player2;
		NextPlayer = player1
	),
	setGamePlayerTurn(Game, NextPlayer, ResGame).