//
//  Card.m
//  Matchismo
//
//  Created by Zhia Hwa Chong on 6/2/13.
//  Copyright (c) 2013 Zhia Hwa Chong. All rights reserved.
//

#import "Card.h"

@implementation Card
@synthesize contents = _contents;
@synthesize faceUp = _faceUp;
@synthesize unplayable = _unplayable;

-(int)match:(Card *)card
{
    int score = 0;
    
    if ([card.contents isEqualToString:self.contents])
        score = 1;        
    
    return score;
}

-(void)setContents:(NSString *)contents
{
    _contents = contents;
}

-(NSString *)contents
{
    return _contents;
}

-(BOOL)isUnplayable
{
    return _unplayable;
}

-(void)setUnplayable:(BOOL)unplayable
{
    _unplayable = unplayable;
}

-(BOOL)isFaceUp
{
    return _faceUp;
}

-(void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
}

@end
