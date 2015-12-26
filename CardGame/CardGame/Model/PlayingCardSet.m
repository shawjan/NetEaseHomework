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
    return @[@"0", @"1", @"2"];
}

+(NSArray *)validRank
{
    return @[@"1", @"2", @"3"];
}

+(NSArray *)validShape
{
    return @[@"▲", @"◼︎", @"●"];
}

+(UIColor *)getColor:(NSString *)color
{
    UIColor *fontColor = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]][color.intValue];
    return fontColor;
}

+(NSAttributedString*)getContents:(Card*)card
{
    NSAttributedString *attributedString = nil;
    if([card isKindOfClass:[PlayingCardSet class]]){
        PlayingCardSet *cardSet = (PlayingCardSet*)card;
        NSString *str = @"";
        for(int i = 0; i < cardSet.rank.intValue; ++i){
            str = [str stringByAppendingString:cardSet.shape];
        }
        UIColor *color = [PlayingCardSet getColor:cardSet.color];
        attributedString = [[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:color}];
    }
    return attributedString;
}

static const NSInteger CardSetProperties = 3;
-(int)matchedOrNot:(NSArray *)otherCards
{
    int score = 5;
    NSMutableArray *cards = [NSMutableArray arrayWithArray:otherCards];
    [cards addObject:self];
    for (int i = 0; i < CardSetProperties; ++i) {
        int matchResult = 0;
        for (PlayingCardSet *cardSet in cards) {
            if([cardSet isKindOfClass:[self class]]){
                NSUInteger move;
                if(0 == i){
                    move = [[PlayingCardSet validColor] indexOfObject:cardSet.color];
                }else if(1 == i){
                    move = [[PlayingCardSet validRank] indexOfObject:cardSet.rank];
                }else if (2 == i){
                    move = [[PlayingCardSet validShape] indexOfObject:cardSet.shape];
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
