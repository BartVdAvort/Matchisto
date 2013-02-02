//
//  Deck.h
//  Matchisto
//
//  Created by Bart Van der Avort on 27/01/13.
//  Copyright (c) 2013 Bart Van der Avort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
