//
//  CardMatchingGame.h
//  Matchisto
//
//  Created by Bart Van der Avort on 2/02/13.
//  Copyright (c) 2013 Bart Van der Avort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck; // designated initiator

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck
          withGameLevel:(NSUInteger)gameLevel;

- (void)flipCardAtIndex:(NSUInteger)index;
- (void)flipCardAtIndexNew:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic,readonly) int score;
@property (nonatomic) NSInteger gameMode;
@property (nonatomic) int flips;
@property (nonatomic, readonly) NSString *matchDescription;
@property (nonatomic, readonly) int flipcost;
@property (nonatomic) NSUInteger matchBonus;
@property (nonatomic) NSUInteger mismatchPenalty;
@end
