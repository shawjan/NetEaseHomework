//
//  CardGameViewController.m
//  CardGame
//
//  Created by shawjan on 15/12/7.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "CardGameViewController.h"

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)CardButton:(UIButton *)sender {
    self.cardChooseSegment.enabled = NO;
    NSUInteger index = [self.cardButtonsArray indexOfObject:sender];
    //[self.game chosenAtIndex:index];
    [self.game chosenAtIndex:index cardsMatchCount:self.cardChooseSegment.selectedSegmentIndex ? 3 : 2];
    [self updateUI];
}

- (IBAction)resetGameButton:(UIBarButtonItem *)sender {
    self.card = nil;
    self.game = nil;
    self.cardChooseSegment.enabled = YES;
    [self updateUI];
}


- (void)updateUI
{
   // self.historySlider.value = self.historySlider.maximumValue = [self.game.history count];
    //self.tipsLab.text = tips;
    for(int i = 0; i < [self.cardButtonsArray count]; ++i){
        Card * card = [self.game cardAtIndex:i];
        UIButton *btn = [self.cardButtonsArray objectAtIndex:i];
        if(card.chosen){
            [btn setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                           forState:UIControlStateNormal];
            [btn setTitle:card.contents forState:UIControlStateNormal];
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"cardback"]
                           forState:UIControlStateNormal];
            [btn setTitle:@"" forState:UIControlStateNormal];
        }
        if(card.matched){
            btn.enabled = NO;
        }else{
            btn.enabled = YES;
        }
    }
    self.scoreLab.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"CardGameHistory"]){
        
    }
}


@end
