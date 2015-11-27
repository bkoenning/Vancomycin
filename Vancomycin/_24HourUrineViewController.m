//
//  _24HourUrineViewController.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "_24HourUrineViewController.h"

@interface _24HourUrineViewController (){
    NSMutableArray *enabledViews;   // the view components to be enabled and disabled during locking
    UITapGestureRecognizer *recognizer;  //recognizer to record taps outside the entry area to dismiss keypad
}
@end

@implementation _24HourUrineViewController

@synthesize detailItem;

-(void)setDetailItem: (_24HourUrineCollection*) newDetailItem  //set the information from the top view controller
{
    if (newDetailItem != nil && [self detailItem] != newDetailItem)
        detailItem = newDetailItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // load the array with references to views that can be enabled/disabled
    enabledViews = [NSMutableArray arrayWithObjects:[self segUCr], [self segScr], [self segUrineVolume], [self urineCrText], [self serumCrText], [self urineVolumeText],nil];
    // set the view
    [self configureView];
    // set the tap recognizer with the hide keyboard selector
    recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
}

-(void)hideKeyboard
{
    // dismiss the keypad from the textfield views
    [[self serumCrText]resignFirstResponder];
    [[self urineVolumeText]resignFirstResponder];
    [[self urineCrText]resignFirstResponder];
    // disable the recognizer while the keypad is not on screen
    [recognizer setEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)configureView
{
    // fill in the views with information if the data from the top controller is verified as valid
    if ([[self detailItem]isSet]){
        [[self urineCrText]setText:[[[[self detailItem]urineCr]mol]valueAsString]];
        [[self serumCrText] setText:[[[[self detailItem]serumCr]mol]valueAsString]];
        [[self urineVolumeText] setText:[[[self detailItem]urineVolume]valueAsString]];
        if ([[[self detailItem]urineVolume]unit] == L){
            [[self segUrineVolume]setSelectedSegmentIndex:1];
        }
        else [[self segUrineVolume]setSelectedSegmentIndex:0];
        
        if (![[[[self detailItem]serumCr]mol]returnAsMolar]){
            [[self segScr]setSelectedSegmentIndex:0];
        }
        else{
            [[self segScr] setSelectedSegmentIndex:1];
        }
        
        if (![[[[self detailItem]urineCr]mol]returnAsMolar]){
            [[self segUCr]setSelectedSegmentIndex:0];
        }
        else{
            [[self segUCr]setSelectedSegmentIndex:1];
        }
        //set the button title to unlock information for editing
        [[self lockButton]setTitle:@"Unlock Information" forState:UIControlStateNormal];
        // disable the views that have been filled in with good data so that user must click unlock to edit
        for (UIControl *con in enabledViews){
            [con setEnabled:NO];
        }
    }
}

-(void)validateAndLockInformation:(id)sender
{
    SerumCreatinine *userSCR;
    UrineCreatinine *userUrineCR;
    Creatinine *userCR;
    UrineVolume *userUrineVol;
    
    UrineVolume *maxUrine = [UrineVolume maxDaily];
    UrineVolume *minUrine = [UrineVolume minDaily];
    SerumCreatinine *minSCRMass = [SerumCreatinine minConcentrationMass];
    SerumCreatinine *maxSCRMass = [SerumCreatinine maxConcentrationMass];
    SerumCreatinine *minSCRMolar = [SerumCreatinine minConcentrationMolar];
    SerumCreatinine *maxSCRMolar = [SerumCreatinine maxConcentrationMolar];
    Creatinine *minCreat = [UrineCreatinine minDailyExcretion];
    Creatinine *maxCreat = [UrineCreatinine maxDailyExcretion];
    
    NSString *title, *message;
    
    /* if information is unlockable, set the editing views to enabled, changed to title of the button to indicate
     information can be locked, set the data object to bad data, and notify from the object that data has been set to bad, and exit the method */
    if ([[[[self lockButton]titleLabel]text]isEqualToString:@"Unlock Information"]){
        for (UIControl *con in enabledViews){
            [con setEnabled: YES];
        }
        [[self lockButton]setTitle:@"Lock Information" forState:UIControlStateNormal];
        [[self detailItem]setIsSet:NO];
        [[self detailItem]postDidChangeNotification];
    }
    // display an alert to the user if nothing was selected for urine volume units
    else if ([[self segUrineVolume]selectedSegmentIndex]== UISegmentedControlNoSegment){
        title = @"Nothing selected for urine volume units";
        message = @"Select a unit of measure for urine volume.";
        [self showAlertWithTitle:title message:message];
    }
    // display an alert to the user if nothing was selected for urine creatinine units
    else if ([[self segUCr]selectedSegmentIndex]== UISegmentedControlNoSegment){
        title = @"Nothing selected for urine creatinine concentration units";
        message = @"Select a unit of measure for urine creatinine.";
        [self showAlertWithTitle:title message:message];
    }
    // display an alert to the user if nothing was selected for serum creatinine units
    else if ([[self segScr]selectedSegmentIndex]== UISegmentedControlNoSegment){
        title = @"Nothing selected for serum creatinine concentration units";
        message = @"Select a unit of measure for serum creatinine.";
        [self showAlertWithTitle:title message:message];
    }
    // preliminary regex check for urine volume if mL was selected for units
    else if ([[self segUrineVolume] selectedSegmentIndex] == 0 && ![UrineVolume regexForDailyUrineVolumeInML:[[self urineVolumeText]text]]){
        title = @"Value for urine volume is in an invalid format.";
        minUrine = [minUrine converted:ML];
        maxUrine = [maxUrine converted:ML];
        message = [NSString stringWithFormat:@"%@%@%@%@%@", @"The acceptable range for urine volume is ", [minUrine description], @" to ", [maxUrine description], @"."];
        [self showAlertWithTitle:title message:message];
    }
    // preliminary regex check for urine volume if L was selected for units
    else if ([[self segUrineVolume] selectedSegmentIndex] == 1 && ![UrineVolume regexForDailyUrineVolumeInL:[[self urineVolumeText]text]]){
        title = @"Value for urine volume is in an invalid format.";
        minUrine = [minUrine converted:L];
        maxUrine = [maxUrine converted:L];
        message = [NSString stringWithFormat:@"%@%@%@%@%@", @"The acceptable range for urine volume is ", [minUrine description], @" to ", [maxUrine description], @"."];
        [self showAlertWithTitle:title message:message];
      }
    // preliminary regex check for serum creatinine if mg/dL was selected for serum creatinine units, range is 0.20 to 5.50
    else if ([[self segScr]selectedSegmentIndex] == 0 && ![SerumCreatinine regexCheckInMilligramsPerDeciliter:[[self serumCrText]text]]){
        title = @"Value for serum creatinine is in an invalid format.";
        message = [NSString stringWithFormat:@"%@%@%@%@%@", @"The acceptable range for serum creatinine is ", [minSCRMass description], @" to ", [maxSCRMass description], @"."];
        [self showAlertWithTitle:title message:message];
      }
    // preliminary regex check for serum creatinine if micromol/L was selected for serum creatinine units
    else if ([[self segScr]selectedSegmentIndex] == 1 && ![SerumCreatinine regexCheckInMicromolesPerLiter:[[self serumCrText]text]]){
        title = @"Value for serum creatinine is in an invalid format.";
        message = [NSString stringWithFormat:@"%@%@%@%@%@", @"The acceptable range for serum creatinine is ", [minSCRMolar description], @" to ", [maxSCRMolar description], @"."];
        [self showAlertWithTitle:title message:message];
    }
    // preliminary regex check for urine creatinine if mg/dL was selected for urine creatinine units
    else if ([[self segUCr] selectedSegmentIndex] == 0 && ![UrineCreatinine regexForUrineCreatinineConcentrationInMgDL:[[self urineCrText]text]]){
        title = @"Value for urine creatinine is in an invalid format.";
        message = @"Urine creatinine must be a number in the format from # to ###.##";
        [self showAlertWithTitle:title message:message];
       }
    //  preliminary regex check for urine creatinine if micromol/L was selected for urine creatinine units
    else if ([[self segUCr] selectedSegmentIndex] == 1 && ![UrineCreatinine regexForUrineCreatinineConcentrationInMicromolL:[[self urineCrText]text]]){
        title = @"Value for urine creatinine is in an invalid format.";
        message = @"Urine creatinine must be a number in the format from ### to #####";
        [self showAlertWithTitle:title message:message];
    }
    else{
        NSUInteger urineCreatinineUnit = [[self segUCr]selectedSegmentIndex];
        NSUInteger urineVolumeUnit = [[self segUrineVolume]selectedSegmentIndex];
        NSUInteger serumCreatinineUnit = [[self segScr]selectedSegmentIndex];
        if (urineCreatinineUnit == 0){
            userUrineCR = [[UrineCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMassFloat:[[[self urineCrText]text]floatValue] massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1 andUnits:DL]];
        }
        else{
            userUrineCR = [[UrineCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMolarFloat:[[[self urineCrText]text]floatValue] molarUnit:MICROMOL] andVolume:[[Volume alloc]initWithFloat:1 andUnits:L]];
        }
        if (urineVolumeUnit == 0){
            userUrineVol = [[UrineVolume alloc]initWithFloat:[[[self urineVolumeText]text]floatValue] andUnits:ML];
            minUrine = [minUrine converted:ML];
            maxUrine = [maxUrine converted:ML];
        }
        else{
            userUrineVol = [[UrineVolume alloc]initWithFloat:[[[self urineVolumeText]text]floatValue] andUnits:L];
            minUrine = [minUrine converted:L];
            maxUrine = [maxUrine converted:L];
        }
        if (serumCreatinineUnit == 0){
            userSCR = [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMassFloat:[[[self serumCrText]text]floatValue] massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1 andUnits:DL]];
        }
        else{
            userSCR = [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMolarFloat:[[[self serumCrText]text]floatValue] molarUnit:MICROMOL] andVolume:[[Volume alloc]initWithFloat:1 andUnits:L]];
        }
        userCR = [userUrineCR creatinineExcreted:userUrineVol];
        if (urineCreatinineUnit == 0){
            userCR = [userCR convertedToMassUnit:MILLIGRAM];
            minCreat = [minCreat convertedToMassUnit:MILLIGRAM];
            maxCreat = [maxCreat convertedToMassUnit:MILLIGRAM];
        }
        else{
            userCR = [userCR convertedToMolarUnit:MILLIMOL];
            minCreat = [minCreat convertedToMolarUnit:MILLIMOL];
            maxCreat = [maxCreat convertedToMolarUnit:MILLIMOL];
        }
        
        
        if (![userCR isInRangeLower:minCreat upper:maxCreat]){
            title = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@", @"Total creatinine excreted in 24 hours is out of range at ", [userCR description], @".  ", @"Total creatinine excreted in 24 hours must be between ", [minCreat description], @" and ", [maxCreat description], @"."];
            message = @"Verify urine volume and urine creatinine.";
            [self showAlertWithTitle:title message:message];
        }
        else if ((![userSCR isInRangeLower:minSCRMass upper:maxSCRMass] && serumCreatinineUnit == 0) || (![userSCR isInRangeLower:minSCRMolar upper:maxSCRMolar] && serumCreatinineUnit == 1)){
            if (serumCreatinineUnit == 0){
                title = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@", @"Serum creatinine is out of range at ", [userSCR description], @".  ", @"Serum creatinine must be between ", [minSCRMass description], @" and ", [maxSCRMass description], @"."];
            }
            else{
                title = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@", @"Serum creatinine is out of range at ", [userSCR description], @".  ", @"Serum creatinine must be between ", [minSCRMolar description], @" and ", [maxSCRMolar description], @"."];
            }
        }
        else if (![userUrineVol isInRangeLower:minUrine upper:maxUrine]){
            title = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@", @"24 hour urine volume is out of range at ", [userUrineVol description], @".  ", @"24 hour urine volume must be between ", [minUrine description], @" and ", [maxUrine description], @"."];
            message = @"Verify 24 hour urine volume.";
            [self showAlertWithTitle:title message:message];
            
        }
        else{
            [[self detailItem]setUrineCr:userUrineCR];
            [[self detailItem]setUrineVolume:userUrineVol];
            [[self detailItem]setSerumCr:userSCR];
            [[self detailItem]setIsSet:YES];
            [[self detailItem]postDidChangeNotification];
            [[self lockButton]setTitle:@"Unlock Information" forState:UIControlStateNormal];
            for (UIControl *con in enabledViews){
                [con setEnabled:NO];
            }
        }
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // when a user taps outside and editing area end editing for the view and disable recognizer while keypad is not on screen
    [[self view]endEditing:YES];
    [recognizer setEnabled:NO];
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // enable the tap recognizer when keypad appears on screen
    [recognizer setEnabled:YES];
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(void)showAlertWithTitle:(NSString*)title message: (NSString*)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:act];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
