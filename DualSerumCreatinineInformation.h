//
//  DualSerumCreatinineInformation.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "TableItem.h"
#import "SerumCreatinine.h"
#import "Time.h"

@interface DualSerumCreatinineInformation : TableItem

@property SerumCreatinine *scr1;
@property SerumCreatinine *scr2;
@property Time *timeBetweenLevels;

-(instancetype)initWithScr1: (SerumCreatinine*)s1 Scr2: (SerumCreatinine*)s2 timeBetweenLevels: (Time*)t;





@end
