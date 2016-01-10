//
//  DeckCardGameViewController.m
//  CardGame
//
//  Created by shawjan on 15/12/12.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "DeckCardGameViewController.h"
#import "CardDeckMatchingGame.h"
#import "PlayCardDeck.h"

@interface DeckCardGameViewController ()
@property (strong, nonatomic) CardDeckMatchingGame *deckGame;
@property (strong, nonatomic) PlayCardDeck *deckCard;
//@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *cardCanvasScrollView;
@property (nonatomic, assign) NSNumber *hScore;
@property (nonatomic, assign) NSNumber *lScore;
@end

@implementation DeckCardGameViewController

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

NSString *const DeckHighScore = @"DeckCardGameHighestScore";
NSString *const DeckLowScore = @"DeckCardGamelowestScore";
-(NSNumber*)hScore
{
    //_hScore = [[NSUserDefaults standardUserDefaults] objectForKey:DeckHighScore];
    if(!_hScore){
        _hScore = [NSNumber numberWithInteger:0];
    }
    return _hScore;
}

-(NSNumber *)lScore
{
    //_lScore = [[NSUserDefaults standardUserDefaults] objectForKey:DeckLowScore];
    if(!_lScore){
        _lScore = [NSNumber numberWithInteger:0];
    }
    return _lScore;
}



-(void)setTipsLab:(UILabel *)tipsLab
{
    self.tipsLabel.text = tipsLab.text;
}

-(void)setScoreLab:(UILabel *)scoreLab
{
    self.scoreLabel.text = scoreLab.text;
}


-(UILabel *)scoreLab
{
    return self.scoreLabel;
}

-(CardDeckMatchingGame *)deckGame
{
    if(!_deckGame){
        _deckGame = [[CardDeckMatchingGame alloc] initWithCardCount:[self.cardButtonsArray count]
                                                      usingDeck:self.deckCard];
    }
    return _deckGame;
}

-(void)setGame:(CardMatchingGame *)game
{
    if(!game){
        _deckGame = nil;
    }
}

-(CardMatchingGame *)game
{
    return self.deckGame;
}

-(void)setCard:(Deck *)card
{
    if(!card){
        _deckCard = nil;
    }
}

-(PlayCardDeck *)deckCard
{
    if(!_deckCard){
        _deckCard = [[PlayCardDeck alloc] init];
    }
    return _deckCard;
}

static const NSInteger ButtonCount = 30;
static const NSInteger ButtonGap = 8;
static const NSInteger ButtonWidth = 64;
static const NSInteger ButtonHeight = 96;
-(NSArray*)creatButtons
{
    NSMutableArray *buttonsArray = [NSMutableArray array];
    NSInteger verticalGap = (self.cardCanvasScrollView.frame.size.width - ButtonWidth * 4) / 3;
    self.cardCanvasScrollView.contentSize = CGSizeMake(ButtonCount / 3 * (ButtonWidth + verticalGap), self.cardCanvasScrollView.bounds.size.height);
    for(int i = 0; i < 3; ++i){
        for(int j = 0; j < ButtonCount / 3; ++j)
        {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(j * (verticalGap + ButtonWidth), i * (ButtonGap + ButtonHeight), ButtonWidth, ButtonHeight)];
            [btn addTarget:self action:@selector(CardButton:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [buttonsArray addObject:btn];
            [self.cardCanvasScrollView addSubview:btn];
        }
    }
    return [buttonsArray copy];
}

static NSString *const tips = @"Tips:  Matched J♠︎ and J♣︎ for 4 points;  Match J♠︎ and K♠︎ for 1 point;  6♠︎ and J♣︎ don't matched! 2 points penalty!";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(![self.cardButtonsArray count]){
        self.cardButtonsArray = [self creatButtons];
    }
    self.tipsLabel.text = tips;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


-(void)CardButton:(UIButton *)sender
{
    self.cardChooseSegment.enabled = NO;
    NSUInteger index = [self.cardButtonsArray indexOfObject:sender];
    //[self.game chosenAtIndex:index];
    [self.game chosenAtIndex:index cardsMatchCount:self.cardChooseSegment.selectedSegmentIndex ? 3 : 2];
    [super CardButton:sender];
}

-(IBAction)resetGameButton:(UIBarButtonItem *)sender
{
    [self saveHighestOrLowestScore];
    self.cardChooseSegment.enabled = YES;
    [super resetGameButton:sender];
}

-(void)saveHighestOrLowestScore
{
    NSNumber *deckGameHeightScore = [[NSUserDefaults standardUserDefaults] objectForKey:DeckHighScore];
    if(self.game.score > deckGameHeightScore.integerValue){
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:self.game.score] forKey:DeckHighScore];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
//    if(self.game.score < self.lowestScore.integerValue){
//        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:self.game.score] forKey:DeckLowScore];
//    }
    self.lScore = self.hScore = 0;
}

-(void)updateUI
{
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
