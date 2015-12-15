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
@property (weak, nonatomic) IBOutlet UIScrollView *cardCanvasScrollView;
@end

@implementation DeckCardGameViewController

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
    self.cardCanvasScrollView.contentSize = CGSizeMake(ButtonCount / 3 * (ButtonWidth + ButtonGap), self.cardCanvasScrollView.bounds.size.height);
//    self.cardCanvasScrollView.bounds = CGRectMake(0, 0, self.cardCanvasScrollView.bounds.size.width, self.cardCanvasScrollView.bounds.size.height);
    NSLog(@"%f %f", self.cardCanvasScrollView.contentInset.top, self.cardCanvasScrollView.contentInset.bottom);
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

static NSString *const tips = @"Tips:  Matched J♠︎ and J♣︎ for 4 points;  Match J♠︎ and K♠︎ for 1 point;  6♠︎ and J♣︎ don't matched! 2 points penalty!";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tipsLab.text = tips;
    self.cardButtonsArray = [self creatButtons];
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
