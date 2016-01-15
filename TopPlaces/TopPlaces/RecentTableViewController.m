//
//  RecentTableViewController.m
//  shutterbug
//
//  Created by shawjan on 16/1/12.
//  Copyright © 2016年 shawjan. All rights reserved.
//

#import "RecentTableViewController.h"
#import "FlickrFetcher.h"

@interface RecentTableViewController ()

@end

@implementation RecentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.photos = [FlickrFetcher topPlaces];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.photos = [[NSUserDefaults standardUserDefaults] objectForKey:SCAN_HISTORY];
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
