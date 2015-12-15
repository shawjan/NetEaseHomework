//
//  CardSetMatchingGame.m
//  CardGame
//
//  Created by shawjan on 15/12/12.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "CardSetMatchingGame.h"

@implementation CardSetMatchingGame

-(NSString*)historyContent:(Card*)card withCards:(NSArray*)cards matchScore:(NSInteger)matchScore
{
    NSString *hisStr = [NSString stringWithFormat:@"%@ for %ld point(s)", matchScore > 0 ? @"matched " : @"didn't match ", matchScore];
    return hisStr;
}

@end
