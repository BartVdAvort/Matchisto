//
//  CardMatchingGame.m
//  Matchisto
//
//  Created by Bart Van der Avort on 2/02/13.
//  Copyright (c) 2013 Bart Van der Avort. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong,nonatomic) NSMutableArray *cards;
@property (readwrite,nonatomic) int score;
@property (readwrite,nonatomic) NSString *matchDescription;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0;i < count;i++) {
            Card *card = [deck drawRandomCard];
            if (!card){
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isUnplayable) {
        if (!card.isFaceUp){
            for (Card *otherCard in self.cards){
                if (otherCard.isFaceUp && !otherCard.isUnplayable){
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore){
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.matchDescription = [NSString stringWithFormat:@"Matched %@ and %@ for %d points!", card.contents,otherCard.contents,matchScore * MATCH_BONUS];
                    } else {
                        self.matchDescription = [NSString stringWithFormat:@" %@ and %@ do not match! %d points penalty.", card.contents, otherCard.contents, MISMATCH_PENALTY];
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                    break;
                }
                self.matchDescription = [NSString stringWithFormat:@"%@ is flipped.",card.contents];
            }
            self.score -= FLIP_COST;
            self.flips += FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}
@end
