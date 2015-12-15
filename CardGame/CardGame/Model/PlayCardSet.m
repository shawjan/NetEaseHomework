//
//  PlayCardSet.m
//  CardGame
//
//  Created by shawjan on 15/12/12.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "PlayCardSet.h"
#import "PlayingCardSet.h"

@implementation PlayCardSet

-(instancetype)init
{
    self = [super init];
    if(self){
        for(int i = 0; i < [[PlayingCardSet validColor] count]; ++i){
            for(int j = 0; j < [[PlayingCardSet validRank] count]; ++j){
                for(int k = 0; k < [[PlayingCardSet validShape] count]; ++k){
                    @autoreleasepool {
                        PlayingCardSet *card = [[PlayingCardSet alloc] init];
                        card.color = [PlayingCardSet validColor][i];
                        card.rank = [PlayingCardSet validRank][j];
                        card.shape = [PlayingCardSet validShape][k];
                        [self addCard:card];
                    }
                }
            }
        }
        
    }
    return self;
}

@end
