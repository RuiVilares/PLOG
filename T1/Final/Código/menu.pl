% 

printStartMenu:-
	clearConsole,
	write('*********************************'), nl,
	write('*             MOD X             *'), nl,
	write('*********************************'), nl,
	write('*                               *'), nl,
	write('*   1. Play                     *'), nl,
	write('*   2. Help                     *'), nl,
	write('*   3. About                    *'), nl,
	write('*   4. Exit                     *'), nl,
	write('*                               *'), nl,
	write('*********************************'), nl,
	write('> '), nl.
	
mainMenu:-
	printStartMenu,
	getChar(Input),
	(
		Input = '1' -> playMenu, mainMenu;
		Input = '2' -> printHelpMenu, mainMenu;
		Input = '3' -> printAboutMenu, mainMenu;
		Input = '4';

		mainMenu
	).
	

printPlayMenu:-
	clearConsole,
	write('*********************************'), nl,
	write('*           GAME MODE           *'), nl,
	write('*********************************'), nl,
	write('*                               *'), nl,
	write('*   1. Player vs. Player        *'), nl,
	write('*   2. Player vs. Computer      *'), nl,
	write('*   3. Computer vs. Computer    *'), nl,
	write('*   4. Back                     *'), nl,
	write('*                               *'), nl,
	write('*********************************'), nl,
	pressEnterToContinue, nl.	
	
playMenu:-
	printPlayMenu,
	getChar(Input),
	(
		Input = '1' -> startPvPGame;
		Input = '2' -> startPvBGame;
		Input = '3' -> startBvBGame;
		Input = '4';

		gameModeMenu
	).
	
	
%startPvPGame:-
%	createPvPGame(Game),
%	playGame(Game).
%startPvBGame:-
%	createPvBGame(Game),
%	playGame(Game).
%startBvBGame:-
%	createBvBGame(Game),
%	playGame(Game).
	
printHelpMenu:-
	clearConsole,
	write('*********************************'), nl,
	write('*             HELP              *'), nl,
	write('*********************************'), nl,
	write('*                               *'), nl,
	write('*                               *'), nl,
	write('*                               *'), nl,
	write('*                               *'), nl,
	write('*                               *'), nl,
	write('*                               *'), nl,
	write('*********************************'), nl,
	pressEnterToContinue, nl.
	
printAboutMenu:-
	clearConsole,
	write('*********************************'), nl,
	write('*             ABOUT             *'), nl,
	write('*********************************'), nl,
	write('*                               *'), nl,
	write('*    > António Ramadas          *'), nl,
	write('*    > Rui Vilares              *'), nl,
	write('*                               *'), nl,
	write('*  MIEIC       FEUP       PLOG  *'), nl,
	write('*                               *'), nl,
	write('*********************************'), nl,
	pressEnterToContinue, nl.
