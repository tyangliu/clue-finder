:-  module(presets,[loadOldVersion/0, loadNewVersion/0]). 

loadOldVersion :-
    assert(weapon(knife)),
    assert(weapon(candlestick)),
    assert(weapon(revolver)),
    assert(weapon(rope)),
    assert(weapon('lead pipe')),
    assert(weapon(wrench)),

    assert(room(kitchen)),
    assert(room(ballroom)),
    assert(room(conservatory)),
    assert(room('billiard room')),
    assert(room(library)),
    assert(room(study)),
    assert(room(hall)),
    assert(room(lounge)),
    assert(room('dining room')),

    loadDefaultSuspects.

loadNewVersion :-
    assert(weapon(knife)),
    assert(weapon(candlestick)),
    assert(weapon(pistol)),
    assert(weapon(rope)),
    assert(weapon(bat)),
    assert(weapon(axe)),

    assert(room(kitchen)),
    assert(room(patio)),
    assert(room(spa)),
    assert(room(theatre)),
    assert(room('living room')),
    assert(room(observatory)),
    assert(room(hall)),
    assert(room('guest house')),
    assert(room('dining room')),

    loadDefaultSuspects.

loadDefaultSuspects :-
    assert(suspect('Colonel Mustard')),
    assert(suspect('Miss Scarlet')),
    assert(suspect('Professor Plum')),
    assert(suspect('Mr. Green')),
    assert(suspect('Mrs. White')),
    assert(suspect('Mrs. Peacock')).