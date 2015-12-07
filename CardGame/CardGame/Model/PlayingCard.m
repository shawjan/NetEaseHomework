//
//  PlayingCard.m
//  CardGame
//
//  Created by shawjan on 15/12/6.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit = _suit;
-(void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuit] containsObject:suit]){
        _suit = suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

-(void)setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

+(NSArray *)validSuit
{
    return @[@"♣︎", @"♥︎", @"♠︎", @"♦︎"];
}

+(NSArray*)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"K", @"Q"];
}

+(NSUInteger)maxRank
{
    return [[PlayingCard rankStrings] count] - 1;
}

-(NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [self.suit stringByAppendingString:rankStrings[self.rank]];
}

@end
