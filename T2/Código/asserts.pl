%casos base para os pontos horizontal e vertical
horizontal(-1,-1,_):-fail.
vertical(-1,-1,_):-fail.

%Result vai estar instanciado com o valor da Matrix da linha Row e coluna Col
%getMatrixElemAt(Row, Col, Matrix, Result)
getMatrixElemAt(_, _, [], -3).
getMatrixElemAt(1, Col, [X|_], Elem):-
	getListElemAt(Col, X, Elem).
getMatrixElemAt(Row, Col, [_|Y], Elem):-
	Row > 1,
	Row1 is Row-1,
	getMatrixElemAt(Row1, Col, Y, Elem).

%Result vai ser o elemento numero Pos de List
%getListElemAt(Pos, List, Result)
getListElemAt(_, [], -3).
getListElemAt(1, [X|_], X).
getListElemAt(Pos, [_|Y], Elem):-
	Pos > 1,
	Pos1 is Pos-1,
	getListElemAt(Pos1, Y, Elem).

%cria as restricoes dos pontos
assertDots(Board):-
  length(Board, Size),
  assertDotsRow(Board, Size, 1).

%cria as restricoes dos pontos para cada linha
%caso base
assertDotsRow(Board, Size, Size) :-
	assertDotsCol(Board, Size, Size, 1).

assertDotsRow(Board, Size, Row):-
  Row < Size,
  assertDotsCol(Board, Size, Row, 1),
  Row1 is Row + 1,
  assertDotsRow(Board, Size, Row1).

%cria as restricoes dos pontos para cada coluna
%caso base
assertDotsCol(Board, Size, Row, Size):-
	assertDot(Board, Row, Size).

assertDotsCol(Board, Size, Row, Col):-
  Col < Size,
  assertDot(Board, Row, Col),
  Col1 is Col + 1,
  assertDotsCol(Board, Size, Row, Col1).

%verifica se e preciso criar alguma restricao para a posicao atual
%caso seja necessario e criada uma restricao horizontal ou vertical
%consoante o caso
assertDot(Board, Row, Col):-
  Col1 is Col + 1,
  Row1 is Row + 1,
  getMatrixElemAt(Row, Col, Board, Elem),
  getMatrixElemAt(Row, Col1, Board, ElemRight),
  getMatrixElemAt(Row1, Col, Board, ElemDown),
  assertDotHor(Elem, ElemRight, Row, Col),
  assertDotVer(Elem, ElemDown, Row, Col).

%cria um novo facto
%ponto a direita do elemento atual com cor branca
assertDotHor(Elem, ElemRight, Row, Col):-
  Elem is ElemRight + 1,
  assert(horizontal(Row, Col, white)).

%cria um novo facto
%ponto a direita do elemento atual com cor branca
assertDotHor(Elem, ElemRight, Row, Col):-
  Elem is ElemRight - 1,
  assert(horizontal(Row, Col, white)).

%cria um novo facto
%ponto a direita do elemento atual com cor preta
assertDotHor(Elem, ElemRight, Row, Col):-
	ElemRight > 0,
	ElemRight is Elem*2,
	assert(horizontal(Row, Col, black)).

%cria um novo facto
%ponto a direita do elemento atual com cor preta
assertDotHor(Elem, ElemRight, Row, Col):-
	ElemRight > 0,
  Elem is ElemRight*2,
  assert(horizontal(Row, Col, black)).

%para nao falhar
assertDotHor(_, _, _, _).

%cria um novo facto
%ponto abaixo do elemento atual com cor branca
assertDotVer(Elem, ElemDown, Row, Col):-
  Elem is ElemDown + 1,
  assert(vertical(Row, Col, white)).

%cria um novo facto
%ponto abaixo do elemento atual com cor branca
assertDotVer(Elem, ElemDown, Row, Col):-
  Elem is ElemDown - 1,
  assert(vertical(Row, Col, white)).

%cria um novo facto
%ponto abaixo do elemento atual com cor preta
assertDotVer(Elem, ElemDown, Row, Col):-
	ElemDown > 0,
  Elem is ElemDown*2,
  assert(vertical(Row, Col, black)).

%cria um novo facto
%ponto abaixo do elemento atual com cor preta
assertDotVer(Elem, ElemDown, Row, Col):-
	ElemDown > 0,
	ElemDown is Elem*2,
  assert(vertical(Row, Col, black)).

%para nao falhar
assertDotVer(_, _, _, _).
