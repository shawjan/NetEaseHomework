 //
//  CardGameViewController.m
//  CardGame
//
//  Created by shawjan on 15/12/7.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "CardGameViewController.h"
#import "HistoryViewController.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *CardButtons;

@end

@implementation CardGameViewController


/*
- (IBAction)historyStatesSliderValueChange:(UISlider *)sender {
    NSInteger historyStep = sender.value;
    if(historyStep < [self.game.history count]){
        self.tipsLab.text = [NSString stringWithFormat:@"The %ld step: \n  %@", historyStep + 1, self.game.history[historyStep]];
    }else{
        self.tipsLab.text = tips;
    }
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CardButton:(UIButton *)sender
{
    [self updateUI];
}

- (void)resetGameButton:(UIBarButtonItem *)sender {
    self.card = nil;
    self.game = nil;
    [self updateUI];
}



-(UIButton*)setButtonTitle:(UIButton*)button withCard:(Card*)card
{
    
    return button;
}

- (void)updateUI
{
   // self.historySlider.value = self.historySlider.maximumValue = [self.game.history count];
    self.scoreLab.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"DeckGameHistory"] || [segue.identifier isEqualToString:@"SetGameHistory"]){
        HistoryViewController *hisViewCon = (HistoryViewController*)segue.destinationViewController;
        hisViewCon.history = self.game.history;
        hisViewCon.highestRecord = self.highestScore.integerValue;
        hisViewCon.lowestRecord = self.lowestScore.integerValue;
        hisViewCon.title = segue.identifier;
    }
}


@end
