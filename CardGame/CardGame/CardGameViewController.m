//
//  CardGameViewController.m
//  CardGame
//
//  Created by shawjan on 15/12/7.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (nonatomic, strong) PlayCardDeck *deckCard;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *CardButtons;
@property (strong, nonatomic) NSArray *cardButtonsArray;
@property (weak, nonatomic) IBOutlet UILabel *tipsLab;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardChooseSegment;
@property (weak, nonatomic) IBOutlet UIScrollView *cardCanvasScrollView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;
@end

@implementation CardGameViewController


-(CardMatchingGame *)game
{
    if(!_game){
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtonsArray count]
                                                  usingDeck:self.deckCard];
    }
    return _game;
}


static const NSInteger ButtonCount = 30;
static const NSInteger ButtonGap = 8;
static const NSInteger ButtonWidth = 64;
static const NSInteger ButtonHeight = 96;
-(NSArray*)creatButtons
{
    NSMutableArray *buttonsArray = [NSMutableArray array];
    self.cardCanvasScrollView.contentSize = CGSizeMake(ButtonCount / 3 * (ButtonWidth + ButtonGap), self.cardCanvasScrollView.bounds.size.height);
    for(int i = 0; i < 3; ++i){
        for(int j = 0; j < ButtonCount / 3; ++j)
        {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(j * (ButtonGap + ButtonWidth), i * (ButtonGap + ButtonHeight), ButtonWidth, ButtonHeight)];
            [btn addTarget:self action:@selector(CardButton:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [buttonsArray addObject:btn];
            [self.cardCanvasScrollView addSubview:btn];
        }
    }
    return [buttonsArray copy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tipsLab.text = @"Tips:\n  Matched J♠︎ and J♣︎ for 4 points\n  Match J♠︎ and K♠︎ for 1 point\n  6♠︎ and J♣︎ don't matched! 2 points penalty!";
    self.cardButtonsArray = [self creatButtons];
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

- (IBAction)CardButton:(UIButton *)sender {
    NSUInteger index = [self.cardButtonsArray indexOfObject:sender];
    //[self.game chosenAtIndex:index];
    [self.game chosenAtIndex:index cardsMatchCount:self.cardChooseSegment.selectedSegmentIndex ? 3 : 2];
    [self updateUI];
}
- (IBAction)resetGameButton:(UIButton *)sender {
    self.deckCard = nil;
    self.game = nil;
    [self updateUI];
}


- (void)updateUI
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
    self.scoreLab.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
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
