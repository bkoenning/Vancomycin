//
//  BasicInformationViewController.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "BasicInformationViewController.h"
#import "BasicInformation.h"

@interface BasicInformationViewController ()
{
    BOOL lll,lul,lua,lla,rll,rul,rua,rla;
    NSString *checkboxfull;
    NSString *checkboxempty;
    BOOL lua_checked_first, rua_checked_first, lul_checked_first, rul_checked_first;
    NSMutableArray *enabledViews;
    UITapGestureRecognizer *recognizer;
    UITapGestureRecognizer *recognizerLLA, *recognizerLUA, *recognizerLLL, *recognizerLUL,
        *recognizerRUL, *recognizerRUA, *recognizerRLL, *recognizerRLA;
}
-(void)configureView;
-(void)updateRUAFromLabel;
-(void)updateRULFromLabel;
-(void)updateRLAFromLabel;
-(void)updateRLLFromLabel;
-(void)updateLLLFromLabel;
-(void)updateLLAFromLabel;
-(void)updateLUAFromLabel;
-(void)updateLULFromLabel;
@end

@implementation BasicInformationViewController

@synthesize segGender,segHeightUnits,segWeightUnits,buttonLLArm,buttonLLLeg,buttonLUArm,
buttonLULeg,buttonRLArm,buttonRLLeg,buttonRUArm,buttonRULeg,textFieldAge,textFieldHeight,textFieldWeight,buttonValidate,detailItem, labelLLArm, labelLLLeg, labelLUArm, labelLULeg, labelRLArm, labelRLLeg, labelRUArm, labelRULeg;

-(BOOL)shouldAutorotate
{
    return  NO;
}

-(void)dealloc
{
    segGender = nil;
    segHeightUnits = nil;
    segWeightUnits = nil;
    buttonLLArm = nil;
    buttonLLLeg = nil;
    buttonLUArm = nil;
    buttonLULeg = nil;
    buttonRLArm = nil;
    buttonRLLeg = nil;
    buttonRUArm = nil;
    buttonRULeg = nil;
    textFieldAge = nil;
    textFieldHeight = nil;
    textFieldWeight = nil;
    buttonValidate = nil;
    detailItem = nil;
    checkboxempty = nil;
    checkboxfull = nil;
    enabledViews = nil;
    recognizer = nil;
}

