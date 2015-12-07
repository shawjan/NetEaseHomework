//
//  CardMatchingGame.m
//  CardGame
//
//  Created by shawjan on 15/12/7.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Card.h"

@interface CardMatchingGame ()
@property(nonatomic, readwrite) NSInteger score;
@property(nonatomic, strong) NSMutableArray *cardsMutArr;

@end

@implementation CardMatchingGame

-(NSMutableArray *)cardsMutArr
{
    if (!_cardsMutArr) {
        _cardsMutArr = [[NSMutableArray alloc] init];
    }
    return _cardsMutArr;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if(self){
        for(int i = 0; i < count; ++i){
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cardsMutArr addObject:card];
            }else{
                self = nil;
                break;
            }
        }
    }
    return self;
}

-(void)chosenAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if(!card.matched){
        if(card.chosen){
            card.chosen = NO;
        }else{
            for (int i = 0; i < [self.cardsMutArr count]; ++i) {
                Card *otherCard = self.cardsMutArr[i];
                if(otherCard.chosen && !otherCard.matched){
                    NSInteger matchScore = [card matchedOrNot:@[otherCard]];
                    if(matchScore){
                        self.score += matchScore;
                        card.matched = YES;
                        otherCard.matched = YES;
                    }else{
                        otherCard.chosen = NO;
                        card.chosen = NO;
                    }
                    break;
                }
            }
        }
    }
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cardsMutArr count]) ? self.cardsMutArr[index] : nil;
}

@end
