//
//  Card.h
//  CardGame
//
//  Created by shawjan on 15/12/6.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property(nonatomic, strong) NSString *contents;

@property(nonatomic) BOOL chosen;
@property(nonatomic) BOOL matched;

-(int)matchedOrNot:(NSArray*)otherCards;

@end
