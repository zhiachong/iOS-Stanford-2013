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

typedef enum {one, two, three} GAMEMODE;

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *flippedResults;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property(nonatomic)GAMEMODE gameControl;
//@property (strong, nonatomic) Deck *deckOfCards; //instead of PlayingCardDeck because Deck is more generic
@property(strong, nonatomic) CardMatchingGame *game;
@end


@implementation CardGameViewController

- (IBAction)changeMode:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0)
    {
        NSLog(@"1-Card selected");
        self.gameControl = one;
    }
    else if (sender.selectedSegmentIndex == 1)
    {
        NSLog(@"2-Card selected");
        self.gameControl = two;
    } else if (sender.selectedSegmentIndex == 2)
    {
        NSLog(@"3-card selected");
        self.gameControl = three;
    }
}

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
        
        self.flippedResults.text = [self.game flipCardResults];
    }
}

- (IBAction)dealCards {
    self.game = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc]init]];
    self.flipCount = 0;
    self.segmentControl.enabled = YES;
    [self updateUI];
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flip count: %d", flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    if (self.gameControl == one)
        [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    else if (self.gameControl == two)
        [self.game twoCardFlipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    else if (self.gameControl == three)
        NSLog(@"three");
    
    self.flipCount++;
    self.segmentControl.enabled = NO;
    [self updateUI];
}


@end
