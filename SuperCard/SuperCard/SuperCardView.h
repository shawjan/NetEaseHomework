//
//  SuperCardView.h
//  SuperCard
//
//  Created by shawjan on 15/12/14.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperCardView : UIView

@property(nonatomic, assign) NSInteger rank;
@property(nonatomic, strong) NSString *suit;
@property(nonatomic,  assign) BOOL faceUp;

-(void)pinchAction:(UIPinchGestureRecognizer*)pinchGesture;
-(NSString*)rankAsString;
@end
