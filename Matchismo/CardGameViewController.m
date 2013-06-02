//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Zhia Hwa Chong on 5/30/13.
//  Copyright (c) 2013 Zhia Hwa Chong. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) PlayingCardDeck *deckOfCards;
@end


@implementation CardGameViewController

-(PlayingCardDeck *)deckOfCards
{
    _deckOfCards = [[PlayingCardDeck alloc]init];
    return _deckOfCards;
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flip count: %d", flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [sender setTitle:self.deckOfCards.drawRandomCard.contents forState:UIControlStateSelected];
    self.flipCount++;
}


@end
