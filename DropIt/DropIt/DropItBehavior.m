//
//  DropItBehavior.m
//  DropIt
//
//  Created by shawjan on 15/12/18.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "DropItBehavior.h"

@interface DropItBehavior()

@property(nonatomic, strong) UIGravityBehavior *gravity;
@property(nonatomic, strong) UICollisionBehavior *collision;

@end


@implementation DropItBehavior

-(UIGravityBehavior *)gravity
{
    if(!_gravity){
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.gravityDirection = CGVectorMake(0.0, 0.9);
    }
    return _gravity;
}

-(UICollisionBehavior *)collision
{
    if(!_collision){
        _collision = [[UICollisionBehavior alloc] init];
        _collision.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collision;
}

-(instancetype)init
{
    self = [super init];
    if(self){
        [self addChildBehavior:self.gravity];
        [self addChildBehavior:self.collision];
    }
    return self;
}

- (void)addItem:(id <UIDynamicItem>)item
{
    [self.gravity addItem:item];
    [self.collision addItem:item];
}

- (void)removeItem:(id <UIDynamicItem>)item
{
    [self.gravity removeItem:item];
    [self.collision removeItem:item];
}

//-(void)addItem:(id <UIDynamicItem>)item
//{
//    
//}
//
//
//-(void)removeItem:(id<UIDynamicItem>)item
//{
//    
//}

@end
