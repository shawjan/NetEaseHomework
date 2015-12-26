//
//  PathView.m
//  DropIt
//
//  Created by shawjan on 15/12/20.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "PathView.h"

@implementation PathView

-(void)setPath:(UIBezierPath *)path
{
    _path = path;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.path stroke];
}


@end
