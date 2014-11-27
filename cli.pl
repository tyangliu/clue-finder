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
 * Clue Finder: Command Line Interface
 *
 *-----------------------------------------------*/

:- abolish(suspect/1).
:- abolish(room/1).
:- abolish(weapon/1).
:- abolish(players/1).
:- abolish(myTurn/1).
:- abolish(exists/1).
:- abolish(holds/2).

:- dynamic(suspect/1).
:- dynamic(room/1).
:- dynamic(weapon/1).
:- dynamic(players/1).
:- dynamic(myTurn/1).
:- dynamic(exists/1).
:- dynamic(holds/2).

%  load logic file
:- [logic].

/*-------------------------------------------------
 *
 * Game initialization: start the game
 *
 *-----------------------------------------------*/

play :-
    write('Clue is about to begin, just a little set up!'), nl, nl,
    getVersion, nl,
    getNumPlayers, nl,
    getTurn, nl,
    write('What cards are in your hand?'), nl, nl,
    getPlayerHand, nl,
    write('You\'re all set. Let\'s win this game!'), nl, nl,
    % start the game CLI on turn 1
    game(1).
    
/*--------------------------------------------------
 *
 * Game initialization : set cards or card version
 *
 *------------------------------------------------*/

% prompt for card version and read input

getVersion :-
    write('What version of cards would you like to use?'), nl,
    write('[o] the old version'), nl,
    write('[n] the new version'), nl,
    write('[c] load custom cards'), nl, nl,
    read(Version), loadVersion(Version).

% load the card set (old and new default versions, or custom input)

loadVersion(Version) :-
    % load old version preset
    Version = o -> ['old-version-presets'];
    % load new version preset
    Version = n -> ['new-version-presets'];
    % ask user to set the cards of the game
    Version = c -> loadCards;
    % if version is not valid, run the prompt again
    write('Oops, that\'s not a valid version.'), nl, nl, getVersion.

% load the cards to be used for the game if user chooses 
% to load custom cards

loadCards :-
    write('What weapon cards are in this game?'), nl, nl,
    loadCards(weapon),
    write('What room cards are in this game?'), nl, nl,
    loadCards(room), 
    write('What suspect cards are in this game?'), nl, nl,
    loadCards(suspect).

% prompt for a card of specific card type, or f to finish

loadCards(Type) :-
    write('-> Type a '), 
    write(Type),
    write(' name or \'f\' when you\'re finished:'), nl, nl,
    read(Card),
    ( Card = f -> true;
          % if card is already added, don't add the card
        ( exists(Card) -> write('You already added this card!');
          % otherwise, save the card and mark as exists
          assertz(exists(Card)),
          ( Type = weapon  -> assertz(weapon(Card)) ;
            Type = room    -> assertz(room(Card)) ;
            Type = suspect -> assertz(suspect(Card))) ) ),
    % prompt for another card
    loadCards(Type).

/*--------------------------------------------------
 *
 * Game initialization : set the number of players
 *
 *------------------------------------------------*/

getNumPlayers :-
    write('How many players are there?'), nl, nl,
    read(NumPlayers),
    ( NumPlayers < 2 -> write('Number of players must be between 2 and 6.'), nl, nl, getNumPlayers;
      NumPlayers > 6 -> write('Number of players must be between 2 and 6.'), nl, nl, getNumPlayers;
      asserta(players(NumPlayers)) ).

/*--------------------------------------------------
 *
 * Game initialization : set the turn order
 *
 *------------------------------------------------*/

getTurn :-
    write('What turn are you playing on?'), nl, nl,
    read(Turn),
      % store Turn if > 0 and < number of players
    ( validTurn(Turn) -> asserta(myTurn(Turn)); 
      % otherwise prompt for valid turn 
      write('Please enter a valid turn number.'), nl, nl, getTurn ).

validTurn(Turn) :-
    (Turn > 0), players(N), (Turn =< N).


/*--------------------------------------------------
 *
 * Game initialization : set the player's hand
 *
 *------------------------------------------------*/

