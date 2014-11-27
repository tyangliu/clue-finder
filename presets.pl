:-  module(presets,[loadOldVersion/0, loadNewVersion/0]). 

loadOldVersion :-
    % load preset weapons
    assertz(weapon(knife)),
    assertz(weapon(candlestick)),
    assertz(weapon(revolver)),
    assertz(weapon(rope)),
    assertz(weapon('lead pipe')),
    assertz(weapon(wrench)),

    % load preset rooms
    assertz(room(kitchen)),
    assertz(room(ballroom)),
    assertz(room(conservatory)),
    assertz(room('billiard room')),
    assertz(room(library)),
    assertz(room(study)),
    assertz(room(hall)),
    assertz(room(lounge)),
    assertz(room('dining room')),

    % load preset suspects
    loadDefaultSuspects.

loadNewVersion :-
    % load preset weapons
    assertz(weapon(knife)),
    assertz(weapon(candlestick)),
    assertz(weapon(pistol)),
    assertz(weapon(rope)),
    assertz(weapon(bat)),
    assertz(weapon(axe)),

    % load preset rooms
    assertz(room(kitchen)),
    assertz(room(patio)),
    assertz(room(spa)),
    assertz(room(theatre)),
    assertz(room('living room')),
    assertz(room(observatory)),
    assertz(room(hall)),
    assertz(room('guest house')),
    assertz(room('dining room')),

    % load preset suspects
    loadDefaultSuspects.

loadDefaultSuspects :-
    assertz(suspect('Colonel Mustard')),
    assertz(suspect('Miss Scarlet')),
    assertz(suspect('Professor Plum')),
    assertz(suspect('Mr. Green')),
    assertz(suspect('Mrs. White')),
    assertz(suspect('Mrs. Peacock')).