//
//  CardMatchingGame.h
//  CardGame
//
//  Created by shawjan on 15/12/7.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property(nonatomic, readonly) NSInteger score;

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck*)deck;

-(void)chosenAtIndex:(NSUInteger)index;
-(void)chosenAtIndex:(NSUInteger)index cardsMatchCount:(NSUInteger)count;
-(Card*)cardAtIndex:(NSUInteger)index;


@end
