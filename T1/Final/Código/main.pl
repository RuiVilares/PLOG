% INCLUDES
:- use_module(library(random)).
:- use_module(library(system)).
:- include('menu.pl').
:- include('auxiliaryFunctions.pl').
:- include('printFunctions.pl').
:- include('gameFunctions.pl').

% START GAME
modx:-
	initializeRandom,
	%mainMenu.
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
gameMode(playerVSbot).
gameMode(botVSbot).

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