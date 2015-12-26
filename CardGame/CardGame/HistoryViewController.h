//
//  HistoryViewController.h
//  CardGame
//
//  Created by shawjan on 15/12/26.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController
@property(nonatomic, assign) NSInteger highestRecord;
@property(nonatomic, assign) NSInteger lowestRecord;
@property(nonatomic, strong) id history;
@end
