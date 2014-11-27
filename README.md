Clue Finder
===========
A Clue assistant for CPSC312, Project 2. The Clue Finder will keep track of gameplay, 
memorize facts that can be inferred from suggestions and responses, and provide hints 
toward gameplay on demand.

Usage
-----------
- To run in SWI-Prolog, set the working directory to the directory of the clue-finder folder
to insure that additional files are imported correctly, using the following command:
  ````
  working_directory(CWD, '<PATH TO CLUE-FINDER DIRECTORY>').
  ````
  
- Load the main command-line-interface file into Prolog:
  ````
  consult('cli.pl').
  ````
  
- Start the clue assistant by typing play.
  play.
  
- Just follow the prompts of the program!

Features
-----------
The Clue Finder may be immensely helpful during a game of Clue, but it has its limits! It can do the following:

- Infer knowledge of whether players hold or don't hold cards based on what cards are shown or not shown to you after your suggestion.
- Infer knowledge from the number of cards shown to other players.
- Keep a readily accessible database of information, including names of cards, what cards are held, not held, 
and confirmed to be in the envelope.
- Give a hint on which cards to accuse if enough information is available.
- Give hints on what to suggest next in order to get more evidence for making an accusation.
- End the game after a successful or failed accusation.
- Provide an easy-to-understand command line interface to interact with the fact database.

Some things it cant do:

- Magically know the other players' hands!
- Devise methods to prevent the other players from winning.
- Keep track of the rooms that players are in.

How it works
-----------
The Clue Finder learns facts about whether cards are held or not held by players in two different ways:
- direct interpretation from another player showing you or not showing you a card
- inference from previous facts using a set of pre-defined logical rules

Inferrences work by combining facts such as knowing that a player holds at least one out of three cards, 
and that the same player doesn't hold two cards, to deduce that the player holds the remaining card. Many of 
the logical rules are similar in structure. The suggestions hint system chooses the next best suggestion based 
on how likely it is to learn concrete facts (a player holds or does not hold a specific card for certain) from 
the suggestion. All logical rules are located in the logic.pl file.



