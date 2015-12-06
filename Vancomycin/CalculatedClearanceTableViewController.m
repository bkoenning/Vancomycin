//
//  CalculatedClearanceTableViewController.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "CalculatedClearanceTableViewController.h"
#import "CalculatedClearanceInformation.h"
#import "_24HourUrineCollection.h"
#import "SingleSerumCreatinineInformation.h"
#import "DualSerumCreatinineInformation.h"
#import "TableItem.h"
#import "_24HourUrineViewController.h"
#import "DualSerumCreatinineViewController.h"
#import "CustomVancomycinCell.h"

@interface CalculatedClearanceTableViewController ()
{
    NSMutableArray *objects;
    NSMutableArray *colors;
}


@end


@implementation CalculatedClearanceTableViewController

@synthesize detailItem;

-(void)setDetailItem: (CalculatedClearanceInformation*) newDetailItem
{
    if (newDetailItem != nil && [self detailItem] != newDetailItem){
        detailItem = newDetailItem;
    }
    
    
}

-(void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(tableItemDidChangeNotification:)
                                                name:kTableItemChanged
                                              object:nil];
    [super awakeFromNib];
    
}
/*
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 50;
    TableItem *i = objects[indexPath.row];
    if (![i isSet])
        return cellHeight;
    else{
        CGFloat buffer = 40;
        NSString *text = [i tableDescription];
        
        UIFont *font = [ UIFont systemFontOfSize:12.0f];
        CGFloat height = ceilf([text boundingRectWithSize:CGSizeMake(tableView.frame.size.width, 0) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: font} context:nil].size.height);
        return height + buffer;
    }
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    objects = [[NSMutableArray alloc]init];
    [objects addObject:[detailItem twentyFourHourUrineScr]];
    [objects addObject:[detailItem singleScr]];
    [objects addObject:[detailItem dualScr]];
    [[self tableView]setEstimatedRowHeight:44.0];
    [[self tableView]setRowHeight:UITableViewAutomaticDimension];
    
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
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return [objects count];
}
-(void)viewDidAppear:(BOOL)animated
{
    [[self tableView]reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomVancomycinCell *cell;
    
    
    
    // Configure the cell...
    TableItem *ti = [objects objectAtIndex:[indexPath row]];
    
    
    
    if ([ti isKindOfClass:[_24HourUrineCollection class]]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"twentyFourHourUrineCr" forIndexPath:indexPath];
        // if ([ti isSet]){
        //   [[cell detailTextLabel]setText:[[[self detailItem]twentyFourHourUrineScr]tableDescription]];
        //}
        
    }
    else if ([ti isKindOfClass:[DualSerumCreatinineInformation class]]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"twoValueScr" forIndexPath:indexPath];
    }
    else if ([ti isKindOfClass:[SingleSerumCreatinineInformation class]]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"singleValueScr" forIndexPath:indexPath];
       // [[cell titleLabel]setText:@"Single Value Serum Creatinine"];
       // [[cell detailLabel]setText:@"mish mash"];
    }
    
    //[[cell detailTextLabel]setNumberOfLines:0];
    
    //[[cell detailLabel]setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
    //[[cell detailTextLabel] setLineBreakMode:NSLineBreakByWordWrapping];
   // [[cell titleLabel]setText:@"Singlve Value Serum Creatinine"];
    
    if ([ti isSet]){
        NSAttributedString *text = [[NSAttributedString alloc]initWithString:[ti tableDescription]];
        [[cell detailTextLabel]setAttributedText:text];
    }
    else{
        [[cell detailTextLabel]setText:@""];
    }
    
    
    
    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc]initWithString:[ti tableHeader]];
    [atr addAttributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)} range:NSMakeRange(0, [atr length])];
    [[cell titleLabel]setFont:[UIFont boldSystemFontOfSize:20.0]];
    [[cell titleLabel]setAttributedText:atr];
    [[cell detailLabel]setText:@""];
    
    
    
    
    
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier]isEqualToString:@"to24HrInformation"]){
        [[segue destinationViewController]setDetailItem:[[self detailItem]twentyFourHourUrineScr]];
    }
    else if ([[segue identifier]isEqualToString:@"toDualSerumCreatinine"]){
        [[segue destinationViewController]setDetailItem:[[self detailItem]dualScr]];
    }
    
}


-(void)tableItemDidChangeNotification:(NSNotification *)notification
{
    NSUInteger index = [objects indexOfObject:notification.object];
    if (index!=NSNotFound)
    {
        NSIndexPath *path = [NSIndexPath indexPathForItem:index inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[path]
                              withRowAnimation:UITableViewRowAnimationNone];
    }
}


@end
