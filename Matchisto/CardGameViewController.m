//
//  CardGameViewController.m
//  Matchisto
//
//  Created by Bart Van der Avort on 27/01/13.
//  Copyright (c) 2013 Bart Van der Avort. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchLevel;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[[PlayingCardDeck alloc] init]
                                                      withGameLevel: self.matchLevel.selectedSegmentIndex + 2];
        
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled] ;
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.descriptionLabel.text = self.game.matchDescription;
    self.flipCount = self.game.flips;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.matchLevel setEnabled:NO]; // disable UISegmentedControl if card is flipped
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [self updateUI];
}
- (IBAction)changeMode:(UISegmentedControl *)sender {
    if (sender.isEnabled){
        self.game.gameMode = sender.selectedSegmentIndex + 2;
        NSLog(@"gamemode changed to %d", self.game.gameMode);
    }
}

- (IBAction)dealCards:(UIButton *)sender
{
    self.matchLevel.enabled = YES;
    self.game = nil;
    [self updateUI];
}
@end