getPlayerHand :-
    write('-> Type a card name or \'f\' when you\'re finished:'), nl, nl,
    read(Card),
    % finished entering cards, move on
    ( Card = f -> true;
      % if card is valid, remember it
      exists(Card) -> myTurn(T), assertz(holds(T, Card)), getPlayerHand;
      % otherwise show error and prompt for card
      write('Please type a valid card name.'), nl, nl, getPlayerHand ).
 
/*--------------------------------------------------
 *
 * Game duration: main
 *
 *------------------------------------------------*/

game(Turn) :-
    % user's turn
    ( myTurn(Turn) -> write('Your move! What would you like to do?'), nl, 
        myMove;
    % another player's turn
       write('It is player '), 
       write(Turn), 
       write('\'s move. Let me know what happened!'), nl, 
       othersMove(Turn) ), 
    % move to the next turn
    switchTurns(Turn, NextTurn), game(NextTurn).

% reset turn to 1 after last player finishes turn
switchTurns(Turn, NextTurn) :-
    players(Turn), NextTurn is 1.

% otherwise add 1 to the turn counter
switchTurns(Turn, NextTurn) :-
    NextTurn is Turn + 1.

/*--------------------------------------------------
 *
 * Game duration: user's move
 *
 *------------------------------------------------*/

myMove :-
    write('[s] Make a suggestion.'), nl,
    write('[a] Make an accusation. '), nl, nl,
    write('Other commands:'), nl,
    write('[h] Get some hints.'), nl,
    write('[d] Show the knowledge database.'), nl, nl,
    read(Action),
    ( Action = s -> mySuggest;
      Action = a -> myAccuse;
      Action = h -> getHints, myMove;
      Action = d -> getData, myMove;
      write('Please choose a valid option!'), nl, nl, myMove ).

mySuggest :-
    write('-> Suggest a weapon:'), nl, nl,
    read(Weapon),
    write('-> Suggest a room:'), nl, nl,
    read(Room),
    write('-> Suggest a suspect:'), nl, nl,
    read(Suspect),
    myFeedback(Weapon, Room, Suspect).

myFeedback(Weapon, Room, Suspect) :-
    write('Were any cards shown?'), nl,
    write('[y] Yes'), nl, 
    write('[n] Nope'), nl, nl,
    read(Response), 
    ( Response = y -> myShown(Weapon, Room, Suspect);
      Response = n -> myNotShown(Weapon, Room, Suspect);
      write('Please choose a valid option!'), nl, nl, 
      myFeedback(Weapon, Room, Suspect) ).

myShown(Weapon, Room, Suspect) :-
    write('-> Type a card name or \'f\' if you\'re finished:'), nl, nl,
    read(Card), 
      % assert that if suggested cards that have not been shown
      % are not already held, then nobody holds them
    ( Card = f -> myNotShown(Weapon, Room, Suspect), true; 
      write('-> Player who showed you the card:'), nl, nl,
      read(Turn), 
      % save the fact that card is held
      assertz(holds(Turn, Card)),
      myShown(Weapon, Room, Suspect) ).

% if no shown cards, then nobody holds any of the cards
myNotShown(Weapon, Room, Suspect) :-
      % if a card is not shown, and it is not held already, 
      % then nobody holds it
    not(holds(_, Weapon))  -> assertz(nobodyHolds(Weapon));
    not(holds(_, Room))    -> assertz(nobodyHolds(Room));
    not(holds(_, Suspect)) -> assertz(nobodyHolds(Suspect)).

% TODO
myAccuse :-
    write('-> Accuse a weapon:'), nl, nl,
    read(Weapon),
    write('-> Accuse a room:'), nl, nl,
    read(Room),
    write('-> Accuse a suspect:'), nl, nl,
    read(Suspect).

/*--------------------------------------------------
 *
 * Game duration: another player's move
 *
 *------------------------------------------------*/

