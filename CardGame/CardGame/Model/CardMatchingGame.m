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
@property(nonatomic, assign) NSInteger chooseCardMatch;
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


static const NSInteger PunishScore = 5;
static const NSInteger Bonus = 2;
-(void)chosenAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if(!card.matched){
        if(card.chosen){
            card.chosen = NO;
        }else{
            NSMutableArray *otherCards = [NSMutableArray array];
            for (int i = 0; i < [self.cardsMutArr count]; ++i) {
                Card *otherCard = self.cardsMutArr[i];
                if(otherCard.chosen && !otherCard.matched){
                    [otherCards addObject:otherCard];
                }
            }
            if([otherCards count] + 1 == self.chooseCardMatch){
                NSInteger matchScore = [card matchedOrNot:otherCards];
                if(matchScore){
                    self.score += matchScore * Bonus;
                    card.matched = YES;
                    for (Card *otherCard in otherCards) {
                        otherCard.matched = YES;
                    }
                }else{
                    self.score -= PunishScore;
                    card.chosen = NO;
                    for(Card *otherCard in otherCards){
                        otherCard.chosen = NO;
                    }
                }
            }
            card.chosen = YES;
        }
    }
}

-(void)chosenAtIndex:(NSUInteger)index cardsMatchCount:(NSUInteger)count
{
    self.chooseCardMatch = count;
    [self chosenAtIndex:index];
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cardsMutArr count]) ? self.cardsMutArr[index] : nil;
}

@end
