//
//  DualSerumCreatinineViewController.m
//  Vancomycin
//
//  Created by Brandon Koenning on 11/17/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "DualSerumCreatinineViewController.h"


@interface DualSerumCreatinineViewController (){
    NSMutableArray *enabledViews;   // the view components to be enabled and disabled during locking
    UITapGestureRecognizer *recognizer;  //recognizer to record taps outside the entry area to dismiss keypad
}
@end


@implementation DualSerumCreatinineViewController

@synthesize clearButton,lockButton,informationButton,serumCreatinine1TextField,serumCreatinine2TextField,timeBetweenSerumCreatinineLevelsTextField, detailItem, segSerumCreatinine1, segSerumCreatinine2;


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)setDetailItem: (DualSerumCreatinineInformation*) newDetailItem  //set the information from the top view controller
{
    if (newDetailItem != nil && [self detailItem] != newDetailItem)
        detailItem = newDetailItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // load the array with references to views that can be enabled/disabled
    enabledViews = [NSMutableArray arrayWithObjects:[self segSerumCreatinine1], [self segSerumCreatinine2], [self serumCreatinine1TextField], [self serumCreatinine2TextField],[self timeBetweenSerumCreatinineLevelsTextField],nil];
    // set the view
    [self configureView];
    // set the tap recognizer with the hide keyboard selector
    recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
}

