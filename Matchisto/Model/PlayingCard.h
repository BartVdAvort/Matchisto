//
//  PlayingCard.h
//  Matchisto
//
//  Created by Bart Van der Avort on 31/01/13.
//  Copyright (c) 2013 Bart Van der Avort. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

    @property (strong, nonatomic) NSString *suit;
    @property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end
