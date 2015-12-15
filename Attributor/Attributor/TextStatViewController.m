//
//  TextStatViewController.m
//  Attributor
//
//  Created by shawjan on 15/12/14.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "TextStatViewController.h"

@interface TextStatViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulStatLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlineStatLabel;
@end

@implementation TextStatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setAttributedString:(NSAttributedString *)attributedString
{
    _attributedString = attributedString;
    if(self.view.window)
        [self updateUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

-(NSAttributedString*)attributedStringStat:(NSString*)name
{
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc] init];
    NSInteger index = 0;
    while (index < [self.attributedString length]) {
        NSRange selectRange;
        id value = [self.attributedString attribute:name atIndex:index effectiveRange:&selectRange];
        if(value){
            [resultString appendAttributedString:[self.attributedString attributedSubstringFromRange:selectRange]];
            index = selectRange.location + selectRange.length;
        }else{
            index++;
        }
    }
    return resultString;
}

-(void)updateUI
{
    self.colorfulStatLabel.text = [NSString stringWithFormat:@"%ld colorful characters", [[self attributedStringStat:NSForegroundColorAttributeName] length]];
    self.outlineStatLabel.text = [NSString stringWithFormat:@"%ld outline characters", [[self attributedStringStat:NSStrokeColorAttributeName] length]];
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
