//
//  SuperCardViewController.m
//  SuperCard
//
//  Created by shawjan on 15/12/14.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "SuperCardViewController.h"
#import "SuperCardView.h"

@interface SuperCardViewController ()
@property (weak, nonatomic) IBOutlet SuperCardView *superCardView;

@end

@implementation SuperCardViewController
- (IBAction)swipeGesture:(UISwipeGestureRecognizer *)sender {
    [UIView transitionWithView:self.superCardView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        self.superCardView.faceUp = !self.superCardView.faceUp;
                        [self setCardContent];
                    }completion:nil];
}

-(void)setCardContent
{
    NSInteger sel = arc4random() % 13 + 1;
    self.superCardView.rank = sel;
    self.superCardView.suit = @"♥";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self setCardContent];
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self.superCardView action:@selector(pinchAction:)];
    [self.superCardView addGestureRecognizer:pinchGesture];
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
