//
//  CalculatedClearanceInformation.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//



#import "CalculatedClearanceInformation.h"
#import "SingleSerumCreatinineInformation.h"
#import "DualSerumCreatinineInformation.h"
#import "_24HourUrineCollection.h"

@implementation CalculatedClearanceInformation

@synthesize twentyFourHourUrineScr, dualScr, singleScr;

-(instancetype)init
{
    self = [super initWithTitle:@"Renal clearance"];
    [self setDualScr:[[DualSerumCreatinineInformation alloc]init]];
    [self setSingleScr:[[SingleSerumCreatinineInformation alloc]init]];
    [self setTwentyFourHourUrineScr:[[_24HourUrineCollection alloc]init]];
    return  self;
}
@end

