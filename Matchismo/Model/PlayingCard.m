//
//  PlayingCard.m
//  Matchismo
//
//  Created by Zhia Hwa Chong on 6/2/13.
//  Copyright (c) 2013 Zhia Hwa Chong. All rights reserved.
//

#import "PlayingCard.h"
#import "Card.h"
@implementation PlayingCard
@synthesize suit = _suit;

-(int)match:(NSArray *)cards
{
    int score = 0; 
    if ([cards count] == 1) //EASY FOR MATCHING 1 card
    {
        //use lastObject because it will send nil if array is empty
        PlayingCard *card = [cards lastObject]; //cards objectAtIndex also work
        if ([card.suit isEqualToString:self.suit])
        {
            score = 1;
        } else if (card.rank == self.rank)
        {
            score = 4;
        }
    } else if ([cards count] == 2) //MEDIUM FOR MATCHING 2 cards
    {
        PlayingCard *lastCard = [cards lastObject]; //cards objectAtIndex also work
        
        PlayingCard *card = [cards objectAtIndex:[cards count] - 2];
        
        if ([card.suit isEqualToString:self.suit] && [card.suit isEqualToString:lastCard.suit])
        {
            score = 2;
        } else if (card.rank == self.rank && card.rank == lastCard.rank)
        {
            score = 8;
        }
    } else if ([cards count] == 3) //HARD FOR MATCHING 3 cards
    {
        PlayingCard *lastCard = [cards lastObject]; //cards objectAtIndex also work
        
        PlayingCard *secondLastcard = [cards objectAtIndex:[cards count] - 2];
        
        PlayingCard *card = [cards objectAtIndex:[cards count] - 3];
        
        if ([card.suit isEqualToString:self.suit] && [card.suit isEqualToString:lastCard.suit] && [lastCard.suit isEqualToString:secondLastcard.suit])
        {
            score = 4;
        } else if (card.rank == self.rank && card.rank == lastCard.rank && lastCard.rank == secondLastcard.rank)
        {
            score = 16;
        }
    }
    return score;
}

+(NSArray *)validSuits
{
    return @[@"♥", @"♠", @"♣", @"♦"];
}
+(NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3",@"4", @"5", @"6", @"7", @"8", @"9",@"10", @"J", @"Q", @"K"];
}
+(NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}
-(NSString*) contents
{
    
    return ([[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit]);
}

//suit setter
//makes sure no one sets an invalid suit
-(void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit; //since we provided both getter AND setter, we need to @synthesize suit
    }
}

//suit getter
//unless someone sets a rank, it will have a content of "??"
-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

-(void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
        _rank = rank;
}

@end
