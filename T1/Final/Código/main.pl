% Includes
:- use_module(library(random)).
:- use_module(library(system)).
:- include('menu.pl').
:- include('various.pl').


% Start Game
modx:-
	initializeRandom,
	mainMenu.

