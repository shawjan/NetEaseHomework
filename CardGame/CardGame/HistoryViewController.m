//
//  HistoryViewController.m
//  CardGame
//
//  Created by shawjan on 15/12/26.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *highestRecordLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowestRecordLabel;
@property (weak, nonatomic) IBOutlet UITextView *HistoryTextView;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.highestRecordLabel.text = [NSString stringWithFormat:@"Highest Score: %ld", self.highestRecord];
    self.lowestRecordLabel.text = [NSString stringWithFormat:@"Lowest Score: %ld", self.lowestRecord];
    self.HistoryTextView.attributedText = [self getHistoryText];
}

-(NSAttributedString*)getHistoryText
{
    NSMutableAttributedString *historyText = [[NSMutableAttributedString alloc] init];
    NSAttributedString *joinStr = [[NSAttributedString alloc] initWithString:@"\n" attributes:nil];
    if([self.history isKindOfClass:[NSMutableArray class]]){
        for(id str in self.history){
            if([str isKindOfClass:[NSAttributedString class]]){
                [historyText appendAttributedString:str];
                [historyText appendAttributedString:joinStr];
            }
        }
    }
    if(![historyText.string length])
        return [[NSAttributedString alloc] initWithString:@"No game start!" attributes:nil];
    return historyText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
