%%%%%%%%%%%%%%%%%%Random%%%%%%%%%%%%%%%%%%
%gera um novo tabuleiro inicial com os jokers postos
randInitialBoard(Board).

%poe aleatoriamente um joker no tabuleiro
%a componente da dificuldade entra aqui? (ver mais para a frente)
randJokerPiece(OldBoard, Level, NewBoard).

%%%%%%%%%%%%%%%%%%Initialize game%%%%%%%%%%%%%%%%%%
%define o jogo para PC vs PC
%level e o nivel de dificuldade para cada computador
playPCvsPC(Level1, Level2).

%define o jogo para PC vs Humano
%retorna o tabuleiro em board
playPCvsHuman(Board).

%define o jogo para Humano vs Humano
%retorna o tabuleiro em board
playHumanvsHuman(Board).

%%%%%%%%%%%%%%%%%%Movements%%%%%%%%%%%%%%%%%%
%falha se o joker e posto numa posicao errada
placeJoker(Board, Player, TileNumber).

%devolve as jogadas possiveis em ListOfMoves
validMoves(Board, Player, ListOfMoves).

%falha se nao poder ser feito o movimento
move(Board, Player, TileNumber, NewBoard).

%avalia a jogada e devolve o seu valor em Value
value(Board, Player, TileNumber, Value).

%caso o jogo tenha acabado devolve o vencedor em Winner
gameOver(Board, Winner).

%jogada do computador em que consoante diferentes niveis de dificuldade (Level) devolve jogadas diferentes
choose_Move(Board, Level, Move).

%poe as bases e tira as cruzes do jogador Player
putTiles(Board, Player, NewBoard).

%%%%%%%%%%%%%%%%%%Count Points%%%%%%%%%%%%%%%%%%
%so se podem fazer pontos nestas posicoes
%o numero de pontos e retornado em Points
%caso se queira o tabuleiro sem as pecas pontuadas basta ficar com o tabuleiro NewBoard
checkCross(Board, Player, Points, NewBoard).
checkPlus(Board, Player, Points, NewBoard).
checkDiagonal(Board, Player, Points, NewBoard).

%verifica os pontos em qualquer tipo de posicoes
checkAll(Board, Player, Points, NewBoard).