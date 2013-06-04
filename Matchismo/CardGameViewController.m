//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Zhia Hwa Chong on 5/30/13.
//  Copyright (c) 2013 Zhia Hwa Chong. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *flippedResults;

//@property (strong, nonatomic) Deck *deckOfCards; //instead of PlayingCardDeck because Deck is more generic
@property(strong, nonatomic) CardMatchingGame *game;
@end


@implementation CardGameViewController

-(CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[[PlayingCardDeck alloc]init]];
    return _game;
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
    
    /*
    for (UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.deckOfCards drawRandomCard];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
    }
    */ //not needed anymore
}

//makes UI look like the model
-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:
                      [self.cardButtons indexOfObject:cardButton]];        
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        self.score.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        
        UIImage *cardBackImage = [UIImage imageNamed:@"pokercard"];
        UIImage *transparentImage = [[UIImage alloc]init];
        
        [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        
        [cardButton setImage:transparentImage forState:UIControlStateSelected];

        [cardButton setImage:transparentImage forState:UIControlStateSelected|UIControlStateDisabled];
    }
}

- (IBAction)dealCards {
    self.game = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc]init]];
    self.flipCount = 0;
    self.flippedResults.text = [NSString stringWithFormat:@"Flipped Results"];
    [self updateUI];
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flip count: %d", flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    self.flippedResults.text = [self.game flipCardResults];
    
    [self updateUI];
}


@end
