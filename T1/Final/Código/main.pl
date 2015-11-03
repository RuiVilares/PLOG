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
	%%mainMenu.
	%%startPlayerVSPlayer.
	emptyBoard(Board),
	defineEndPoins(Points),
	write(Points),nl,
	Game = [Board, [[14, 18], [14, 18]], player1, playerVSplayer, Points],
	insertPiece(Board, 1, 0, 4, NewBoard1),
	insertPiece(NewBoard1, 1, 1, 3, NewBoard2),
	insertPiece(NewBoard2, 0, 2, 2, NewBoard3),
	insertPiece(NewBoard3, 1, 3, 1, NewBoard4),
	insertPiece(NewBoard4, 1, 4, 0, Board5),
	setGameBoard(Game, Board5, NewGame),
	endTurn(NewGame, NewGame1),
	getGameBoard(NewGame1, NewBoard),
	printBoard(NewBoard).
	
	
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
			pressEnterToContinue, !
		);
		% player vs. player or player vs. bot
		(
			letHumanPlay(Game, ResGame),
			(
				% player vs player
				(getGameMode(Game, Mode), Mode == playerVSplayer) -> (playGame(ResGame), !);

				% player vs pc
				(pressEnterToContinue, !)
			)
		)
	).
	
% END GAME
playGame(Game):-
	clearConsole,
	getGameBoard(Game, Board), 
	printBoard(Board),

	% check which player won
	getGamePlayerTurn(Game, Player),
	(
		Player == player1 ->
			(write('# Game over. Player 2 won, congratulations!'), nl);
		Player == player2 ->
			(write('# Game over. Player 1 won, congratulations!'), nl)
	),
	nl,
	pressEnterToContinue, !.
	
letHumanPlay(Game, ResGame):-
	getGameBoard(Game, Board), getGamePlayerTurn(Game, Player),

	clearConsole,
	printBoard(Board),
	printTurnInfo(Player, Game), nl, nl,
	putPlayerPiece(Board, Player, NewBoard),
	decNumPiecesPlayer(Game, Player, Game1),
	%% Função de iteração completa que retorna o temp Game
	setGameBoard(Game1, NewBoard, TempGame),%% APENAS TEMPORÁRIA
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