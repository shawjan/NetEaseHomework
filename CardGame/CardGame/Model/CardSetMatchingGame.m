//
//  CardSetMatchingGame.m
//  CardGame
//
//  Created by shawjan on 15/12/12.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "CardSetMatchingGame.h"
#import "PlayingCardSet.h"

@implementation CardSetMatchingGame

-(id)historyContent:(Card*)card withCards:(NSArray*)cards matchScore:(NSInteger)matchScore
{
    NSMutableAttributedString *hisStr = [[PlayingCardSet getContents:card] mutableCopy];
    NSDictionary *dic = @{NSForegroundColorAttributeName: [UIColor blackColor]};
    NSAttributedString *tmpStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",matchScore > 0 ? @"matched " : @"didn't match "]  attributes:dic];
    [hisStr appendAttributedString:tmpStr];
    NSAttributedString *joinStr = [[NSAttributedString alloc] initWithString:@"," attributes:nil];
    for(Card *card in cards){
        [hisStr appendAttributedString:[PlayingCardSet getContents:card]];
        [hisStr appendAttributedString:joinStr];
    }
    tmpStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"for %ld point(s)", matchScore] attributes:dic];
    [hisStr appendAttributedString:tmpStr];
    return hisStr;
}

@end
