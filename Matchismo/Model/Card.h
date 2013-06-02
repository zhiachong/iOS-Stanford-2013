//
//  Card.h
//  Matchismo
//
//  Created by Zhia Hwa Chong on 6/2/13.
//  Copyright (c) 2013 Zhia Hwa Chong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property(strong, nonatomic)NSString *contents;

@property(nonatomic, getter=isFaceUp) BOOL faceUp; //changes name of getter
@property(nonatomic, getter=isUnplayable) BOOL unplayable;


-(int)match:(Card *)card;
@end
