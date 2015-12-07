//
//  Deck.m
//  CardGame
//
//  Created by shawjan on 15/12/6.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "Deck.h"

@interface Deck ()

@property(nonatomic, strong) NSMutableArray *cardMutArray;

@end

@implementation Deck

-(NSMutableArray *)cardMutArray
{
    if(!_cardMutArray){
        _cardMutArray = [[NSMutableArray alloc] init];
    }
    return _cardMutArray;
}

-(void)addCard:(Card *)card atTop:(BOOL)isTop
{
    if(isTop){
        [self.cardMutArray insertObject:card atIndex:0];
    }else{
        [self.cardMutArray addObject:card];
    }
}

-(void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

-(Card *)drawRandomCard
{
    Card *randomCard = nil;
    if([self.cardMutArray count]){
        int index = arc4random() % [self.cardMutArray count];
        randomCard = self.cardMutArray[index];
        [self.cardMutArray removeObjectAtIndex:index];
    }
    return randomCard;
}

-(NSUInteger)remaindCards
{
    return [self.cardMutArray count];
}
@end
