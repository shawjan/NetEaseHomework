//
//  SettingTableViewController.m
//  CardGame
//
//  Created by shawjan on 16/1/9.
//  Copyright © 2016年 shawjan. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController ()<UIAlertViewDelegate>
@property(nonatomic, strong) NSArray *settingContent;
@end

@implementation SettingTableViewController

-(NSArray *)settingContent
{
    return @[@"Punish Score", @"Bonus Multiple"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
    return [self.settingContent count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCellIdentify" forIndexPath:indexPath];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingCellIdentify"];
    }
    cell.textLabel.text = [self.settingContent objectAtIndex:indexPath.row];
    if(indexPath.row == 0){
        NSInteger punishScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"PunishScore"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", punishScore];
    }else if(indexPath.row == 1){
        NSInteger bonusMultiple = [[NSUserDefaults standardUserDefaults] integerForKey:@"BonusMultiple"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", bonusMultiple];
    }
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *message = [NSString stringWithFormat:@"Set %@ Value", self.settingContent[indexPath.row]];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alertView.tag = indexPath.row;
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        if(alertView.tag == 0){
            NSString *text = [alertView textFieldAtIndex:0].text;
            [[NSUserDefaults standardUserDefaults] setInteger:text.integerValue forKey:@"PunishScore"];
        }else if(alertView.tag == 1){
            NSString *text = [alertView textFieldAtIndex:0].text;
            [[NSUserDefaults standardUserDefaults] setInteger:text.integerValue forKey:@"BonusMultiple"];
        }
        [self.tableView reloadData];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
