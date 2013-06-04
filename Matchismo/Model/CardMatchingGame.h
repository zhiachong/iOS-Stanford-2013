//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Zhia Hwa Chong on 6/3/13.
//  Copyright (c) 2013 Zhia Hwa Chong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck *)deck;

-(void)flipCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

-(NSString*)flipCardResults;

//readonly means only a getter, no setters
@property (readonly, nonatomic)int score;

@end
