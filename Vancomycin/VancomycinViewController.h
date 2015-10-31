//
//  VancomycinViewController.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//
#import <UIKit/UIKit.h>

@class BasicInformationViewController;
@class RenalInformationViewController;
@class CalculatedClearanceTableViewController;

@interface VancomycinViewController : UITableViewController

@property (strong, nonatomic) BasicInformationViewController *detailViewController;
@property (strong, nonatomic) RenalInformationViewController *renalViewController;
@property (strong,nonatomic) CalculatedClearanceTableViewController *ccViewController;


@end
