/*--------------------------------------------------
 *
 * Macros
 *
 *------------------------------------------------*/

nobodyElseHolds(Card) :-
	write('test'), nl, nl.

nobodyElseHolds(P, Card) :-
	write('test'), nl, nl.

nobodyElseHolds([P], Card) :-
	write('test'), nl, nl.


/*--------------------------------------------------
 *
 * holds inference rules
 *
 *------------------------------------------------*/

holds(Turn,CardC) :-
	holdsOneOf(Turn,CardA,CardB,CardC), 
	cantHold(Turn,CardB), 
	cantHold(Turn,CardA).

holds(Turn,CardB) :-
	holdsOneOf(Turn,CardA,CardB,CardC),
	cantHold(Turn,CardA),
	cantHold(Turn,CardC).

holds(Turn,CardA) :-
	holdsOneOf(Turn,CardA,CardB,CardC),
	cantHold(Turn,CardB),
	cantHold(Turn,CardC).

holds(Turn,CardA) :-
	holdsTwoOf(Turn,CardA,CardB,CardC),
	cantHold(Turn,CardC).

holds(Turn,CardB) :-
	holdsTwoOf(Turn,CardA,CardB,CardC),
	cantHold(Turn,CardC).

holds(Turn,CardA) :-
	holdsTwoOf(Turn,CardA,CardB,CardC),
	cantHold(Turn,CardB).

holds(Turn,CardC) :-
	holdsTwoOf(Turn,CardA,CardB,CardC),
	cantHold(Turn,CardB).

holds(Turn,CardB) :-
	holdsTwoOf(Turn,CardA,CardB,CardC),
	cantHold(Turn,CardA).

holds(Turn,CardC) :-
	holdsTwoOf(Turn,CardA,CardB,CardC),
	cantHold(Turn,CardA).

/*--------------------------------------------------
 *
 * cantHold inference rules
 *
 *------------------------------------------------*/

% a player cant hold a card if somebody else holds it
cantHold(Turn, Card) :-
	holds(Turn2, Card), Turn2 \= Turn.