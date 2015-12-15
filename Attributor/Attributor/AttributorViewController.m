//
//  AttributorViewController.m
//  Attributor
//
//  Created by shawjan on 15/12/14.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "AttributorViewController.h"
#import "TextStatViewController.h"

@interface AttributorViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation AttributorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle attributes:@{NSStrokeWidthAttributeName:@-3, NSStrokeColorAttributeName:[UIColor blackColor]}];
    [self.outlineButton setAttributedTitle:attributedString forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self usePreferredTextFont];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredTextFont:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)preferredTextFont:(NSNotification*)noti
{
    [self usePreferredTextFont];
}

-(void)usePreferredTextFont
{
    self.textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (IBAction)changeSelectedTextColorButton:(UIButton *)sender {
    [self.textView.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.textView.selectedRange];
}


- (IBAction)changeOutlineButton:(UIButton *)sender {
    if(sender.tag == 20){
        [self.textView.textStorage addAttributes:@{NSStrokeWidthAttributeName: @-3, NSStrokeColorAttributeName:[UIColor blackColor]} range:self.textView.selectedRange];
    }else{
        [self.textView.textStorage addAttributes:@{NSStrokeWidthAttributeName: @0} range:self.textView.selectedRange];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"TextStatViewController"]){
        TextStatViewController *viewCon = segue.destinationViewController;
        if ([viewCon isKindOfClass:[TextStatViewController class]]){
            viewCon.attributedString = self.textView.attributedText;
        }
    }
}


@end
