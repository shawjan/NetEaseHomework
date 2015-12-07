//
//  PlayCardDeck.m
//  CardGame
//
//  Created by shawjan on 15/12/6.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "PlayCardDeck.h"
#import "PlayingCard.h"

@implementation PlayCardDeck

-(instancetype)init
{
    self = [super init];
    if(self){
        for(NSString *suit in [PlayingCard validSuit]){
            for(NSUInteger i = 1; i <= [PlayingCard maxRank]; ++i){
                @autoreleasepool {
                    PlayingCard *card = [[PlayingCard alloc] init];
                    card.suit = suit;
                    card.rank = i;
                    [self addCard:card];
                }
            }
        }
    }
    return self;
}

@end
