//
//  VancomycinViewController.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "VancomycinViewController.h"
#import "BasicInformation.h"
#import "TableItem.h"
#import "BasicInformationViewController.h"
#import "RenalInformation.h"
#import "RenalInformationViewController.h"
//#import "CalculatedClearanceTableItem.h"
#import "DialysisTableItem.h"
#import "CalculatedClearanceTableViewController.h"
#import "CustomVancomycinCell.h"

@interface VancomycinViewController ()
{
    NSMutableArray *objects;
    BasicInformation *basicInformation;
    RenalInformation *renalInformation;
    NSArray *colors;
    UIColor *color1, *color2;
}
-(void)tableItemDidChangeNotification:(NSNotification*)notification;

@end

@implementation VancomycinViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    objects = nil;
    basicInformation = nil;
}


-(void)awakeFromNib
{
    basicInformation = [[BasicInformation alloc]init];
    renalInformation = [[RenalInformation alloc] init];
    color1 = [UIColor colorWithRed:255.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1.0f];
    color2 = [UIColor colorWithRed:255.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
    colors = @[color1, color2];

    objects = [@[basicInformation, renalInformation] mutableCopy];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(tableItemDidChangeNotification:)
                                                name:kTableItemChanged
                                              object:nil];
    [super awakeFromNib];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [objects count];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self tableView]setEstimatedRowHeight:66.0];
    [[self tableView]setRowHeight:UITableViewAutomaticDimension];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated
{
    [[self tableView]reloadData];
}


/*-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomVancomycinCell *cell;
    TableItem *thing = objects[indexPath.row];
    if ([thing isKindOfClass:[BasicInformation class]]){
        cell = [[self tableView]dequeueReusableCellWithIdentifier:@"basicInformationCell" forIndexPath:indexPath];
    }
    else if ([thing isKindOfClass:[RenalInformation class]]){
        cell = [[self tableView]dequeueReusableCellWithIdentifier:@"renalInformationCell" forIndexPath:indexPath];
    }
    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc]initWithString:[thing tableHeader]];
    [atr addAttributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)} range:NSMakeRange(0, [atr length])];
    [[cell titleLabel]setAttributedText:atr];
    
    if ([thing isSet]){
        NSAttributedString *text = [[NSAttributedString alloc]initWithString:[thing tableDescription]];
        [[cell detailLabel]setAttributedText:text];
    }
    else{
        [[cell detailTextLabel]setText:@""];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[colors objectAtIndex:indexPath.row]];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - Navigaton
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"toBasicInformation"]){
        [[segue destinationViewController]setDetailItem: basicInformation];
        
    }
    else if ([[segue identifier] isEqualToString:@"toRenalInformation"]){
        [[segue destinationViewController]setRenalDetailItem:renalInformation];
    }
    else{
        [[segue destinationViewController]setDetailItem: basicInformation];
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
/*
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
 BasicInformation *object = objects[indexPath.row];
 self.detailViewController.detailItem = object;
 }
 }
 */

@end
