//
//  RenalInformation.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "TableItem.h"
@class DialysisTableItem;
@class CalculatedClearanceInformation;

@interface RenalInformation : TableItem

@property DialysisTableItem *dialysisItem;
@property CalculatedClearanceInformation *clearanceItem;

@end
