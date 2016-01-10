//
//  RecordViewController.m
//  CardGame
//
//  Created by shawjan on 16/1/9.
//  Copyright © 2016年 shawjan. All rights reserved.
//

#import "RecordViewController.h"

@interface RecordViewController ()

@property (weak, nonatomic) IBOutlet UILabel *deckGameRecordLabel;

@property (weak, nonatomic) IBOutlet UILabel *setGameRecordLabel;

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSInteger heightScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"DeckCardGameHighestScore"];
    if (!heightScore) {
        self.deckGameRecordLabel.text = @"You haven't play the game!";
    }else{
        self.deckGameRecordLabel.text = [NSString stringWithFormat:@"Deck Game Height Record:%ld", heightScore];
    }
    heightScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"SetCardGameHighestScore"];
    if(!heightScore){
        self.setGameRecordLabel.text = @"You haven't play the game!";
    }else{
        self.setGameRecordLabel.text = [NSString stringWithFormat:@"Set Game Height Record:%ld", heightScore];
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
