//
//  CardGameViewController.m
//  CardGame
//
//  Created by shawjan on 15/12/7.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@property (nonatomic, strong) PlayCardDeck *deckCard;
@end

@implementation CardGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(PlayCardDeck *)deckCard
{
    if(!_deckCard){
        _deckCard = [[PlayCardDeck alloc] init];
    }
    return _deckCard;
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    [self.flipLabel setText:[NSString stringWithFormat:@"Flip:%d", self.flipCount]];
}


- (IBAction)CardButton:(UIButton *)sender {
    if([sender.currentTitle length])
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }else{
        Card *card = [self.deckCard drawRandomCard];
        if(card){
            ++self.flipCount;
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                              forState:UIControlStateNormal];
            [sender setTitle:card.contents forState:UIControlStateNormal];
        }
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
