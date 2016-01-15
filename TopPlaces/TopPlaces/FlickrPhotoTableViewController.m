//
//  FlickrPhotoTableViewController.m
//  shutterbug
//
//  Created by shawjan on 16/1/12.
//  Copyright © 2016年 shawjan. All rights reserved.
//

#import "FlickrPhotoTableViewController.h"
#import "FlickrFetcher/FlickrFetcher.h"
#import "ImageViewController.h"
@interface FlickrPhotoTableViewController ()

@end

@implementation FlickrPhotoTableViewController

-(void)setPhotos:(NSArray *)photos
{
    [self.tableView endUpdates];
    _photos = photos;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self.tableView beginUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.photos count];
}

-(NSString*)titleForRow:(NSInteger)row
{
    return [self.photos[row][FLICKR_PHOTO_TITLE] description];
}

-(NSString*)subTitleForRow:(NSInteger)row
{
    return [self.photos[row][FLICKR_PHOTO_OWNER] description];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"FlickrPhotoCellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self subTitleForRow:indexPath.row];
    return cell;
}

#pragma mark - Table view data delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id detailViewCon = self.splitViewController.viewControllers[1];
    if(detailViewCon){
        NSURL *url = [FlickrFetcher urlForPhoto:self.photos[indexPath.row] format:FlickrPhotoFormatLarge];
        ImageViewController*imageViewCon = [(UINavigationController*)detailViewCon viewControllers][0];
        [self prepareForImageViewController:imageViewCon withImageURL:url withTitle:[self titleForRow:indexPath.row]];
        [self updateScanHistory:indexPath.row];
    }
}


-(void)updateScanHistory:(NSInteger)row
{
    NSMutableArray *scanHistory = [[[NSUserDefaults standardUserDefaults] objectForKey:SCAN_HISTORY] mutableCopy];
    if(!scanHistory){
        scanHistory = [[NSMutableArray alloc] init];
    }
    BOOL isExisted = false;
    for(NSDictionary *dic in scanHistory){
        if([[dic objectForKey:FLICKR_PHOTO_ID] isEqualToString:[self.photos[row] objectForKey:FLICKR_PHOTO_ID]]){
            isExisted = true;
        }
    }
    if (!isExisted) {
        if([scanHistory count] > 20){
            [scanHistory removeObjectAtIndex:0];
        }
        [scanHistory addObject:self.photos[row]];
        [[NSUserDefaults standardUserDefaults] setObject:scanHistory forKey:SCAN_HISTORY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

-(void)prepareForImageViewController:(ImageViewController*)imageViewCon withImageURL:(NSURL*)imageURL withTitle:(NSString*)title
{
    if([imageViewCon isKindOfClass:[ImageViewController class]]){
        [imageViewCon setImageURL:imageURL];
        [imageViewCon setTitle:title];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([sender isKindOfClass:[UITableViewCell class]]){
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if([segue.identifier isEqualToString:@"Photo Detail Segue"]){
            if([segue.destinationViewController respondsToSelector:@selector(setImageURL:)]){
                NSURL *url = [FlickrFetcher urlForPhoto:self.photos[indexPath.row] format:FlickrPhotoFormatLarge];
                [self prepareForImageViewController:segue.destinationViewController withImageURL:url withTitle:[self titleForRow:indexPath.row]];
                [self updateScanHistory:indexPath.row];
            }
        }
    }
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



@end
