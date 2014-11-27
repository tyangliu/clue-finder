
:- abolish(suspect/1).
:- abolish(room/1).
:- abolish(weapon/1).
:- abolish(players/1).
:- abolish(myTurn/1).
:- abolish(exists/1).

:- dynamic(suspect/1).
:- dynamic(room/1).
:- dynamic(weapon/1).
:- dynamic(players/1).
:- dynamic(myTurn/1).
:- dynamic(exists/1).

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
    % start the game CLI
    game(0).
    
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
    Version = o -> [old-version-presets];
    % load new version preset
    Version = n -> [new-version-presets];
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
 * Game duration
 *
 *------------------------------------------------*/

game(Turn) :-
    write('TODO'), nl, nl.
