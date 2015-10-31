//
//  RenalInformation.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "RenalInformation.h"
#import "CalculatedClearanceInformation.h"
#import "DialysisTableItem.h"

@implementation RenalInformation

@synthesize clearanceItem, dialysisItem;

-(instancetype)init
{
    self = [self initWithTitle:@"Renal Information"];
    [self setClearanceItem:[[CalculatedClearanceInformation alloc]init]];
    [self setDialysisItem:[[DialysisTableItem alloc]init]];
    [self setIsSet:NO];
    return  self;
}

@end