othersMove(Turn) :- 
    write('[s] Player '), write(Turn), write(' made a suggestion.'), nl,
    write('[a] Player '), write(Turn), write(' made an accusation.'), nl, nl,
    write('Other commands:'), nl,
    write('[h] Get some hints.'), nl,
    write('[d] Show the knowledge database.'), nl, nl,
    read(Action),
    ( Action = s -> othersSuggest(Turn);
      Action = a -> othersAccuse(Turn);
      Action = h -> getHints, othersMove(Turn);
      Action = d -> getData, othersMove(Turn);
      write('Please choose a valid option!'), nl, nl, othersMove(Turn) ).

othersSuggest(Turn) :-
    write('Player '), write(Turn), write('\'s suggested weapon:'), nl, nl,
    read(Weapon),
    write('Player '), write(Turn), write('\'s suggested room:'), nl, nl,
    read(Room),
    write('Player '), write(Turn), write('\'s suggested suspect:'), nl, nl,
    read(Suspect),
    othersFeedback(Turn, Weapon, Room, Suspect).

othersFeedback(Turn, Weapon, Room, Suspect) :-
    write('Were any cards shown?'), nl,
    write('[y] Yes'), nl, 
    write('[n] Nope'), nl, nl,
    read(Response), 
    ( Response = y -> othersShown(Turn, Weapon, Room, Suspect);
      Response = n -> othersNotShown(Turn, Weapon, Room, Suspect);
      write('Please choose a valid option!'), nl, nl, 
      othersFeedback(Turn, Weapon, Room, Suspect) ).

othersShown(Turn, Weapon, Room, Suspect) :-
    write('-> Type the number of cards shown or \'f\' to finish:'), nl, nl,
    read(CardCount), 
    % finish
    CardCount = f -> othersNotShown(Turn, Weapon, Room, Suspect);
    % continue
    write('-> Player who showed the card:'), nl, nl,
    read(Turn),
    ( CardCount = 1 -> assertz(holdsOneOf(Turn, [Weapon, Room, Suspect]));
      CardCount = 2 -> assertz(holdsTwoOf(Turn, [Weapon, Room, Suspect]));
      % if 3 cards shown, player holds all 3 cards
      CardCount = 3 -> assertz(holds(Turn, Weapon)), 
                       assertz(holds(Turn, Room)), 
                       assertz(holds(Turn, Suspect)); 
      write('Please enter a valid number of cards and player!'), nl, nl ), 
      othersShown(Turn, Weapon, Room, Suspect).

% if no shown cards, then nobody holds any of the cards
othersNotShown(Turn, Weapon, Room, Suspect) :-
    % if a card is not shown, and it is not held already, 
    % then nobody holds it
    % TODO!!!
    not(maybeHolds(_, Weapon))  -> assertz(nobodyHolds(Weapon));
    not(maybeHolds(_, Room))    -> assertz(nobodyHolds(Room));
    not(maybeHolds(_, Suspect)) -> assertz(nobodyHolds(Suspect)).

othersAccuse(Turn) :-
    write('-> Player '), write(Turn), write('\'s accused weapon:'), nl, nl,
    read(Weapon),
    write('-> Player '), write(Turn), write('\'s accused room:'), nl, nl,
    read(Room),
    write('-> Player '), write(Turn), write('\'s accused suspect:'), nl, nl,
    read(Suspect).

/*--------------------------------------------------
 *
 * Game duration: help commands
 *
 *------------------------------------------------*/

getHints :-
    accusableHint, nextSuggestionHint.

accusableHint :-
    ( accusableSet(Weapon, Room, Suspect) -> 
        write('Hey, I think you have enough information to make an accusation!'), nl, 
        write('-> Weapon: '), write(Weapon), write(','), nl,
        write('-> Room: '), write(Room), write(','), nl,
        write('-> Suspect: '), write(Suspect), write(','), nl, nl, true;
     true ).

nextSuggestionHint :-
    write('TODO'), nl, nl.

getData :-
    write('TODO'), nl, nl.

/*--------------------------------------------------
 *
 * Helpers
 *
 *------------------------------------------------*/

% check that a card exists and is of the right type
checkValid(Type, Card) :-
    exists(Card),
    ( Type = weapon  -> weapon(Card);
      Type = room    -> room(Card);
      Type = suspect -> suspect(Card) ).