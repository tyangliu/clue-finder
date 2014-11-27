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
 * card set inference rules
 *
 *------------------------------------------------*/

% if nobody holds weapon, room, and suspect, then the set is accusable
accusableSet(Weapon, Room, Suspect) :-
	weapon(Weapon), nobodyHolds(Weapon), room(Room), nobodyHolds(Room), suspect(Suspect), nobodyHolds(Suspect).

% set is suggestable if all component cards are suggestable
suggestableSet(Weapon, Room, Suspect) :-
	weapon(Weapon), suggestableCard(Weapon), room(Room), suggestableCard(Room), suspect(Suspect), suggestableCard(Suspect).

/*--------------------------------------------------
 *
 * suggestable card inference rules
 *
 *------------------------------------------------*/

% ----- suggestableCard rules are listed top-to-bottom in order of priority  ----- %

% a player holds one of three cards, one cantHold already confirmed, 
% other two unknown
% AFTER SUGGESTION: up to two confirms (holds or cantHold)
suggestableCard(Card) :-
	unconfirmedCard(Card), holdsOneOf(Turn, Cards), member(Card, Cards), 
	cantHold(Turn, Card2), member(Card2, Cards),
	unconfirmedCard(Card3), Card3 \= Card, member(Card3, Cards).

% ma player holds one of three cards
% AFTER SUGGESTION: up to one confirm (holds or cantHold), 
%                   one additional top priority suggestable card afterward
suggestableCard(Card) :-
	unconfirmedCard(Card), holdsOneOf(_, Cards), member(Card, Cards).

% bottom priority suggestable card - any card not yet confirmed
suggestableCard(Card) :-
	unconfirmedCard(Card).

/*--------------------------------------------------
 *
 * unconfirmed card inference rules
 *
 *------------------------------------------------*/

% card not yet confirmed to be held or in envelope
unconfirmedCard(Card) :-
	(not(nobodyHolds(Card))), (not(holds(_, Card))).

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
 * cantHold inference rules
 *
 *------------------------------------------------*/

% a player cant hold a card if somebody else holds it
cantHold(Turn, Card) :-
	holds(Turn2, Card), Turn2 \= Turn.

/*--------------------------------------------------
 *
 * nobody holds inference rules
 *
 *------------------------------------------------*/

% if every player cantHold, then nobodyHolds a card
 nobodyHolds(Card) :-
 	exists(Card), findall(Turn, cantHold(Turn, Card), Turns),
 	length(Turns, L), players(NumPlayers), 
 	% check that number of cantHolds = NumPlayers
 	L is NumPlayers.