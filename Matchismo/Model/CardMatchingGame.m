//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Zhia Hwa Chong on 6/3/13.
//  Copyright (c) 2013 Zhia Hwa Chong. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()
@property(strong, nonatomic)NSString* results;
@property(readwrite, nonatomic)int score; //for readability, add readwrite because its public is readonly
@property(strong, nonatomic)NSMutableArray *cards; //of Card
@end

@implementation CardMatchingGame

-(NSString *)results
{
    if (!_results) _results = [[NSString alloc]init];
    return _results;
}

-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self)
    {
        for (int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            //make sure you can draw a card from the deck
            //else return nil
            if (card)
                self.cards[i] = card;
            else
            {
                self = nil;
                break;
            }
        }
    }
    return self;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

//TODO
//implement 2 card and 3 card checking

-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (card && !card.isUnplayable)
    {
        if (!card.isFaceUp){
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isFaceUp && !otherCard.isUnplayable){
                    int matchScore = [card match:@[otherCard]];
                    
                    if (matchScore)
                    {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.results = [NSString stringWithFormat:@"Matched %@ and %@  for %d points!", card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                    } else {
                        otherCard.faceUp = NO;
                        self.results = [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty!", card.contents, otherCard.contents, MISMATCH_PENALTY];
                        self.score -= MISMATCH_PENALTY;
                    }
                    break;
                } else {
                    self.results = [NSString stringWithFormat:@"Flipped up %@", card.contents];
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}


-(void)twoCardFlipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    Card *secondCard = nil;
    Card *thirdCard = nil;
    
    if (card && !card.isUnplayable)
    {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isFaceUp && !otherCard.isUnplayable){
                    if (!secondCard)
                        secondCard = otherCard;
                    else if (!thirdCard)
                        thirdCard = otherCard;
                    
                    if (secondCard && thirdCard)
                    {
                        int matchScore = [card match:@[secondCard, thirdCard]];
                        NSLog(@"match score: %d", matchScore);
                        
                        if (matchScore)
                        {
                            card.unplayable = YES;
                            secondCard.unplayable = YES;
                            thirdCard.unplayable = YES;
                            
                            self.score += matchScore * MATCH_BONUS;
                            self.results = [NSString stringWithFormat:@"Matched %@, %@ and %@ for %d points!", card.contents, secondCard.contents, thirdCard.contents, matchScore * MATCH_BONUS];
                        } else {
                            secondCard.faceUp = NO;
                            thirdCard.faceUp = NO;
                            self.results = [NSString stringWithFormat:@"%@, %@ and %@ don't match! %d point penalty!", card.contents, secondCard.contents, thirdCard.contents, MISMATCH_PENALTY];
                            self.score -= MISMATCH_PENALTY;
                        }
                        
                        self.score -= FLIP_COST;
                    }
                }
            }
            if (!secondCard || !thirdCard)
                self.results = [NSString stringWithFormat:@"Flipped up %@", card.contents];
        }
        card.faceUp = !card.isFaceUp;
    }
}

-(void)threeCardFlipCardAtIndex:(NSUInteger)index
{
    
}

-(NSString*)flipCardResults
{
    return ([self.results  isEqualToString:@""]) ? @"Flipped Results":self.results;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

@end

