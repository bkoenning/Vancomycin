//
//  _24HourUrineViewController.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "_24HourUrineCollection.h"

@interface _24HourUrineViewController : UIViewController

@property (nonatomic) IBOutlet UITextField *urineCrText;
@property (nonatomic) IBOutlet UITextField *serumCrText;
@property (nonatomic) IBOutlet UITextField *urineVolumeText;
@property (nonatomic) IBOutlet UIButton *lockButton;
@property (nonatomic) IBOutlet UIButton *informationButton;
@property (nonatomic) IBOutlet UIButton *clearButton;
@property (nonatomic) IBOutlet UISegmentedControl *segUCr;
@property (nonatomic) IBOutlet UISegmentedControl *segScr;
@property (nonatomic) IBOutlet UISegmentedControl *segUrineVolume;

-(IBAction)validateAndLockInformation:(id)sender;


@property (nonatomic) _24HourUrineCollection *detailItem;

@end
