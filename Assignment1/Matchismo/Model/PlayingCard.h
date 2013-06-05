//
//  PlayingCard.h
//  Matchismo
//
//  Created by Zhia Hwa Chong on 6/2/13.
//  Copyright (c) 2013 Zhia Hwa Chong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface PlayingCard : Card

@property(strong, nonatomic) NSString *suit;

//total of 14
@property(nonatomic) NSUInteger rank; //NSUInteger == unsigned long

//class method
+(NSArray *)validSuits;

//returns an array from ?, A to K
+(NSArray *)rankStrings;

//returns 13 (14 - 1)
+(NSUInteger)maxRank;
@end