-(void)configureView
{
    // fill in the views with information if the data from the top controller is verified as valid
    if ([[self detailItem]isSet]){
        if ([[[[self detailItem]scr1]mol]returnAsMolar])
            [[self segSerumCreatinine1]setSelectedSegmentIndex:1];
        else
            [[self segSerumCreatinine1]setSelectedSegmentIndex:0];
        if ([[[[self detailItem]scr2]mol]returnAsMolar])
            [[self segSerumCreatinine2]setSelectedSegmentIndex:1];
        else
            [[self segSerumCreatinine2]setSelectedSegmentIndex:0];
        [[self serumCreatinine2TextField]setText:[[[[self detailItem]scr2]mol]valueAsString]];
        [[self serumCreatinine1TextField]setText:[[[[self detailItem]scr1]mol]valueAsString]];
        [[self timeBetweenSerumCreatinineLevelsTextField]setText:[[[self detailItem]timeBetweenLevels]valueAsString]];
        
        
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
    
    
    BOOL dataOK = YES;
    SerumCreatinine *userSCR1, *userSCR2;
    SerumCreatinine *minSCR = [SerumCreatinine minConcentration];
    SerumCreatinine *maxSCR = [SerumCreatinine maxConcentration];
    Time *userTime;
    Time *minTime = [[Time alloc]initWithFloat:6 andTimeUnit:HOUR];
    Time *maxTime = [[Time alloc]initWithFloat:48 andTimeUnit:HOUR];
    
    /* if information is unlockable, set the editing views to enabled, changed to title of the button to indicate
     information can be locked, set the data object to bad data, and notify from the object that data has been set to bad, and exit the method */
    if ([[[[self lockButton]titleLabel]text]isEqualToString:@"Unlock Information"]){
        for (UIControl *con in enabledViews){
            [con setEnabled: YES];
        }
        [[self lockButton]setTitle:@"Lock Information" forState:UIControlStateNormal];
        [[self detailItem]setIsSet:NO];
        [[self detailItem]postDidChangeNotification];
        dataOK = NO;
    }
    if ([[self segSerumCreatinine2]selectedSegmentIndex] == UISegmentedControlNoSegment && dataOK){
        dataOK = NO;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Nothing selected for serum creatinine #2 units" message:@"Select a unit of measure for serum creatinine #2." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    if ([[self segSerumCreatinine1]selectedSegmentIndex] == UISegmentedControlNoSegment && dataOK){
        dataOK = NO;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Nothing selected for serum creatinine #1 units" message:@"Select a unit of measure for serum creatinine #1." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    if ([[self segSerumCreatinine2]selectedSegmentIndex] == 0 && dataOK){
        NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1})?(\\.\\d{1,2}?)?$" options:NSRegularExpressionCaseInsensitive error:nil];
        NSRegularExpression *regA = [NSRegularExpression regularExpressionWithPattern:@"(\\d{1})+" options:NSRegularExpressionCaseInsensitive error:nil];
        NSTextCheckingResult *serumCreatinineMatch = [reg firstMatchInString:[self.serumCreatinine2TextField text] options:0 range:NSMakeRange(0, [[self.serumCreatinine2TextField text]length])];
        NSTextCheckingResult *serumCreatinineMatchA = [regA firstMatchInString:[self.serumCreatinine2TextField text] options:0 range:NSMakeRange(0, [[self.serumCreatinine2TextField text]length])];
        BOOL isSerumCreatinineMatched = serumCreatinineMatch != nil;
        BOOL isSerumCreatinineMatchedA = serumCreatinineMatchA != nil;
        if (!isSerumCreatinineMatched || !isSerumCreatinineMatchedA){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"The entry for serum creatinine #2 is in an invalid format." message:@"Maximum allowable format is #.## and this value must have at least 1 digit" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
            dataOK = NO;
        }
        else{
            userSCR2 = [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMassFloat:[[[self serumCreatinine2TextField]text]floatValue] massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1 andUnits:DL]];
            minSCR = [minSCR convertedToMassUnit:MILLIGRAM andVolumeUnit:DL];
            maxSCR = [maxSCR convertedToMassUnit:MILLIGRAM andVolumeUnit:DL];
        }
    }
    if ([[self segSerumCreatinine1]selectedSegmentIndex] == 0 && dataOK){
        NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1})?(\\.\\d{1,2}?)?$" options:NSRegularExpressionCaseInsensitive error:nil];
        NSRegularExpression *regA = [NSRegularExpression regularExpressionWithPattern:@"(\\d{1})+" options:NSRegularExpressionCaseInsensitive error:nil];
        NSTextCheckingResult *serumCreatinineMatch = [reg firstMatchInString:[self.serumCreatinine1TextField text] options:0 range:NSMakeRange(0, [[self.serumCreatinine1TextField text]length])];
        NSTextCheckingResult *serumCreatinineMatchA = [regA firstMatchInString:[self.serumCreatinine1TextField text] options:0 range:NSMakeRange(0, [[self.serumCreatinine1TextField text]length])];
        BOOL isSerumCreatinineMatched = serumCreatinineMatch != nil;
        BOOL isSerumCreatinineMatchedA = serumCreatinineMatchA != nil;
        if (!isSerumCreatinineMatched || !isSerumCreatinineMatchedA){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"The entry for serum creatinine #1 is in an invalid format." message:@"Maximum allowable format is #.## and this value must have at least 1 digit" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
            dataOK = NO;
        }
        else{
            userSCR1 = [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMassFloat:[[[self serumCreatinine1TextField]text]floatValue] massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1 andUnits:DL]];
            minSCR = [minSCR convertedToMassUnit:MILLIGRAM andVolumeUnit:DL];
            maxSCR = [maxSCR convertedToMassUnit:MILLIGRAM andVolumeUnit:DL];
        }
    }
    if ([[self segSerumCreatinine2]selectedSegmentIndex] == 1 && dataOK){
        NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{2,3})(\\.\\d{1,2}?)?$" options:NSRegularExpressionCaseInsensitive error:nil];
        NSTextCheckingResult *serumCreatinineMatch = [reg firstMatchInString:[self.serumCreatinine2TextField text] options:0 range:NSMakeRange(0, [[self.serumCreatinine2TextField text]length])];
        BOOL isSerumCreatinineMatched = serumCreatinineMatch != nil;
        if (!isSerumCreatinineMatched){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"The entry for serum creatinine #2 is in an invalid format." message:@"Maximum allowable numeric format is ###.## and this value must have at least 2 whole number places." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
            dataOK = NO;
        }
        else{
            userSCR2 = [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMolarFloat:[[[self serumCreatinine2TextField]text]floatValue] molarUnit:MICROMOL] andVolume:[[Volume alloc]initWithFloat:1 andUnits:L]];
            minSCR = [minSCR convertedToMolarUnit:MICROMOL andVolumeUnit:L];
            maxSCR = [maxSCR convertedToMolarUnit:MICROMOL andVolumeUnit:L];
        }
    }
    if ([[self segSerumCreatinine1]selectedSegmentIndex] == 1 && dataOK){
        NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{2,3})(\\.\\d{1,2}?)?$" options:NSRegularExpressionCaseInsensitive error:nil];
        NSTextCheckingResult *serumCreatinineMatch = [reg firstMatchInString:[self.serumCreatinine1TextField text] options:0 range:NSMakeRange(0, [[self.serumCreatinine1TextField text]length])];
        BOOL isSerumCreatinineMatched = serumCreatinineMatch != nil;
        if (!isSerumCreatinineMatched){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"The entry for serum creatinine #1 is in an invalid format." message:@"Maximum allowable numeric format is ###.## and this value must have at least 2 whole number places." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
            dataOK = NO;
        }
        else{
            userSCR1 = [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMolarFloat:[[[self serumCreatinine1TextField]text]floatValue] molarUnit:MICROMOL] andVolume:[[Volume alloc]initWithFloat:1 andUnits:L]];
            minSCR = [minSCR convertedToMolarUnit:MICROMOL andVolumeUnit:L];
            maxSCR = [maxSCR convertedToMolarUnit:MICROMOL andVolumeUnit:L];
        }
    }
    
    if (dataOK){
        NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1,2})(\\.\\d{1,2}?)?$" options:NSRegularExpressionCaseInsensitive error:nil];
        NSTextCheckingResult *timeMatch = [reg firstMatchInString:[[self timeBetweenSerumCreatinineLevelsTextField]text] options:0 range:NSMakeRange(0, [[[self timeBetweenSerumCreatinineLevelsTextField]text]length])];
        BOOL isTimeMatched = timeMatch != nil;
        if (!isTimeMatched){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"The entry for time between levels is in an invalid format." message:@"Maximum allowable numeric format is ##.## and this value must have at least 1 whole number place." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
            dataOK = NO;
        }
        else{
            userTime = [[Time alloc]initWithFloat:[[[self timeBetweenSerumCreatinineLevelsTextField]text]floatValue] andTimeUnit:HOUR];
        }
    }
    
    if (dataOK){
        if (![userTime isInRangeLower:minTime upper:maxTime]){
            dataOK = NO;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@%@%@%@%@%@", @"The value for time between levels is out of range at ", [userTime description], @".  Time should be between ", [minTime description], @" and ", [maxTime description]] message:@"Verify time." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
        }
        if (![userSCR1 isInRangeLower:minSCR upper:maxSCR] && dataOK){
            dataOK = NO;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@%@%@%@%@%@", @"The value for serum creatinine #1 is out of range at ", [userSCR1 description], @".  Serum creatinine values should be between ", [minSCR description], @" and ", [maxSCR description]] message:@"Verify serum creatinine #1." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
        }
        if (![userSCR2 isInRangeLower:minSCR upper:maxSCR] && dataOK){
            dataOK = NO;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@%@%@%@%@%@", @"The value for serum creatinine #2 is out of range at ", [userSCR2 description], @".  Serum creatinine values should be between ", [minSCR description], @" and ", [maxSCR description]] message:@"Verify serum creatinine #2." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    if (dataOK){
        [[self detailItem]setScr1:userSCR1];
        [[self detailItem]setScr2:userSCR2];
        [[self detailItem]setTimeBetweenLevels:userTime];
        [[self detailItem]setIsSet:YES];
        [[self detailItem]postDidChangeNotification];
        [[self lockButton]setTitle:@"Unlock Information" forState:UIControlStateNormal];
        for (UIControl *con in enabledViews){
            [con setEnabled:NO];
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

-(void)hideKeyboard
{
    // dismiss the keypad from the textfield views
    [[self serumCreatinine1TextField]resignFirstResponder];
    [[self serumCreatinine2TextField]resignFirstResponder];
    [[self timeBetweenSerumCreatinineLevelsTextField]resignFirstResponder];
    // disable the recognizer while the keypad is not on screen
    [recognizer setEnabled:NO];
}



@end
