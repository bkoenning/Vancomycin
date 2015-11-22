//
//  _24HourUrineCollection.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "TableItem.h"
#import "SerumCreatinine.h"
#import "UrineCreatinine.h"
#import "UrineVolume.h"
#import "Creatinine.h"
#import "CreatinineConcentration.h"
#import "CreatinineClearance.h"

@interface _24HourUrineCollection : TableItem


@property (nonatomic) SerumCreatinine *serumCr;
@property (nonatomic) UrineCreatinine *urineCr;
@property (nonatomic) UrineVolume *urineVolume;

-(Creatinine*)creatinineExcreted;
-(CreatinineClearance*)creatinineClearance;



@end
