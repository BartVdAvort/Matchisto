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
    self.gameMode = 2;
    return self;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck withGameLevel:(NSUInteger)gameLevel
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
    self.gameMode = gameLevel;
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
 
    //to be implemented:
    // 1. Collect all Faceup Playable Cards.
    // 2. If the GameMode and the number of FaceupPlayableCards match, we can start matching cards
    
    
    Card *card = [self cardAtIndex:index];
    // create array for other playable cards in cards
    NSMutableArray *faceupPlayableCards = [[NSMutableArray alloc] init];
    card.faceUp = !card.isFaceUp;
    
    if (card && !card.isUnplayable){
        if (card.isFaceUp){
            for (Card *otherCard in self.cards){
                if ([faceupPlayableCards count] < self.gameMode - 1){
                    if (!otherCard.isUnplayable && otherCard.isFaceUp){
                        [faceupPlayableCards addObject:otherCard];
                    }//endif othercard is faceup & playable
                } //endif maxcount
            } //endfor
            NSLog(@"Done adding cards, there ary %d cards in faceupplayable cards.", [faceupPlayableCards count]);
            NSLOG(@"Cards in faceup are: %@", [faceupPlayableCards componentsJoinedByString:<#(NSString *)#>)
        } //endif card isfaceup
    } // endif card playable
 
    
    // matching logic goes here
    // we only start matching if there are cards turned up and playable and there are sufficient number of cards in the array.
    if (faceupPlayableCards && [faceupPlayableCards count] == self.gameMode - 1){ //faceupplayable cards contains 1 or 2 cards to compare with
        NSLog(@"Matching logic started. Gamemode is %d",self.gameMode);
        if (!card.isUnplayable && card.isFaceUp) {
            int matchScore = [card match:faceupPlayableCards];
            if (matchScore){
                for (Card *faceupPlayableCard in faceupPlayableCards){
                    faceupPlayableCard.unplayable = YES;
                }
            card.unplayable = YES;
            self.score =+ matchScore * MATCH_BONUS / self.gameMode;
            } else {
                for (Card *faceupPlayableCard in faceupPlayableCards){
                    faceupPlayableCard.unplayable = NO;
                    self.score -= MISMATCH_PENALTY;
                }
            }
        }
    }
    NSLog(@"matching logic not implemented yet");
//    if (card.faceUp){
//        
//    // 4. we iterate through every card and if it is faceup we add it to the faceup array
//        for (Card *otherCard in self.cards){
//            if (otherCard.isFaceUp &&  !otherCard.isUnplayable){
//                if([faceupCards count] <= self.maxNumberOfMatches){
//                [faceupCards addObject:otherCard];
//                }
//            }
//        }
//    }
//}
//    if (!card.isUnplayable) {
//        if (!card.isFaceUp){
//            for (Card *otherCard in self.cards){
//                if (otherCard.isFaceUp && !otherCard.isUnplayable){
//                    int matchScore = [card match:@[otherCard]];
//                    if (matchScore){
//                        otherCard.unplayable = YES;
//                        card.unplayable = YES;
//                        self.score += matchScore * MATCH_BONUS;
//                        self.matchDescription = [NSString stringWithFormat:@"Matched %@ and %@ for %d points!", card.contents,otherCard.contents,matchScore * MATCH_BONUS];
//                    } else {
//                        self.matchDescription = [NSString stringWithFormat:@" %@ and %@ do not match! %d points penalty.", card.contents, otherCard.contents, MISMATCH_PENALTY];
//                        otherCard.faceUp = NO;
//                        self.score -= MISMATCH_PENALTY;
//                    }
//                    break;
//                }
//                self.matchDescription = [NSString stringWithFormat:@"%@ is flipped.",card.contents];
//            }
//            self.score -= FLIP_COST;
//            self.flips += FLIP_COST;
//        }
//        card.faceUp = !card.isFaceUp;
//    }
}
@end
