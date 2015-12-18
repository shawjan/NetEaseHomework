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
    self.superCardView.faceUp = !self.superCardView.faceUp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.superCardView.rank = 13;
    self.superCardView.suit = @"♥︎";
    
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
