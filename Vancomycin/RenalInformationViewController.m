//
//  RenalInformationViewController.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//


#import "RenalInformationViewController.h"
#import "RenalInformation.h"
#import "EliminationTableItem.h"
#import "CalculatedClearanceInformation.h"
#import "TableItem.h"
#import "DialysisTableItem.h"
#import "CalculatedClearanceTableViewController.h"
#import "EliminationTableItem.h"


@interface RenalInformationViewController ()
{
    NSMutableArray *objects;
}
@end

@implementation RenalInformationViewController


@synthesize renalDetailItem;

-(void)setRenalDetailItem:(RenalInformation*)newDetailItem
{
    if (newDetailItem != nil && [self renalDetailItem] != newDetailItem){
        renalDetailItem = newDetailItem;
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    objects = [[NSMutableArray alloc]init];
    [objects addObject:[renalDetailItem dialysisItem]];
    [objects addObject:[renalDetailItem clearanceItem]];
}




-(void)awakeFromNib
{
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    EliminationTableItem *thing = objects[indexPath.row];
    if ([thing isKindOfClass:[CalculatedClearanceInformation class]]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"clearanceCell" forIndexPath:indexPath];
    }
    else if ([thing isKindOfClass:[DialysisTableItem class]]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"dialysisCell" forIndexPath:indexPath];
    }
    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc]initWithString:[thing tableHeader]];
    [atr addAttributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)} range:NSMakeRange(0, [atr length])];
    [[cell textLabel]setFont:[UIFont boldSystemFontOfSize:20.0]];
    [[cell textLabel]setAttributedText:atr];
    
    return cell;
}

#pragma mark - Navigaton
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"toCalculatedClearance"]){
        [[segue destinationViewController]setDetailItem: [renalDetailItem clearanceItem]];
    }
    
}

@end
