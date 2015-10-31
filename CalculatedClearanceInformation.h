//
//  CalculatedClearanceInformation.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//
#import "EliminationTableItem.h"
//@class SingleSerumCreatinineInformation;
//@class DualSerumCreatinineInformation;
#import "DualSerumCreatinineInformation.h"
#import "SingleSerumCreatinineInformation.h"
//@class _24HourUrineCollection;
#import "_24HourUrineCollection.h"
@interface CalculatedClearanceInformation : EliminationTableItem

@property (nonatomic) SingleSerumCreatinineInformation *singleScr;
@property (nonatomic) DualSerumCreatinineInformation *dualScr;
@property (nonatomic) _24HourUrineCollection *twentyFourHourUrineScr;

@end