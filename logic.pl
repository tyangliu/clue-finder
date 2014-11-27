
Holds(P,CardC) :-
	HoldsOneOf(P,CardA,CardB,CardC), 
	cantHold(P,CardB), 
	cantHold(P,CardA).

Holds(P,CardB) :-
	HoldsOneOf(P,CardA,CardB,CardC),
	cantHold(P, CardA),
	cantHold(P,CardC).

Holds(P,CardA) :-
	HoldsOneOf(P,CardA,CardB,CardC),
	cantHold(P, CardB),
	cantHold(P, CardC).

Holds(P,CardA) :-
	HoldsTwoOf(P,CardA,CardB,CardC),
	cantHold(P,CardC).

Holds(P,CardB) :-
	HoldsTwoOf(P,CardA,CardB,CardC),
	cantHold(P,CardC).

Holds(P,CardA) :-
	HoldsTwoOf(P,CardA,CardB,CardC),
	cantHold(P,CardB).

Holds(P,CardC) :-
	HoldsTwoOf(P,CardA,CardB,CardC),
	cantHold(P,CardB).

Holds(P,CardB) :-
	HoldsTwoOf(P,CardA,CardB,CardC),
	cantHold(P,CardA).

Holds(P,CardC) :-
	HoldsTwoOf(P,CardA,CardB,CardC),
	cantHold(P,CardA)