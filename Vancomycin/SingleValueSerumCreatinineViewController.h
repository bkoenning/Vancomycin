//
//  SingleValueSerumCreatinineViewController.h
//  Vancomycin
//
//  Created by Brandon Koenning on 11/19/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleSerumCreatinineInformation.h"

@interface SingleValueSerumCreatinineViewController : UIViewController

@property IBOutlet UIButton *buttonCockcroftGault;
@property IBOutlet UIButton *buttonMDRD;
@property IBOutlet UIButton *buttonCKDEPI;

@property IBOutlet UILabel *labelCockcroftGault;
@property IBOutlet UILabel *labelMDRD1;
@property IBOutlet UILabel *labelMDRD2;
@property IBOutlet UILabel *labelCKDEPI1;
@property IBOutlet UILabel *labelCKDEPI2;

@property IBOutlet UIButton *buttonSubmit;
@property IBOutlet UIButton *buttonInfo;
@property IBOutlet UIButton *buttonClear;

@property IBOutlet UITextField *textFieldSerumCreatinine;
@property IBOutlet UITextField *textFieldAlbumin;
@property IBOutlet UITextField *textFieldBUN;

@property IBOutlet UISegmentedControl *segmentSerumCreatinine;
@property IBOutlet UISegmentedControl *segmentBUN;
@property IBOutlet UISegmentedControl *segmentAlbumin;
@property IBOutlet UISegmentedControl *segmentRace;

-(IBAction)updateCockcroftGault:(id)sender;
-(IBAction)updateMDRD:(id)sender;
-(IBAction)updateCKDEPI:(id)sender;
-(IBAction)lock:(id)sender;

@property (strong,nonatomic) SingleSerumCreatinineInformation* detailItem;






@end
