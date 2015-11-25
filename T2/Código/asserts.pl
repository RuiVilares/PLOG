horizontal(-1,-1,_):-fail.
vertical(-1,-1,_):-fail.

%getMatrixElemAt(Row, Col, Matrix, Result)
getMatrixElemAt(0, Col, [X|_], Elem):-
	getListElemAt(Col, X, Elem).
getMatrixElemAt(Row, Col, [_|Y], Elem):-
	Row > 0,
	Row1 is Row-1,
	getMatrixElemAt(Row1, Col, Y, Elem).

%getListElemAt(Pos, List, Result)
getListElemAt(0, [X|_], X).
getListElemAt(Pos, [_|Y], Elem):-
	Pos > 0,
	Pos1 is Pos-1,
	getListElemAt(Pos1, Y, Elem).

assertDots(Board):-
  length(Board, Size),
  assertDotsRow(Board, Size, 0).

assertDotsRow(Board, Size, Row):-
  Row < Size - 1,
  assertDotsCol(Board, Size, Row, 0),
  Row1 is Row + 1,
  assertDotsRow(Board, Size, Row1).

assertDotsCol(Board, Size, Row, Col):-
  Col < Size - 1,
  assertDot(Board, Row, Col),
  Col1 is Col + 1,
  assertDotsCol(Board, Size, Row, Col1).

assertDot(Board, Row, Col):-
  Col1 is Col + 1,
  Row1 is Row + 1,
  getMatrixElemAt(Row, Col, Board, Elem),
  getMatrixElemAt(Row, Col1, Board, ElemRight),
  getMatrixElemAt(Row1, Col, Board, ElemDown),
  assertDotHor(Elem, ElemRight, Row, Col),
  assertDotVer(Elem, ElemDown, Row, Col).

assertDotHor(Elem, ElemRight, Row, Col):-
  Elem == ElemRight*2,
  assert(horizontal(Row, Col, preto)).

assertDotHor(Elem, ElemRight, Row, Col):-
  Elem == ElemRight/2,
  assert(horizontal(Row, Col, preto)).

assertDotHor(Elem, ElemRight, Row, Col):-
  Elem == ElemRight + 1,
  assert(vertical(Row, Col, white)).

assertDotHor(Elem, ElemRight, Row, Col):-
  Elem == ElemRight - 1,
  assert(vertical(Row, Col, white)).

assertDotVer(Elem, ElemDown, Row, Col):-
  Elem == ElemDown + 1,
  assert(vertical(Row, Col, white)).

assertDotVer(Elem, ElemDown, Row, Col):-
  Elem == ElemDown - 1,
  assert(vertical(Row, Col, white)).

assertDotVer(Elem, ElemDown, Row, Col):-
  Elem == ElemDown*2,
  assert(horizontal(Row, Col, preto)).

assertDotVer(Elem, ElemDown, Row, Col):-
  Elem == ElemDown/2,
  assert(horizontal(Row, Col, preto)).
