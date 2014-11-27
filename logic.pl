/*-------------------------------------------------
 *
 * Tianyang Liu     47867130      y6x8
 *
 * ------------------------------------------------
 *
 * Jason Zenan Wu   46823118      d4c8
 *
 * ------------------------------------------------
 *
 * Clue Finder: Logical Inference Rules
 *
 *-----------------------------------------------*/


/*--------------------------------------------------
 *
 * general inference rules
 *
 *------------------------------------------------*/

% if nobody holds weapon, room, and suspect, then the set is accusable
accusableSet(Weapon, Room, Suspect) :-
	nobodyHolds(Weapon), nobodyHolds(Room), nobodyHolds(Suspect).

/*--------------------------------------------------
 *
 * holds inference rules
 *
 *------------------------------------------------*/

% infer holds from one holdsOneOf and two cantHolds
holds(Turn,Card) :-
	holdsOneOf(Turn,Cards), member(Card, Cards),
	cantHold(Turn,Card2), member(Card2, Cards), Card2 \= Card,
	cantHold(Turn,Card3), member(Card3, Cards), Card3 \= Card2, Card3 \= Card.

% infer holds from one holdsTwoOf and one cantHold
holds(Turn,Card) :-
	holdsTwoOf(Turn,Cards), member(Card, Cards),
	cantHold(Turn,Card2), member(Card2, Cards), Card2 \= Card.

/*--------------------------------------------------
 *
 * cantHold inference rules
 *
 *------------------------------------------------*/

% a player cant hold a card if somebody else holds it
cantHold(Turn, Card) :-
	holds(Turn2, Card), Turn2 \= Turn.


/*--------------------------------------------------
 *
 * potentially holds inference rules
 *
 *------------------------------------------------*/

 maybeHolds(Turn, Card) :-
 	holds(Turn, Card);
 	holdsOneOf(Turn, Cards), member(Card, Cards);
 	holdsTwoOf(Turn, Cards), member(Card, Cards).

/*--------------------------------------------------
 *
 * nobody holds inference rules
 *
 *------------------------------------------------*/