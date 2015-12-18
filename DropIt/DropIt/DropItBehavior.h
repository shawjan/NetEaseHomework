//
//  DropItBehavior.h
//  DropIt
//
//  Created by shawjan on 15/12/18.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropItBehavior : UIDynamicBehavior

- (void)addItem:(id <UIDynamicItem>)item;
- (void)removeItem:(id <UIDynamicItem>)item;

@end
