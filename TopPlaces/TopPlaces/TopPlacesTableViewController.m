//
//  TopPlacesTableViewController.m
//  TopPlaces
//
//  Created by shawjan on 16/1/14.
//  Copyright © 2016年 shawjan. All rights reserved.
//

#import "TopPlacesTableViewController.h"
#import "PlacePhotosTableViewController.h"
#import "FlickrFetcher.h"

@interface TopPlacesTableViewController ()
@property (nonatomic, strong) NSArray *topPlaces;
@property(nonatomic, strong) NSMutableDictionary *topPlacesMDic;
@property(nonatomic, strong) NSArray *allCountries;
@end

@implementation TopPlacesTableViewController

-(NSMutableDictionary *)topPlacesMDic
{
    if(!_topPlacesMDic){
        _topPlacesMDic = [[NSMutableDictionary alloc] init];
    }
    return _topPlacesMDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView beginUpdates];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *array = [FlickrFetcher topPlaces];
        if(array){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView endUpdates];
                self.topPlaces = array;
                [self dividedByCountry];
                [self.tableView reloadData];
            });
        }
    });
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

-(void)dividedByCountry
{
    for(NSDictionary *dic in self.topPlaces){
        NSString *placeUrl = [dic objectForKey:FLICKR_PLACE_NAME];
        NSArray *placeSegments = [placeUrl componentsSeparatedByString:@","];
        NSString *countryName =  [placeSegments lastObject] ? [placeSegments lastObject] : @"Unknown";
        NSMutableArray *countries = [self.topPlacesMDic objectForKey:countryName];
        if(![countries count]){
            countries = [NSMutableArray array];
        }
        [countries addObject:dic];
        [self.topPlacesMDic setObject:countries forKey:countryName];
    }
    self.allCountries = [self.topPlacesMDic allKeys];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.allCountries count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.topPlacesMDic objectForKey:[self.allCountries objectAtIndex:section]] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.allCountries objectAtIndex:section];
}

-(NSString*)titleForRow:(NSIndexPath*)indexPath
{
    NSDictionary *dic = [[self.topPlacesMDic objectForKey:[self.allCountries objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    NSString *placeUrl = [dic objectForKey:FLICKR_PLACE_NAME];
    NSArray *placeSegments = [placeUrl componentsSeparatedByString:@","];
    NSString *cityName = [placeSegments firstObject] ? [placeSegments firstObject] : @"Unknown";
    return cityName;
}

-(NSString*)subTitleForRow:(NSIndexPath*)indexPath
{
    NSDictionary *dic = [[self.topPlacesMDic objectForKey:[self.allCountries objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    NSString *placeUrl = [dic objectForKey:FLICKR_PLACE_NAME];
    NSArray *placeSegments = [placeUrl componentsSeparatedByString:@","];
    NSString *stateName = [placeSegments objectAtIndex:1] ? [placeSegments objectAtIndex:1] : @"Unknown";
    return stateName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopPlacesCellIdentify" forIndexPath:indexPath];
    cell.textLabel.text = [self titleForRow:indexPath];
    cell.detailTextLabel.text = [self subTitleForRow:indexPath];
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation
#define MAX_RESULTS_IN_PLACES 50
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"Show Places Photos"]){
        if([sender isKindOfClass:[UITableViewCell class]]){
            NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell*)sender];
            if([segue.destinationViewController isKindOfClass:[PlacePhotosTableViewController class]]){
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                   NSArray *array = [FlickrFetcher photosInPlace:[[self.topPlacesMDic objectForKey:[self.allCountries objectAtIndex:indexPath.section]]  objectAtIndex:indexPath.row] maxResults:MAX_RESULTS_IN_PLACES];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        ((PlacePhotosTableViewController*)segue.destinationViewController).photos = array;
                    });
                });
            }
        }
    }
}


@end
