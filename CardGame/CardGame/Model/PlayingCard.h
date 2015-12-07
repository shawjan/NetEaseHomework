//
//  PlayingCard.h
//  CardGame
//
//  Created by shawjan on 15/12/6.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property(nonatomic, strong) NSString *suit;
@property(nonatomic) NSUInteger rank;

+(NSArray*)validSuit;
+(NSUInteger)maxRank;

@end
