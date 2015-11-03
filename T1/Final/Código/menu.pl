% MENUS 

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
	write('> '), nl.
	
playMenu:-
	printPlayMenu,
	getChar(Input),
	(
		Input = '1' -> startPlayerVsPlayer;
		Input = '2' -> startPlayerVsPc;
		Input = '3' -> startPcVsPc;
		Input = '4';
		gameModeMenu
	).
	

startPlayerVsPlayer:-
	createPlayerVsPlayer(Game),
	playGame(Game).
	
startPlayerVsPc:-
	createPlayerVsPc(Game),
	playGame(Game).

startPcVsPc:-
	createPcVsPc(Game),
	playGame(Game).
	
printHelpMenu:-
	clearConsole,
	write('Information About How ModX is displayed:'), nl,
	write('\tCross:'), nl,
	write('\t\t[whitespace] -> empty'), nl,
	write('\t\t0 -> joker (transparent)'), nl,
	write('\t\t1 -> player 1'), nl,
	write('\t\t2 -> player 2'), nl,
	write('\tTile:'), nl,
	write('\t\t[whitespace] -> empty'), nl,
	write('\t\t* -> tile of player 1'), nl,
	write('\t\t: -> tile of player 2'), nl,
	write('\tBoard Game Example:'), nl,
	write('\t\t-----------------'), nl,
	write('\t\t| 1:::1 | 2   2 |'), nl,
	write('\t\t| ::1:: |   2   |'), nl,
	write('\t\t| 1:::1 | 2   2 |'), nl,
	write('\t\t|---------------|'), nl,
	write('\t\t|       | ***** |'), nl,
	write('\t\t|       | ***** |'), nl,
	write('\t\t|       | ***** |'), nl,
	write('\t\t-----------------'), nl,
	pressEnterToContinue, nl.
	
printAboutMenu:-
	clearConsole,
	write('*********************************'), nl,
	write('*             ABOUT             *'), nl,
	write('*********************************'), nl,
	write('*                               *'), nl,
	write('*    > Ant�nio Ramadas          *'), nl,
	write('*    > Rui Vilares              *'), nl,
	write('*                               *'), nl,
	write('*  MIEIC       FEUP       PLOG  *'), nl,
	write('*                               *'), nl,
	write('*********************************'), nl,
	pressEnterToContinue, nl.
