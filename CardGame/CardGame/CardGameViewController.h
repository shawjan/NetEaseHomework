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
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) UILabel *scoreLab;
@property(nonatomic, readwrite) NSNumber *highestScore;
@property(nonatomic, readwrite) NSNumber *lowestScore;

- (void)CardButton:(UIButton *)sender;
- (void)resetGameButton:(UIBarButtonItem *)sender;
-(UIButton*)setButtonTitle:(UIButton*)button withCard:(Card*)card;
-(void) updateUI;
@end
