
holds(P,CardC) :-
	holdsOneOf(P,CardA,CardB,CardC), 
	cantHold(P,CardB), 
	cantHold(P,CardA).

holds(P,CardB) :-
	holdsOneOf(P,CardA,CardB,CardC),
	cantHold(P, CardA),
	cantHold(P,CardC).

holds(P,CardA) :-
	holdsOneOf(P,CardA,CardB,CardC),
	cantHold(P, CardB),
	cantHold(P, CardC).

holds(P,CardA) :-
	holdsTwoOf(P,CardA,CardB,CardC),
	cantHold(P,CardC).

holds(P,CardB) :-
	holdsTwoOf(P,CardA,CardB,CardC),
	cantHold(P,CardC).

holds(P,CardA) :-
	holdsTwoOf(P,CardA,CardB,CardC),
	cantHold(P,CardB).

holds(P,CardC) :-
	holdsTwoOf(P,CardA,CardB,CardC),
	cantHold(P,CardB).

holds(P,CardB) :-
	holdsTwoOf(P,CardA,CardB,CardC),
	cantHold(P,CardA).

holds(P,CardC) :-
	holdsTwoOf(P,CardA,CardB,CardC),
	cantHold(P,CardA)