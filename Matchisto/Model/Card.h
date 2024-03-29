//
//  Card.h
//  Matchisto
//
//  Created by Bart Van der Avort on 27/01/13.
//  Copyright (c) 2013 Bart Van der Avort. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;


@end
