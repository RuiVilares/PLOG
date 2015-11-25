horizontal(-1,-1,_):-fail.
vertical(-1,-1,_):-fail.

%getMatrixElemAt(Row, Col, Matrix, Result)
getMatrixElemAt(_, _, [], -3).
getMatrixElemAt(1, Col, [X|_], Elem):-
	getListElemAt(Col, X, Elem).
getMatrixElemAt(Row, Col, [_|Y], Elem):-
	Row > 1,
	Row1 is Row-1,
	getMatrixElemAt(Row1, Col, Y, Elem).

%getListElemAt(Pos, List, Result)
getListElemAt(_, [], -3).
getListElemAt(1, [X|_], X).
getListElemAt(Pos, [_|Y], Elem):-
	Pos > 1,
	Pos1 is Pos-1,
	getListElemAt(Pos1, Y, Elem).

assertDots(Board):-
  length(Board, Size),
  assertDotsRow(Board, Size, 1).

assertDotsRow(Board, Size, Size) :-
	assertDotsCol(Board, Size, Size, 1).

assertDotsRow(Board, Size, Row):-
  Row < Size,
  assertDotsCol(Board, Size, Row, 1),
  Row1 is Row + 1,
  assertDotsRow(Board, Size, Row1).

assertDotsCol(Board, Size, Row, Size):-
	assertDot(Board, Row, Size).

assertDotsCol(Board, Size, Row, Col):-
  Col < Size,
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
	checkDiv(Elem, ElemRight),
  assert(horizontal(Row, Col, black)).

assertDotHor(Elem, ElemRight, Row, Col):-
	ElemRight > 0,
  Elem is ElemRight*2,
  assert(horizontal(Row, Col, black)).

assertDotHor(Elem, ElemRight, Row, Col):-
  Elem is ElemRight + 1,
  assert(horizontal(Row, Col, white)).

assertDotHor(Elem, ElemRight, Row, Col):-
  Elem is ElemRight - 1,
  assert(horizontal(Row, Col, white)).

assertDotHor(_, _, _, _).

assertDotVer(Elem, ElemDown, Row, Col):-
  Elem is ElemDown + 1,
  assert(vertical(Row, Col, white)).

assertDotVer(Elem, ElemDown, Row, Col):-
  Elem is ElemDown - 1,
  assert(vertical(Row, Col, white)).

assertDotVer(Elem, ElemDown, Row, Col):-
	ElemDown > 0,
  Elem is ElemDown*2,
  assert(vertical(Row, Col, black)).

assertDotVer(Elem, ElemDown, Row, Col):-
	checkDiv(Elem, ElemDown),
  assert(vertical(Row, Col, black)).

assertDotVer(_, _, _, _).

checkDiv(Elem, Elem1):-
	Elem2 is Elem1//2,
	0 is Elem1 mod 2,
	Elem1 > 0,
  Elem == Elem2.
