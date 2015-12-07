//
//  Deck.h
//  CardGame
//
//  Created by shawjan on 15/12/6.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)isTop;
-(void)addCard:(Card *)card;

-(Card*)drawRandomCard;
-(NSUInteger)remaindCards;
@end
