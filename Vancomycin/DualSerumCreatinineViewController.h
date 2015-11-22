//
//  DualSerumCreatinineViewController.h
//  Vancomycin
//
//  Created by Brandon Koenning on 11/17/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DualSerumCreatinineInformation.h"




@interface DualSerumCreatinineViewController : UIViewController

@property IBOutlet UITextField *serumCreatinine1TextField;
@property IBOutlet UITextField *serumCreatinine2TextField;
@property IBOutlet UITextField *timeBetweenSerumCreatinineLevelsTextField;
@property IBOutlet UIButton *lockButton;
@property IBOutlet UIButton *clearButton;
@property IBOutlet UIButton *informationButton;
@property IBOutlet UISegmentedControl *segSerumCreatinine1;
@property IBOutlet UISegmentedControl *segSerumCreatinine2;

-(IBAction)validateAndLockInformation:(id)sender;

@property (nonatomic) DualSerumCreatinineInformation *detailItem;



@end