-(void)setDetailItem:(BasicInformation*)newDetailItem
{
    if (newDetailItem != nil && [self detailItem] != newDetailItem){
        detailItem = newDetailItem;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    checkboxempty = @"checkbox_empty";
    checkboxfull = @"checkbox_full";
    enabledViews = [NSMutableArray arrayWithObjects: segGender, segHeightUnits,segWeightUnits,
                    textFieldWeight, textFieldAge, textFieldHeight, buttonLLArm, buttonLLLeg,
                    buttonLUArm, buttonLULeg, buttonRLArm, buttonRLLeg, buttonRUArm, buttonRULeg,nil];
    
    [self configureView];
    recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    recognizerLLA = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateLLAFromLabel)];
    [labelLLArm addGestureRecognizer:recognizerLLA];
    
    recognizerLUA = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateLUAFromLabel)];
    [labelLUArm addGestureRecognizer:recognizerLUA];
    
    recognizerLLL = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateLLLFromLabel)];
    [labelLLLeg addGestureRecognizer:recognizerLLL];
    
    recognizerLUL = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateLULFromLabel)];
    [labelLULeg addGestureRecognizer:recognizerLUL];
    
    recognizerRLA = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateRLAFromLabel)];
    [labelRLArm addGestureRecognizer:recognizerRLA];
    
    recognizerRLL = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateRLLFromLabel)];
    [labelRLLeg addGestureRecognizer:recognizerRLL];
    
    recognizerRUA = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateRUAFromLabel)];
    [labelRUArm addGestureRecognizer:recognizerRUA];
    
    recognizerRUL = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateRULFromLabel)];
    [labelRULeg addGestureRecognizer:recognizerRUL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)configureView
{
    if (detailItem != nil){
        if ([[self detailItem]isSet]){
            [[self buttonValidate]setTitle:@"Unlock Information" forState:UIControlStateNormal];
            [[self textFieldHeight]setText:[[[self detailItem]height]valueAsString]];
            [[self textFieldWeight]setText:[[[self detailItem]weight]valueAsString]];
            [[self textFieldAge]setText: [[[self detailItem]age]valueAsString]];
            if ([[[self detailItem]gender]gender] =='f')
                [[self segGender]setSelectedSegmentIndex:1];
            
            else if ([[[self detailItem]gender]gender] =='m')
                [[self segGender]setSelectedSegmentIndex:0];
            
            if ([[[self detailItem]weight]units]== KG)
                [[self segWeightUnits]setSelectedSegmentIndex:0];
            
            else if ([[[self detailItem]weight]units]== LB)
                [[self segWeightUnits]setSelectedSegmentIndex:1];
            
            if ([[[self detailItem]height]units] == CM)
                [[self segHeightUnits]setSelectedSegmentIndex:0];
            
            else if ([[[self detailItem]height]units] == IN)
                [[self segHeightUnits]setSelectedSegmentIndex:1];
            
            if ([[[[self detailItem]amputations]amps]valueForKey:@"right_upper_leg"] == [NSNumber numberWithBool:YES]){
                [[self buttonRULeg]setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
                rul = YES;
                rul_checked_first = YES;
            }
            if ([[[[self detailItem]amputations]amps]valueForKey:@"left_upper_leg"] == [NSNumber numberWithBool:YES]){
                [[self buttonLULeg]setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
                lul = YES;
                lul_checked_first = YES;
            }
            if ([[[[self detailItem]amputations]amps]valueForKey:@"left_lower_leg"]== [NSNumber numberWithBool:YES]){
                [[self buttonLLLeg]setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
                lll = YES;
            }
            if ([[[[self detailItem]amputations]amps]valueForKey:@"right_lower_leg"] == [NSNumber numberWithBool:YES]){
                [[self buttonRLLeg]setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
                rll = YES;
            }
            if ([[[[self detailItem]amputations]amps]valueForKey:@"left_upper_arm"]== [NSNumber numberWithBool:YES]){
                [[self buttonLUArm]setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
                lua = YES;
                lua_checked_first = YES;
            }
            if ([[[[self detailItem]amputations]amps]valueForKey:@"left_lower_arm"]== [NSNumber numberWithBool:YES]){
                [[self buttonLLArm]setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
                lla = YES;
            }
            if ([[[[self detailItem]amputations]amps]valueForKey:@"right_upper_arm"] == [NSNumber numberWithBool:YES]){
                [[self buttonRUArm]setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
                rua = YES;
                rua_checked_first = YES;
            }
            if ([[[[self detailItem]amputations]amps]valueForKey:@"right_lower_arm"]== [NSNumber numberWithBool:YES]){
                [[self buttonRLArm]setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
                rla = YES;
            }
            for (UIControl* con in enabledViews){
                [con setEnabled:NO];
            }
        }
    }
}

-(IBAction)updateLUA:(id)sender
{
    if (!lua){
        [buttonLUArm setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        [buttonLLArm setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        [buttonLLArm setEnabled:NO];
        
        if (!lla){
            lua_checked_first = YES;
            lla = YES;
        }
        else
            lua_checked_first = NO;
        lua = YES;
    }
    else if (lua){
        [buttonLUArm setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
        [buttonLLArm setEnabled:YES];
        lua = NO;
        if (lua_checked_first){
            [buttonLLArm setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
            lla = NO;
            lua_checked_first = NO;
        }
    }
}
-(void)updateLUAFromLabel
{
    if (!lua && [buttonLUArm isEnabled]){
        [buttonLUArm setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        [buttonLLArm setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        [buttonLLArm setEnabled:NO];
        
        if (!lla){
            lua_checked_first = YES;
            lla = YES;
        }
        else
            lua_checked_first = NO;
        lua = YES;
    }
    else if (lua && [buttonLUArm isEnabled]){
        [buttonLUArm setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
        [buttonLLArm setEnabled:YES];
        lua = NO;
        if (lua_checked_first){
            [buttonLLArm setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
            lla = NO;
            lua_checked_first = NO;
        }
    }
}

-(IBAction)updateRUA:(id)sender
{
    if (!rua){
        [buttonRUArm setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        [buttonRLArm setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        [buttonRLArm setEnabled:NO];
        if (!rla){
            rua_checked_first = YES;
            rla = YES;
        }
        else
            rua_checked_first = NO;
        rua = YES;
    }
    else if (rua){
        [buttonRUArm setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
        [buttonRLArm setEnabled:YES];
        rua = NO;
        if (rua_checked_first){
            [buttonRLArm setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
            rla = NO;
            rua_checked_first = NO;
        }
    }
}
-(void)updateRUAFromLabel
{
    if (!rua && [buttonRUArm isEnabled]){
        [buttonRUArm setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        [buttonRLArm setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        [buttonRLArm setEnabled:NO];
        if (!rla){
            rua_checked_first = YES;
            rla = YES;
        }
        else
            rua_checked_first = NO;
        rua = YES;
    }
    else if (rua && [buttonRUArm isEnabled]){
        [buttonRUArm setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
        [buttonRLArm setEnabled:YES];
        rua = NO;
        if (rua_checked_first){
            [buttonRLArm setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
            rla = NO;
            rua_checked_first = NO;
        }
    }
}

-(IBAction)updateRUL:(id)sender
{
    if (!rul){
        [buttonRULeg setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        [buttonRLLeg setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        [buttonRLLeg setEnabled:NO];
        if (!rll){
            rul_checked_first = YES;
            rll = YES;
        }
        else
            rul_checked_first = NO;
        rul = YES;
    }
    else if (rul){
        [buttonRULeg setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
        [buttonRLLeg setEnabled:YES];
        rul = NO;
        if (rul_checked_first){
            [buttonRLLeg setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
            rll = NO;
            rul_checked_first = NO;
        }
    }
}

-(void)updateRULFromLabel
{
    if (!rul && [buttonRULeg isEnabled]){
        [buttonRULeg setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        [buttonRLLeg setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        [buttonRLLeg setEnabled:NO];
        if (!rll){
            rul_checked_first = YES;
            rll = YES;
        }
        else
            rul_checked_first = NO;
        rul = YES;
    }
    else if (rul && [buttonRULeg isEnabled]){
        [buttonRULeg setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
        [buttonRLLeg setEnabled:YES];
        rul = NO;
        if (rul_checked_first){
            [buttonRLLeg setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
            rll = NO;
            rul_checked_first = NO;
        }
    }
}

-(IBAction)updateLUL:(id)sender
{
    if (!lul){
        [buttonLULeg setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        [buttonLLLeg setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        [buttonLLLeg setEnabled:NO];
        if (!lll){
            lul_checked_first = YES;
            lll = YES;
        }
        else
            lul_checked_first = NO;
        lul = YES;
        
    }
    else if (lul){
        [buttonLULeg setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
        [buttonLLLeg setEnabled: YES];
        lul = NO;
        if (lul_checked_first){
            [buttonLLLeg setImage: [UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
            lll = NO;
            lul_checked_first = NO;
        }
    }
}
-(void)updateLULFromLabel
{
    if (!lul && [buttonLULeg isEnabled]){
        [buttonLULeg setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        [buttonLLLeg setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        [buttonLLLeg setEnabled:NO];
        if (!lll){
            lul_checked_first = YES;
            lll = YES;
        }
        else
            lul_checked_first = NO;
        lul = YES;
        
    }
    else if (lul && [buttonLULeg isEnabled]){
        [buttonLULeg setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
        [buttonLLLeg setEnabled: YES];
        lul = NO;
        if (lul_checked_first){
            [buttonLLLeg setImage: [UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
            lll = NO;
            lul_checked_first = NO;
        }
    }
}

-(IBAction)updateLLL:(id)sender
{
    if (!lll){
        [buttonLLLeg setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        lll = YES;
    }
    else if (lll){
        [buttonLLLeg setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
        lll = NO;
    }
}
-(void)updateLLLFromLabel
{
    if (!lll && [buttonLLLeg isEnabled]){
        [buttonLLLeg setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        lll = YES;
    }
    else if (lll && [buttonLLLeg isEnabled]){
        [buttonLLLeg setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
        lll = NO;
    }
}

-(IBAction)updateRLL:(id)sender
{
    if (!rll){
        [buttonRLLeg setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        rll = YES;
    }
    else if (rll){
        [buttonRLLeg setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
        rll = NO;
    }
}
-(void)updateRLLFromLabel
{
    if (!rll && [buttonRLLeg isEnabled]){
        [buttonRLLeg setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        rll = YES;
    }
    else if (rll && [buttonRLLeg isEnabled]){
        [buttonRLLeg setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
        rll = NO;
    }
}
-(IBAction)updateLLA:(id)sender
{
    if (!lla){
        [buttonLLArm setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        lla = YES;
    }
    else if (lla){
        [buttonLLArm setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
        lla = NO;
    }
}
-(void)updateLLAFromLabel
{
    if (!lla && [buttonLLArm isEnabled]){
        [buttonLLArm setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        lla = YES;
    }
    else if (lla && [buttonLLArm isEnabled]){
        [buttonLLArm setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
        lla = NO;
    }
    
}
-(IBAction)updateRLA:(id)sender
{
    if (!rla){
        [buttonRLArm setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        rla = YES;
    }
    else if (rla){
        [buttonRLArm setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
        rla = NO;
    }
}
-(void)updateRLAFromLabel
{
    if (!rla && [buttonRLArm isEnabled]){
        [buttonRLArm setImage:[UIImage imageNamed:checkboxfull] forState:UIControlStateNormal];
        rla = YES;
    }
    else if (rla && [buttonRLArm isEnabled]){
        [buttonRLArm setImage:[UIImage imageNamed:checkboxempty] forState:UIControlStateNormal];
        rla = NO;
    }
}
-(IBAction)validateAndLockInformation:(id)sender{
    NSRegularExpression *decimalReg = [NSRegularExpression regularExpressionWithPattern:@"^\\d{2,3}(\\.\\d{1,5}?)?$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSRegularExpression *integerReg = [NSRegularExpression regularExpressionWithPattern:@"^\\d{1,3}$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *weightMatch = [decimalReg firstMatchInString:[self.textFieldWeight text] options:0 range:NSMakeRange(0, [[self.textFieldWeight text]length])];
    NSTextCheckingResult *heightMatch = [decimalReg firstMatchInString:[self.textFieldHeight text] options:0 range:NSMakeRange(0, [[self.textFieldHeight text]length])];
    NSTextCheckingResult *ageMatch = [integerReg firstMatchInString:[self.textFieldAge text] options:0 range:NSMakeRange(0, [[self.textFieldAge text]length])];
    
    BOOL isWeightMatch = weightMatch != nil;
    BOOL isHeightMatch = heightMatch != nil;
    BOOL isAgeMatch = ageMatch != nil;
    
    if ([[[[self buttonValidate]titleLabel]text] isEqualToString:@"Unlock Information"]){
        for (UIControl* con in enabledViews){
            [con setEnabled:YES];
        }
        
        if (lul_checked_first) [[self buttonLLLeg]setEnabled:NO];
        if (rul_checked_first) [[self buttonRLLeg]setEnabled:NO];
        if (rua_checked_first) [[self buttonRLArm]setEnabled:NO];
        if (lua_checked_first) [[self buttonLLArm] setEnabled:NO];
        
        [[self buttonValidate]setTitle:@"Lock Information" forState:UIControlStateNormal];
        [[self detailItem]setIsSet:NO];
        [[self detailItem] postDidChangeNotification];
    }
    else if (!isWeightMatch){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid entry for weight" message:@"Re-enter weight" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else if (!isHeightMatch){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid entry for height" message:@"Re-enter height" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([[self segHeightUnits]selectedSegmentIndex] == UISegmentedControlNoSegment){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No units for height selected" message:@"Select a unit for height" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([[ self segWeightUnits]selectedSegmentIndex] == UISegmentedControlNoSegment){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No units for weight selected" message:@"Select a unit for weight" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if ([[ self segGender] selectedSegmentIndex] == UISegmentedControlNoSegment){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Gender not selected" message:@"Select a gender" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if (!isAgeMatch){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Age contains an invalid number format" message:@"Re-enter age" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (isAgeMatch && ([[self.textFieldAge text]longLongValue] < 18L || [[self.textFieldAge text] longLongValue] > 105L )){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Age is out of range" message:@"Age must be between 18 and 105 years" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else if (isWeightMatch && [self.segWeightUnits selectedSegmentIndex] ==1 && ([[self.textFieldWeight text]floatValue] < 77 ||
                                                                                 [[self.textFieldWeight text]floatValue] > 374)){
        //  UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Weight must be between 77 and 374 pounds" message:@"Weight is invalid" delegate:self cancelButtonTitle:@"Re-enter with a valid weight" otherButtonTitles:nil];
        //[alert show];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Weight is out of range" message:@"Weight must be between 77 and 374 pounds" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (isWeightMatch && [self.segWeightUnits selectedSegmentIndex] == 0 && ([[self.textFieldWeight text]floatValue] < 35 ||
                                                                                  [[self.textFieldWeight text]floatValue] > 170)){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Weight is out of range" message:@"Weight must be between 35 and 170 pounds" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (isHeightMatch && [self.segHeightUnits selectedSegmentIndex] == 1 && ([[self.textFieldHeight text]floatValue] < 60 ||
                                                                                  [[self.textFieldHeight text]floatValue] > 90)){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Height is out of range" message:@"Height must be between 60 and 90 inches" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (isHeightMatch && [self.segHeightUnits selectedSegmentIndex] == 0 && ([[self.textFieldHeight text]floatValue] < 152.4 ||
                                                                                  [[self.textFieldHeight text]floatValue] > 228.6)){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Height is out of range" message:@"Height must be between 152.4 and 228.6 centimeters" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([[[[self buttonValidate]titleLabel]text]isEqualToString:@"Lock Information"] && ![[self detailItem]isSet]){
        [[self detailItem]setIsSet:YES];
        if ([[self segWeightUnits]selectedSegmentIndex] == 0){
            [[self detailItem]setWeight:[[Weight alloc]initWithFloat:[[[self textFieldWeight]text]floatValue] unit:KG]];
        }
        else{
            [[self detailItem]setWeight:[[Weight alloc]initWithFloat:[[[self textFieldWeight]text]floatValue] unit:LB]];
        }
        if ([[self segHeightUnits]selectedSegmentIndex] == 0){
            [[self detailItem]setHeight:[[Height alloc]initWithFloat:[[[self textFieldHeight]text]floatValue] unit:CM]];
        }
        //if ([[self segHeightUnits]selectedSegmentIndex] == 0){
        else
            [[self detailItem]setHeight:[[Height alloc]initWithFloat:[[[self textFieldHeight]text]floatValue] unit:IN]];
       // }
        if ([[self segGender]selectedSegmentIndex]==0){
            [[self detailItem]setGender:[[Gender alloc]initWithChar:'m']];
        }
        else{
            [[self detailItem]setGender:[[Gender alloc]initWithChar:'f']];
        }
        [[self detailItem]setAge:[[Age alloc]initWithInteger:(int)[[[self textFieldAge]text]integerValue]]];
        
        [[self detailItem]setAmputations:[[Amputations alloc]initWithAmputationBoolValues_left_lower_leg:lll left_upper_leg:lul left_lower_arm:lla left_upper_arm:lua right_lower_leg:rll right_upper_leg:rul right_upper_arm:rua right_lower_arm:rla right_upper_leg_checked_first:rul_checked_first left_upper_leg_checked_first:lul_checked_first right_upper_arm_checked_first:rua_checked_first left_upper_arm_checked_first:lua_checked_first]];
        
        //[[ self detailItem]setWeight:[[Weight alloc]initWithFloat:[[[self textFieldWeight]text]floatValue] unit: (int)[[ self segWeightUnits]selectedSegmentIndex]]];
       // [[ self detailItem] setHeight:[[Height alloc]initWithFloat:[[[self textFieldHeight] text] floatValue] unit: (int)[[ self segHeightUnits]selectedSegmentIndex]]];
        //[[self detailItem]setAge:[[Age alloc]initWithInteger:(int)[[[self textFieldAge]text]integerValue]]];
        //if ([[self segGender]selectedSegmentIndex] == 0)
          //  [[self detailItem]setGender:[[Gender alloc]initWithChar:'m']];
        //else if ([[self segGender]selectedSegmentIndex] == 1)
          //  [[self detailItem]setGender:[[Gender alloc]initWithChar:'f']];
        
        /*
        if (lla)
            [[[[self detailItem]amputations]amps]setValue:[NSNumber numberWithBool:YES] forKey:@"left_lower_arm"];
        else
            [[[[self detailItem]amputations]amps]setValue:[NSNumber numberWithBool:NO] forKey:@"left_lower_arm"];
        if (lua)
            [[[[self detailItem]amputations]amps]setValue:[NSNumber numberWithBool:YES] forKey:@"left_upper_arm"];
        else
            [[[[self detailItem]amputations]amps]setValue:[NSNumber numberWithBool:NO] forKey:@"left_upper_arm"];
        if (lll)
            [[[[self detailItem]amputations]amps]setValue:[NSNumber numberWithBool:YES] forKey:@"left_lower_leg"];
        else
            [[[[self detailItem]amputations]amps]setValue:[NSNumber numberWithBool:NO] forKey:@"left_lower_leg"];
        if (lul)
            [[[[self detailItem]amputations]amps]setValue:[NSNumber numberWithBool:YES] forKey:@"left_upper_leg"];
        else
            [[[[self detailItem]amputations]amps]setValue:[NSNumber numberWithBool:NO] forKey:@"left_upper_leg"];
        
        if (rla)
            [[[[self detailItem]amputations]amps]setValue:[NSNumber numberWithBool:YES] forKey:@"right_lower_arm"];
        else
            [[[[self detailItem]amputations]amps]setValue:[NSNumber numberWithBool:NO] forKey:@"right_lower_arm"];
        if (rua)
            [[[[self detailItem]amputations]amps]setValue:[NSNumber numberWithBool:YES] forKey:@"right_upper_arm"];
        else
            [[[[self detailItem]amputations]amps]setValue:[NSNumber numberWithBool:NO] forKey:@"right_upper_arm"];
        if (rll)
            [[[[self detailItem]amputations]amps]setValue:[NSNumber numberWithBool:YES] forKey:@"right_lower_leg"];
        else
            [[[[self detailItem]amputations]amps]setValue:[NSNumber numberWithBool:NO] forKey:@"right_lower_leg"];
        if (rul)
            [[[[self detailItem]amputations]amps]setValue:[NSNumber numberWithBool:YES] forKey:@"right_upper_leg"];
        else
            [[[[self detailItem]amputations]amps]setValue:[NSNumber numberWithBool:NO] forKey:@"right_upper_leg"];
        if (lua_checked_first) [[[[self detailItem]amputations]checkOrder]setValue:[NSNumber numberWithBool:YES] forKey:@"left_upper_arm_checked_first"];
        else [[[[self detailItem]amputations]checkOrder]setValue:[NSNumber numberWithBool:NO] forKey:@"left_upper_arm_checked_first"];
        if (rua_checked_first) [[[[self detailItem]amputations]checkOrder]setValue:[NSNumber numberWithBool:YES] forKey:@"right_upper_arm_checked_first"];
        else [[[[self detailItem]amputations]checkOrder]setValue:[NSNumber numberWithBool:NO] forKey:@"right_upper_arm_checked_first"];
        if (lul_checked_first) [[[[self detailItem]amputations]checkOrder]setValue:[NSNumber numberWithBool:YES] forKey:@"left_upper_leg_checked_first"];
        else [[[[self detailItem]amputations]checkOrder]setValue:[NSNumber numberWithBool:NO] forKey:@"left_upper_leg_checked_first"];
        if (rul_checked_first) [[[[self detailItem]amputations]checkOrder]setValue:[NSNumber numberWithBool:YES] forKey:@"right_upper_leg_checked_first"];
        else [[[[self detailItem]amputations]checkOrder]setValue:[NSNumber numberWithBool:NO] forKey:@"right_upper_leg_checked_first"];
         */
        
    
        
        
        [[self buttonValidate]setTitle:@"Unlock Information" forState:UIControlStateNormal];
        for (UIControl* con in enabledViews){
            [con setEnabled:NO];
        }
        [[self detailItem]postDidChangeNotification];
        
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [recognizer setEnabled:NO];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [recognizer setEnabled:YES];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)hideKeyboard
{
    [textFieldWeight resignFirstResponder];
    [textFieldAge resignFirstResponder];
    [textFieldHeight resignFirstResponder];
    [recognizer setEnabled:NO];
}

@end
