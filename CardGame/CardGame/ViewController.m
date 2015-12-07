
//
//  ViewController.m
//  CardGame
//
//  Created by shawjan on 15/12/4.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "ViewController.h"
#import "PlayCardDeck.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@property (nonatomic, strong) PlayCardDeck *deckCard;
@end

@implementation ViewController

-(PlayCardDeck *)deckCard
{
    if(!_deckCard){
        _deckCard = [[PlayCardDeck alloc] init];
    }
    return _deckCard;
}

-(void)setFlipCount:(int)flipCount
{
    if([self.deckCard remaindCards]){
        _flipCount = flipCount;
        [self.flipLabel setText:[NSString stringWithFormat:@"Flip:%d", self.flipCount]];
    }
}


- (IBAction)CardButton:(UIButton *)sender {
    if([sender.currentTitle length])
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }else{
        ++self.flipCount;
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                          forState:UIControlStateNormal];
        [sender setTitle:[self.deckCard drawRandomCard].contents forState:UIControlStateNormal];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
