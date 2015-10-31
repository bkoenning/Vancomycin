//
//  RenalInformationViewController.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "RenalInformation.h"
//#import "CalculatedClearanceInformation.h"
//#import "CalculatedClearanceTableViewController.h"

@interface RenalInformationViewController : UITableViewController

@property (nonatomic) RenalInformation *renalDetailItem;
//@property (nonatomic) CalculatedClearanceTableViewController *ccViewController;
@end