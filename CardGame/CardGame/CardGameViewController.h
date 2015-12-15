//
//  CardGameViewController.h
//  CardGame
//
//  Created by shawjan on 15/12/7.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController
@property (nonatomic, strong) Deck *card;
@property (strong, nonatomic) NSArray *cardButtonsArray;
@property (weak, nonatomic) IBOutlet UILabel *tipsLab;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardChooseSegment;

- (IBAction)CardButton:(UIButton *)sender;
@end
