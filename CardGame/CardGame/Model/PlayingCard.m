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

-(int)matchedOrNot:(NSArray *)otherCards
{
    int suitScore = 0, rankScore = 0, score = 0;
    for(PlayingCard *card in otherCards){
        if([self.suit isEqualToString:card.suit]){
            suitScore += 1;
        }else if(self.rank == card.rank){
            rankScore += 1;
        }
    }
    if(suitScore == [otherCards count]){
        return suitScore * 1;
    }
    if(rankScore == [otherCards count]){
        return rankScore * 4;
    }
    return score;
}

@end
