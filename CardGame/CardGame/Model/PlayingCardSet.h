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

@property(nonatomic, assign) NSString *shape;
@property(nonatomic, assign) NSString *color;
@property(nonatomic, assign) NSString *rank;

+(NSArray *)validColor;
+(NSArray *)validRank;
+(NSArray *)validShape;

+(UIColor*)getColor:(NSString*)color;
+(NSAttributedString*)getContents:(Card*)card;
@end
