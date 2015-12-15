//
//  PlayingCardSet.m
//  CardGame
//
//  Created by shawjan on 15/12/12.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "PlayingCardSet.h"

@implementation PlayingCardSet

static NSString *const Red = @"redColor";
static NSString *const Green = @"greenColor";
static NSString *const Blue = @"blueColor";
-(NSString *)contents
{
    return nil;
}

+(NSArray *)validColor
{
    return @[Red, Green, Blue];
}

+(NSArray *)validRank
{
    return @[@"1", @"2", @"3"];
}

+(NSArray *)validShape
{
    return @[@"▲", @"◼︎", @"●"];
}

static const NSInteger CardSetProperties = 3;
-(int)matchedOrNot:(NSArray *)otherCards
{
    int score = 5;
    for (int i = 0; i < CardSetProperties; ++i) {
        int matchResult = 0;
        for (PlayingCardSet *cardSet in otherCards) {
            if([cardSet isKindOfClass:[self class]]){
                int move;
                if(0 == CardSetProperties){
                    move = [[PlayingCardSet validColor] indexOfObject:self.color];
                }else if(1 == CardSetProperties){
                    move = [[PlayingCardSet validRank] indexOfObject:self.rank];
                }else if (2 == CardSetProperties){
                    move = [[PlayingCardSet validShape] indexOfObject:self.shape];
                }
                matchResult |= 1 << move;
            }
        }
        if(!(matchResult == 1 || matchResult == 2 || matchResult == 4 || matchResult == 7)){
            score = 0;
            break;
        }
    }
    return score;
}

@end
