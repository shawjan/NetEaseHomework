//
//  CardDeckMatchingGame.m
//  CardGame
//
//  Created by shawjan on 15/12/12.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "CardDeckMatchingGame.h"

@implementation CardDeckMatchingGame

-(NSString*)historyContent:(Card*)card withCards:(NSArray*)cards matchScore:(NSInteger)matchScore
{
    NSString *hisStr = [NSString stringWithFormat:@"%@ %@", card.contents, matchScore > 0 ? @"matched " : @"didn't match "];
    for(Card *card in cards){
        hisStr = [hisStr stringByAppendingString:[NSString stringWithFormat:@"%@ ", card.contents]];
    }
    hisStr = [hisStr stringByAppendingString:[NSString stringWithFormat:@"for %ld point(s)", matchScore]];
    return hisStr;
}

@end
