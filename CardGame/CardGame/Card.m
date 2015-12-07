//
//  Card.m
//  CardGame
//
//  Created by shawjan on 15/12/6.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)matchedOrNot:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards) {
        if([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    
    return score;
}

@end
