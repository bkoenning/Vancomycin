//
//  SingleSerumCreatinineInformation.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "TableItem.h"
#import "SerumCreatinine.h"
#import "BUN.h"
#import "Albumin.h"

@interface SingleSerumCreatinineInformation : TableItem

@property (nonatomic) SerumCreatinine *serumCreatinine;
@property (nonatomic) BUN *bun;
@property (nonatomic) Albumin *albumin;
@property (nonatomic) BOOL isAfricanRace;




@end
