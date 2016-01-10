//
//  SetCardGameViewController.m
//  CardGame
//
//  Created by shawjan on 15/12/12.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "CardSetMatchingGame.h"
#import "PlayCardSet.h"
#import "PlayingCardSet.h"

@interface SetCardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardSetMatchingGame *setGame;
@property (strong, nonatomic) PlayCardSet *setCard;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic, assign) NSNumber *hScore;
@property (nonatomic, assign) NSNumber *lScore;
@end

@implementation SetCardGameViewController

-(void)setScoreLab:(UILabel *)scoreLab
{
    self.scoreLabel.text = scoreLab.text;
}

-(UILabel *)scoreLab
{
    return self.scoreLabel;
}

-(NSArray *)cardButtonsArray
{
    return self.cardButtons;
}

-(void)setGame:(CardMatchingGame *)game
{
    if(!game){
        _setGame = nil;
    }
}

-(CardMatchingGame *)game
{
    return self.setGame;
}

-(void)setCard:(Deck *)card
{
    if(!card){
        _setCard = nil;
    }
}

-(PlayCardSet *)setCard
{
    if(!_setCard){
        _setCard = [[PlayCardSet alloc] init];
    }
    return _setCard;
}

-(CardSetMatchingGame *)setGame
{
    if(!_setGame){
        _setGame = [[CardSetMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:self.setCard];
    }
    return _setGame;
}

-(NSNumber*)highestScore
{
    return self.hScore;
}

-(NSNumber*)lowestScore
{
    return self.lScore;
}

-(void)setHighestScore:(NSNumber*)highestScore
{
    if(highestScore.integerValue > self.hScore.integerValue){
        self.hScore = highestScore;
    }
}

-(void)setLowestScore:(NSNumber*)LowestScore
{
    if(LowestScore.integerValue < self.lScore.integerValue){
        self.lScore = LowestScore;
    }
}

NSString *const SetHighScore = @"SetCardGameHighestScore";
NSString *const SetLowScore = @"SetCardGamelowestScore";
-(NSNumber*)hScore
{
    //_hScore = [[NSUserDefaults standardUserDefaults] objectForKey:SetHighScore];
    if(!_hScore){
        _hScore = [NSNumber numberWithInteger:0];
    }
    return _hScore;
}

-(NSNumber *)lScore
{
    //_lScore = [[NSUserDefaults standardUserDefaults] objectForKey:SetLowScore];
    if(!_lScore){
        _lScore = [NSNumber numberWithInteger:0];
    }
    return _lScore;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

static NSString *const setTips = @"Tips:  if whole cards the same properties are all different or all identical got 10 points;  otherwise 5 points for penalty!";
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateUI];
    self.tipsLabel.text = setTips;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIButton *)setButtonTitle:(UIButton *)button withCard:(Card *)card
{
    
    return button;
}

-(IBAction)CardButton:(UIButton *)sender
{
    NSUInteger index = [self.cardButtonsArray indexOfObject:sender];
    //[self.game chosenAtIndex:index];
    [self.game chosenAtIndex:index cardsMatchCount:3];
    [super CardButton:sender];
}

-(IBAction)resetGameButton:(UIBarButtonItem *)sender
{
    [self saveHighestOrLowestScore];
    [super resetGameButton:sender];
}

-(void)saveHighestOrLowestScore
{
    NSNumber *setGameHeightScore = [[NSUserDefaults standardUserDefaults] objectForKey:SetHighScore];
    if(self.game.score > setGameHeightScore.integerValue){
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:self.game.score] forKey:SetHighScore];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
//    if(self.game.score < self.lowestScore.integerValue){
//        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:self.game.score] forKey:SetLowScore];
//    }
    self.lScore = self.hScore = 0;
}

-(void)updateUI
{
    for(int i = 0; i < [self.cardButtonsArray count]; ++i){
        Card * card = [self.game cardAtIndex:i];
        UIButton *btn = [self.cardButtonsArray objectAtIndex:i];
        if(card.chosen){
            [btn setBackgroundImage:[UIImage imageNamed:@"cardfrontselected"] forState:UIControlStateNormal];
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
        }
        [btn setAttributedTitle:[PlayingCardSet getContents:card] forState:UIControlStateNormal];        if(card.matched){
            btn.enabled = NO;
        }else{
            btn.enabled = YES;
        }
    }
    [super updateUI];
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
