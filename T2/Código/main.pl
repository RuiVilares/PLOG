:- include('constraints.pl').

%este predicado e o unico que deve estar disponivel para o utilizador
%cria um tabuleiro aleatorio de tamanho Size
%cria as respetivas restricoes
%cria um novo tabuleiro para ser resolvido
%resolve o tabuleiro sabendo apenas as restricoes atraves de backtracking
%imprime no ecra um tabuleiro com as restricoes
%de seguida imprime no ecra o tabuleiro resolvido
%Tabuleiro de tamanho 6 corresponde a um nivel facil
%Tabuleiro de tamanho >10 corresponde a uma dificuldade muito elevada (maior tempo de computacao)
%Size = 6 -> resultado quase instantaneo
%Size = 10 -> resultado pode demorar cerca de 1 minuto
%Exemplo de chamada: kropki(6)
kropki(Size) :-
	Size > 1,
	retractall(horizontal(_,_,_)),
	retractall(vertical(_,_,_)),
	create(Size, Board),
	%once(printBoard(Board)),
	assertDots(Board),
	%once(printBoard(Board)),
	createBoard(Size, BoardToSolve),
	once(printBoard(BoardToSolve)),
	statistics(runtime, [T0|_]),
	solveUser(Size, BoardToSolve),
	statistics(runtime, [T1|_]),
	once(printBoard(BoardToSolve)),
	nl,
	fd_statistics,
	nl,
	T is T1 - T0,
	format('Solving the board took ~3d sec.~n', [T]).

%o tamanho minimo do tabuleiro deve ser maior que 1
%o predicao falha intencionalmente
kropki(_) :-
  write('Enter a value bigger than 1.'), nl,
  fail.
