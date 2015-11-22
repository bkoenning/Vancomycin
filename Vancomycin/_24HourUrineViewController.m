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
    
    BOOL dataOK = YES;
    SerumCreatinine *userSCR;
    UrineCreatinine *userUrineCR;
    Creatinine *userCR;
    UrineVolume *userUrineVol;
    
    UrineVolume *maxUrine = [UrineVolume maxDaily];
    UrineVolume *minUrine = [UrineVolume minDaily];
    SerumCreatinine *minSCR = [SerumCreatinine minConcentration];
    SerumCreatinine *maxSCR = [SerumCreatinine maxConcentration];
    Creatinine *minCreat = [UrineCreatinine minDailyExcretion];
    Creatinine *maxCreat = [UrineCreatinine maxDailyExcretion];
    
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
    
    // display an alert to the user if nothing was selected for urine volume units
    if ([[self segUrineVolume]selectedSegmentIndex]== UISegmentedControlNoSegment && dataOK){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Nothing selected for urine volume units" message:@"Select a unit of measure for urine volume." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
        dataOK = NO;
    }
    // display an alert to the user if nothing was selected for urine creatinine units
    if ([[self segUCr]selectedSegmentIndex]== UISegmentedControlNoSegment && dataOK){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Nothing selected for urine creatinine concentration units" message:@"Select a unit of measure for urine creatinine." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
        dataOK = NO;
    }
    // display an alert to the user if nothing was selected for serum creatinine units
    if ([[self segScr]selectedSegmentIndex]== UISegmentedControlNoSegment && dataOK){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Nothing selected for serum creatinine concentration units" message:@"Select a unit of measure for serum creatinine." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
        dataOK = NO;
    }
    // preliminary regex check for urine volume if mL was selected for units
    if ([[self segUrineVolume] selectedSegmentIndex] == 0 && dataOK){
        NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{3,4})(\\.\\d{1,2}?)?$" options:NSRegularExpressionCaseInsensitive error:nil];
        NSTextCheckingResult *urineVolumeMatch = [reg firstMatchInString:[self.urineVolumeText text] options:0 range:NSMakeRange(0, [[self.urineVolumeText text]length])];
        BOOL isUrineVolumeMatched = urineVolumeMatch != nil;
        if (!isUrineVolumeMatched){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"The entry for urine volume is in an invalid format." message:@"Maximum allowable format is #####.## and this value must have at least 3 whole number place values." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
            dataOK = NO;
        }
        else{
            userUrineVol = [[UrineVolume alloc]initWithFloat:[[[self urineVolumeText]text]floatValue] andUnits:ML];
            minUrine = [minUrine converted:ML];
            maxUrine = [maxUrine converted:ML];
        }
    }
    // preliminary regex check for urine volume if L was selected for units
    if ([[self segUrineVolume] selectedSegmentIndex] == 1 && dataOK){
        NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1})?(\\.\\d{1,5}?)?$" options:NSRegularExpressionCaseInsensitive error:nil];
        NSRegularExpression *regA = [NSRegularExpression regularExpressionWithPattern:@"(\\d{1})+" options:NSRegularExpressionCaseInsensitive error:nil];
        NSTextCheckingResult *urineVolumeMatch = [reg firstMatchInString:[self.urineVolumeText text] options:0 range:NSMakeRange(0, [[self.urineVolumeText text]length])];
        NSTextCheckingResult *urineVolumeMatchA = [regA firstMatchInString:[self.urineVolumeText text] options:0 range:NSMakeRange(0, [[self.urineVolumeText text]length])];
        BOOL isUrineVolumeMatched = urineVolumeMatch != nil;
        BOOL isUrineVolumeMatchedA = urineVolumeMatchA != nil;
        if (!isUrineVolumeMatched || !isUrineVolumeMatchedA){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"The entry for urine volume is in an invalid format." message:@"Maximum allowable format is #.##### and this value must have at least 1 digit" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
            dataOK = NO;
        }
        else{
            userUrineVol = [[UrineVolume alloc]initWithFloat:[[[self urineVolumeText]text]floatValue] andUnits:L];
            minUrine = [minUrine converted:L];
            maxUrine = [maxUrine converted:L];
        }
    }

    
    // preliminary regex check for serum creatinine if mg/dL was selected for serum creatinine units, range is 0.20 to 5.50
    if ([[self segScr]selectedSegmentIndex] == 0 && dataOK){
        NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1})?(\\.\\d{1,2}?)?$" options:NSRegularExpressionCaseInsensitive error:nil];
        NSRegularExpression *regA = [NSRegularExpression regularExpressionWithPattern:@"(\\d{1})+" options:NSRegularExpressionCaseInsensitive error:nil];
        NSTextCheckingResult *serumCreatinineMatch = [reg firstMatchInString:[self.serumCrText text] options:0 range:NSMakeRange(0, [[self.serumCrText text]length])];
        NSTextCheckingResult *serumCreatinineMatchA = [regA firstMatchInString:[self.serumCrText text] options:0 range:NSMakeRange(0, [[self.serumCrText text]length])];
        BOOL isSerumCreatinineMatched = serumCreatinineMatch != nil;
        BOOL isSerumCreatinineMatchedA = serumCreatinineMatchA != nil;
        if (!isSerumCreatinineMatched || !isSerumCreatinineMatchedA){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"The entry for serum creatinine is in an invalid format." message:@"Maximum allowable format is #.## and this value must have at least 1 digit" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
            dataOK = NO;
        }
        else{
            userSCR = [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMassFloat:[[[self serumCrText]text]floatValue] massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1 andUnits:DL]];
            minSCR = [minSCR convertedToMassUnit:MILLIGRAM andVolumeUnit:DL];
            maxSCR = [maxSCR convertedToMassUnit:MILLIGRAM andVolumeUnit:DL];
        }
    }
    // preliminary regex check for serum creatinine if micromol/L was selected for serum creatinine units
    if ([[self segScr]selectedSegmentIndex] == 1 && dataOK){
        NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{2,3})(\\.\\d{1,2}?)?$" options:NSRegularExpressionCaseInsensitive error:nil];
        NSTextCheckingResult *serumCreatinineMatch = [reg firstMatchInString:[self.serumCrText text] options:0 range:NSMakeRange(0, [[self.serumCrText text]length])];
        BOOL isSerumCreatinineMatched = serumCreatinineMatch != nil;
        if (!isSerumCreatinineMatched){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"The entry for serum creatinine is in an invalid format." message:@"Maximum allowable numeric format is ###.## and this value must have at least 2 whole number places." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
            dataOK = NO;
        }
        else{
            userSCR = [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMolarFloat:[[[self serumCrText]text]floatValue] molarUnit:MICROMOL] andVolume:[[Volume alloc]initWithFloat:1 andUnits:L]];
            minSCR = [minSCR convertedToMolarUnit:MICROMOL andVolumeUnit:L];
            maxSCR = [maxSCR convertedToMolarUnit:MICROMOL andVolumeUnit:L];
        }
    }
    // preliminary regex check for urine creatinine if mg/dL was selected for urine creatinine units
    if ([[self segUCr] selectedSegmentIndex] == 0 && dataOK){
        NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1,3})(\\.\\d{1,2}?)?$" options:NSRegularExpressionCaseInsensitive error:nil];
        NSTextCheckingResult *urineCreatinineMatch = [reg firstMatchInString:[self.urineCrText text] options:0 range:NSMakeRange(0, [[self.urineCrText text]length])];
        BOOL isUrineCreatinineMatched = urineCreatinineMatch != nil;
        if (!isUrineCreatinineMatched){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"The entry for urine creatinine is in an invalid format." message:@"Maximum allowable format is ###.## and this value must have at least 1 whole number." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
            dataOK = NO;
        }
        else{
            userUrineCR = [[UrineCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMassFloat:[[[self urineCrText]text]floatValue] massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1 andUnits:DL]];
            userCR = [userUrineCR creatinineExcreted:userUrineVol];
            userCR = [userCR convertedToMassUnit:MILLIGRAM];
            minCreat = [minCreat convertedToMassUnit:MILLIGRAM];
            maxCreat = [maxCreat convertedToMassUnit:MILLIGRAM];
        }
    }
    //  preliminary regex check for urine creatinine if micromol/L was selected for urine creatinine units
    if ([[self segUCr] selectedSegmentIndex] ==1 && dataOK){
        NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{3,5})(\\.\\d{1,2}?)?$" options:NSRegularExpressionCaseInsensitive error:nil];
        NSTextCheckingResult *urineCreatinineMatch = [reg firstMatchInString:[self.urineCrText text] options:0 range:NSMakeRange(0, [[self.urineCrText text]length])];
        BOOL isUrineCreatinineMatched = urineCreatinineMatch != nil;
        if (!isUrineCreatinineMatched){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"The entry for urine creatinine is in an invalid format." message:@"Maximum allowable format is #####.## and this value must have at least 3 whole number places" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
            dataOK = NO;
        }
        else{
            userUrineCR = [[UrineCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMolarFloat:[[[self urineCrText]text]floatValue] molarUnit:MICROMOL] andVolume:[[Volume alloc]initWithFloat:1 andUnits:L]];
            userCR = [userUrineCR creatinineExcreted:userUrineVol];
            userCR = [userCR convertedToMolarUnit:MILLIMOL];
            minCreat = [minCreat convertedToMolarUnit:MILLIMOL];
            maxCreat= [maxCreat convertedToMolarUnit:MILLIMOL];
        }
    }
    if (dataOK){
        NSString *messageHeader;
        NSString *messageTail;
        NSString *userValue;
        NSString *argument1;
        NSString *argument2;
        
        if (![userCR isInRangeLower:minCreat upper:maxCreat]){
            messageHeader = @"Creatinine excreted in 24 hours";
            messageTail = @"Verify urine volume and urine creatinine concentration.";
            userValue = [userCR description];
            argument1 = [minCreat description];
            argument2 = [maxCreat description];
        }
        else if (![userSCR isInRangeLower:minSCR upper:maxSCR]){
            messageHeader = @"Serum creatinine";
            messageTail = @"Verify serum creatinine.";
            argument1 = [minSCR description];
            argument2 = [maxSCR description];
            userValue = [userSCR description];
        }
        else if (![userUrineVol isInRangeLower:minUrine upper:maxUrine]){
            messageHeader = @"Urine volume";
            messageTail = @"Verify urine volume.";
            argument1 = [minUrine description];
            argument2 = [maxUrine description];
            userValue = [userUrineVol description];
        }
        
        if (messageTail){
            NSString *message = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@", messageHeader, @" is out of range at ",userValue, @".  ",  @"The range accepted is ", argument1, @" to ", argument2, @"."];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:messageTail preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
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
    
        /*
        if (![userUrineVol isInRangeLower:minUrine upper:maxUrine]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"The entry for urine volume is out of range." message:[NSString stringWithFormat:@"%@%@%@%@", @"Urine volume "] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
            dataOK = NO;
        }
        
    }
    
    
    
    // regex for intial evaluation of creatinine levels, an optional digit 1 to 5 digits in length before an optional decimal point, followed by an optional 1 to 5 digits after the decimal point
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1,5})?(\\.\\d{0,5})?$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *serumCreatinineMatch = [reg firstMatchInString:[self.serumCrText text] options:0 range:NSMakeRange(0, [[self.serumCrText text]length])];
    NSTextCheckingResult *urineCreatinineMatch = [reg firstMatchInString:[self.urineCrText text] options:0 range:NSMakeRange(0, [[self.urineCrText text]length])];
    //NSRegularExpression *urineVolumeReg = [NSRegularExpression regularExpressionWithPattern:@"^\\d{1,5}(\\.\\d{1,5}?)?$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *urineVolumeMatch = [reg firstMatchInString:[self.urineVolumeText text] options:0 range:NSMakeRange(0, [[self.urineVolumeText text]length])];
    
    BOOL isSerumCreatinineMatched = serumCreatinineMatch != nil;
    BOOL isUrineVolumeMatched = urineVolumeMatch != nil;
    BOOL isUrineCreatinineMatched = urineCreatinineMatch != nil;
    
*/
    /*
    else if (!isSerumCreatinineMatched){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid entry for serum creatinine" message:@"Re-enter serum creatinine.  Be sure to enter a leading zero for decimal values less than 1" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (!isUrineCreatinineMatched){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid entry for urine creatinine" message:@"Re-enter urine creatinine.  Be sure to enter a leading zero for decimal values less than 1" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (!isUrineVolumeMatched){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid entry for urine volume" message:@"Re-enter urine volume.  Be sure to enter a leading zero for decimal values less than 1" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }



    else{
        UrineVolume *maxUrine = [UrineVolume maxDaily];
        UrineVolume *minUrine = [UrineVolume minDaily];
        SerumCreatinine *minSCR = [SerumCreatinine minConcentration];
        SerumCreatinine *maxSCR = [SerumCreatinine maxConcentration];
        Creatinine *minCreat = [UrineCreatinine minDailyExcretion];
        Creatinine *maxCreat = [UrineCreatinine maxDailyExcretion];
        
        SerumCreatinine *userSCR;
        UrineCreatinine *userUrineCR;
        Creatinine *userCR;
        UrineVolume *userUrineVol;
        
        if ([[self segScr]selectedSegmentIndex] == 0){
            userSCR = [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMassFloat:[[[self serumCrText]text]floatValue] massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1 andUnits:DL]];
            minSCR = [minSCR convertedToMassUnit:MILLIGRAM andVolumeUnit:DL];
            maxSCR = [maxSCR convertedToMassUnit:MILLIGRAM andVolumeUnit:DL];
        }
        else{
            userSCR = [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMolarFloat:[[[self serumCrText]text]floatValue] molarUnit:MICROMOL] andVolume:[[Volume alloc]initWithFloat:1 andUnits:L]];
            minSCR = [minSCR convertedToMolarUnit:MICROMOL andVolumeUnit:L];
            maxSCR = [maxSCR convertedToMolarUnit:MICROMOL andVolumeUnit:L];
        }
        if ([[self segUrineVolume]selectedSegmentIndex] == 0){
            userUrineVol = [[UrineVolume alloc]initWithFloat:[[[self urineVolumeText]text]floatValue] andUnits:ML];
            maxUrine = [maxUrine converted:ML];
            minUrine = [minUrine converted:ML];
        }
        else{
            userUrineVol = [[UrineVolume alloc]initWithFloat:[[[self urineVolumeText]text]floatValue] andUnits:L];
            maxUrine = [maxUrine converted:L];
            minUrine = [minUrine converted:L];
        }
        
        if ([[self segUCr]selectedSegmentIndex] == 0){
            userUrineCR = [[UrineCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMassFloat:[[[self urineCrText]text]floatValue] massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1 andUnits:DL]];
            minCreat = [minCreat convertedToMassUnit:MILLIGRAM];
            maxCreat = [maxCreat convertedToMassUnit:MILLIGRAM];
            userCR = [userUrineCR creatinineExcreted:userUrineVol];
            userCR = [userCR convertedToMassUnit:MILLIGRAM];
            
        }
        else{
            userUrineCR = [[UrineCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMolarFloat:[[[self urineCrText]text]floatValue] molarUnit:MICROMOL] andVolume:[[Volume alloc]initWithFloat:1 andUnits:L]];
            minCreat = [minCreat convertedToMolarUnit:MILLIMOL];
            maxCreat = [maxCreat convertedToMolarUnit:MILLIMOL];
            userCR = [userUrineCR creatinineExcreted:userUrineVol];
            userCR = [userCR convertedToMolarUnit:MILLIMOL];
        }
        
        if (![userSCR isInRangeLower:minSCR upper:maxSCR]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Out of range value for serum creatinine" message:[NSString stringWithFormat:@"%@%@%@%@%@",@"Serum creatinine must be between ", [minSCR description], @" and " , [maxSCR description], @"."] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else if (![userUrineVol isInRangeLower:minUrine upper:maxUrine]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Out of range value for 24 hour urine volume" message:[NSString stringWithFormat:@"%@%@%@%@", @"Urine volume should be between ", [minUrine description], @" and ", [maxUrine description]] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        else if (![userCR isInRangeLower:minCreat upper:maxCreat]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@%@", @"Total amount of creatinine excreted in 24 hours is ",[userCR description]] message:[NSString stringWithFormat:@"%@%@%@%@%@",@"Total daily excretion of creatinine should be between ", [minCreat description], @" and ", [maxCreat description], @".  Verify urine volume and urine creatinine concentration"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
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
     
    }*/
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

@end
