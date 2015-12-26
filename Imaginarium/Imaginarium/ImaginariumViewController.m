//
//  ImaginariumViewController.m
//  Imaginarium
//
//  Created by shawjan on 15/12/22.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "ImaginariumViewController.h"
#import "ImageViewController.h"

@interface ImaginariumViewController ()

@end

@implementation ImaginariumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_1.jpg
    if([segue.destinationViewController isKindOfClass:[ImageViewController class]]){
        ImageViewController *imageViewCon = (ImageViewController*)segue.destinationViewController;
        NSString *URL = [NSString stringWithFormat:@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/%@.jpg", segue.identifier];
        imageViewCon.title = segue.identifier;
        imageViewCon.imageURL = [NSURL URLWithString:URL];
        
    }

}


@end
