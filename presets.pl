weapon(knife).

loadOldVersion :-
    % load preset weapons
    weapon(knife),
    weapon(candlestick),
    weapon(revolver),
    weapon(rope),
    weapon('lead pipe'),
    weapon(wrench),
    exists(knife),
    assertz(exists(candlestick)),
    assertz(exists(revolver)),
    assertz(exists(rope)),
    assertz(exists('lead pipe')),
    assertz(exists(wrench)),

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
    assertz(exists(kitchen)),
    assertz(exists(ballroom)),
    assertz(exists(conservatory)),
    assertz(exists('billiard room')),
    assertz(exists(library)),
    assertz(exists(study)),
    assertz(exists(hall)),
    assertz(exists(lounge)),
    assertz(exists('dining room')),

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
    assertz(exists(knife)),
    assertz(exists(candlestick)),
    assertz(exists(pistol)),
    assertz(exists(rope)),
    assertz(exists(bat)),
    assertz(exists(axe)),

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
    assertz(exists(kitchen)),
    assertz(exists(patio)),
    assertz(exists(spa)),
    assertz(exists(theatre)),
    assertz(exists('living room')),
    assertz(exists(observatory)),
    assertz(exists(hall)),
    assertz(exists('guest house')),
    assertz(exists('dining room')),


    % load preset suspects
    loadDefaultSuspects.

loadDefaultSuspects :-
    assertz(suspect('Colonel Mustard')),
    assertz(suspect('Miss Scarlet')),
    assertz(suspect('Professor Plum')),
    assertz(suspect('Mr. Green')),
    assertz(suspect('Mrs. White')),
    assertz(suspect('Mrs. Peacock')),
    assertz(exists('Colonel Mustard')),
    assertz(exists('Miss Scarlet')),
    assertz(exists('Professor Plum')),
    assertz(exists('Mr. Green')),
    assertz(exists('Mrs. White')),
    assertz(exists('Mrs. Peacock')).