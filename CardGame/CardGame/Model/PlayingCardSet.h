//
//  PlayingCardSet.h
//  CardGame
//
//  Created by shawjan on 15/12/12.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "Card.h"
#import <UIKit/UIKit.h>

@interface PlayingCardSet : Card

@property(nonatomic, strong) NSString *shape;
@property(nonatomic, strong) NSString *color;
@property(nonatomic, strong) NSString *rank;

+(NSArray *)validColor;
+(NSArray *)validRank;
+(NSArray *)validShape;

@end
