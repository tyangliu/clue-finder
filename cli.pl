:- use_module(presets,[loadOldVersion/0, loadNewVersion/0]). 
:- dynamic suspect/1.
:- dynamic room/1.
:- dynamic weapon/1.

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
    Version = o -> loadOldVersion;
    Version = n -> loadNewVersion;
    % ask user to set the cards of the game
    Version = c -> loadCards;
    % if version is not valid, run the prompt again
    write('Oops, that\'s not a valid version.'), getVersion.

% load the cards to be used for the game if user chooses 
% to load custom cards

loadCards :-
    % TODO!!!
    write('TODO'), nl, nl.

/*--------------------------------------------------
 *
 * Game initialization : set the number of players
 *
 *------------------------------------------------*/

 getNumPlayers :-
    write('How many players are there?'), nl, nl,
    read(NumPlayers),
    % TODO!!!
    write('TODO'), nl, nl.

/*--------------------------------------------------
 *
 * Game initialization : set the turn order
 *
 *------------------------------------------------*/

 getTurn :-
    write('Who\'s turn is it? TODO'), nl, nl,
    read(Turn),
    % TODO!!!
    write('TODO'), nl, nl.

/*--------------------------------------------------
 *
 * Game initialization : set the player's hand
 *
 *------------------------------------------------*/

 getPlayerHand :-
    write('-> Type a card name or \'f\' when you\'re finished:'), nl, nl,
    read(Card),
    % finished entering cards, move on
    Card = f -> true;
    % verify the card and remember it
    write('TODO'), nl, nl.
    % ask for another card

/*--------------------------------------------------
 *
 * Game duration
 *
 *------------------------------------------------*/

 game(Turn) :-
    write('TODO'), nl, nl.
