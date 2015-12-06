//
//  SingleValueSerumCreatinineViewController.m
//  Vancomycin
//
//  Created by Brandon Koenning on 11/19/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "SingleValueSerumCreatinineViewController.h"

@interface SingleValueSerumCreatinineViewController()
{
    UITapGestureRecognizer *screenRecognizer;
    UITapGestureRecognizer *cockcroftGaultLabelRecognizer, *mdrdLabelRecognizer1, *mdrdLabelRecognizer2,
        *ckdepiLabelRecognizer1, *ckdepiLabelRecognizer2;
    BOOL isCockcroftGault, isMDRD, isCKDEPI;
    NSString *checkboxFull, *checkBoxEmpty;
    NSMutableArray *enabledViews;
    
}

-(void)configureView;
-(void)updateCKDEPIFromLabel2;
-(void)updateCKDEPIFromLabel1;
-(void)updateCockcroftGaultFromLabel;
-(void)updateMDRDFromLabel1;
-(void)updateMDRDFromLabel2;
@end




@implementation SingleValueSerumCreatinineViewController

@synthesize detailItem, segmentAlbumin, segmentBUN, segmentRace, segmentSerumCreatinine, textFieldAlbumin, textFieldBUN, textFieldSerumCreatinine, buttonCKDEPI, buttonCockcroftGault, buttonMDRD;

-(void)viewDidLoad
{
    checkBoxEmpty =@"checkboxempty";
    checkboxFull = @"checkboxfull";
    enabledViews = [NSMutableArray arrayWithObjects:segmentSerumCreatinine, segmentAlbumin, segmentBUN, segmentRace, textFieldSerumCreatinine, textFieldAlbumin, textFieldBUN, buttonCKDEPI, buttonCockcroftGault, buttonMDRD, nil];
    screenRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    cockcroftGaultLabelRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateCockcroftGaultFromLabel)];
    mdrdLabelRecognizer1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateMDRDFromLabel1)];
    mdrdLabelRecognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateMDRDFromLabel2)];
    ckdepiLabelRecognizer1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateCKDEPIFromLabel1)];
    ckdepiLabelRecognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateCKDEPIFromLabel2)];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




-(BOOL)shouldAutorotate
{
    return  NO;
}

-(void)updateCKDEPI:(id)sender
{
    if (!isCKDEPI){
        isCKDEPI = YES;
        [buttonCKDEPI setImage:[UIImage imageNamed:checkboxFull] forState:UIControlStateNormal];
    }
    else{
        isCKDEPI = NO;
        [buttonCKDEPI setImage: [UIImage imageNamed:checkBoxEmpty] forState:UIControlStateNormal];
    }
}

-(void)updateCKDEPIFromLabel1
{
    if (!isCKDEPI && [buttonCKDEPI isEnabled]){
        isCKDEPI = YES;
        [buttonCKDEPI setImage:[UIImage imageNamed:checkboxFull] forState:UIControlStateNormal];
    }
    else if (isCKDEPI && [buttonCKDEPI isEnabled]){
        isCKDEPI = NO;
        [buttonCKDEPI setImage:[UIImage imageNamed:checkBoxEmpty] forState:UIControlStateNormal];
    }
}

-(void)updateCKDEPIFromLabel2
{
    if (!isCKDEPI && [buttonCKDEPI isEnabled]){
        isCKDEPI = YES;
        [buttonCKDEPI setImage:[UIImage imageNamed:checkboxFull] forState:UIControlStateNormal];
    }
    else if (isCKDEPI && [buttonCKDEPI isEnabled]){
        isCKDEPI = NO;
        [buttonCKDEPI setImage:[UIImage imageNamed:checkBoxEmpty] forState:UIControlStateNormal];
    }
}

-(void)updateCockcroftGault:(id)sender
{
    if (!isCockcroftGault){
        isCockcroftGault = YES;
        [buttonCockcroftGault setImage:[UIImage imageNamed:checkboxFull] forState:UIControlStateNormal];
    }
    else{
        isCockcroftGault = NO;
        [buttonCockcroftGault setImage:[UIImage imageNamed:checkBoxEmpty] forState:UIControlStateNormal];
    }
}
-(void)updateCockcroftGaultFromLabel
{
    if (!isCockcroftGault && [buttonCockcroftGault isEnabled]){
        isCockcroftGault = YES;
        [buttonCockcroftGault setImage:[UIImage imageNamed:checkboxFull] forState:UIControlStateNormal];
    }
    else if (isCockcroftGault && [buttonCockcroftGault isEnabled]){
        isCockcroftGault = NO;
        [buttonCockcroftGault setImage:[UIImage imageNamed:checkBoxEmpty] forState:UIControlStateNormal];
    }
}

-(void)updateMDRD:(id)sender
{
    if (!isMDRD){
        isMDRD = YES;
        [buttonMDRD setImage:[UIImage imageNamed:checkboxFull] forState:UIControlStateNormal];
    }
    else{
        isMDRD = NO;
        [buttonMDRD setImage:[UIImage imageNamed:checkBoxEmpty] forState:UIControlStateNormal];
    }
}

-(void)updateMDRDFromLabel1
{
    if (!isMDRD && [buttonMDRD isEnabled]){
        isMDRD = YES;
        [buttonMDRD setImage:[UIImage imageNamed:checkboxFull] forState:UIControlStateNormal];
    }
    else if (isMDRD && [buttonMDRD isEnabled]){
        isMDRD = NO;
        [buttonMDRD setImage:[UIImage imageNamed:checkBoxEmpty] forState:UIControlStateNormal];
    }
}

-(void)updateMDRDFromLabel2
{
    if (!isMDRD && [buttonMDRD isEnabled]){
        isMDRD = YES;
        [buttonMDRD setImage:[UIImage imageNamed:checkboxFull] forState:UIControlStateNormal];
    }
    else if (isMDRD && [buttonMDRD isEnabled]){
        isMDRD = NO;
        [buttonMDRD setImage:[UIImage imageNamed:checkBoxEmpty] forState:UIControlStateNormal];
    }
}


-(void)setDetailItem: (SingleSerumCreatinineInformation*)newDetailItem
{
    if (newDetailItem != nil && [self detailItem] != newDetailItem){
        detailItem = newDetailItem;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [screenRecognizer setEnabled:NO];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [screenRecognizer setEnabled:YES];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}




-(void)hideKeyboard
{
    [textFieldSerumCreatinine resignFirstResponder];
    [textFieldAlbumin resignFirstResponder];
    [textFieldBUN resignFirstResponder];
    [screenRecognizer
    setEnabled:NO];
}

-(void)configureView
{
    
}

-(void)lock:(id)sender
{
    
    NSString *titleMessage, *alertMessage;
    BOOL dataOK = YES;
    if ([[[[self buttonSubmit]titleLabel]text] isEqualToString:@"Unlock Data"]){
        for (UIControl *con in enabledViews){
            [con setEnabled:YES];
        }
        [[self detailItem]setIsSet:NO];
        [[self detailItem]postDidChangeNotification];
        [[[self buttonSubmit]titleLabel]setText:@"Lock Data"];
        dataOK = NO;
    }
    if (!isMDRD && !isCKDEPI && !isCockcroftGault && dataOK){
        titleMessage = @"No method of calculation was selected.";
        alertMessage = @"Choose one or more options for method of calculation.";
        dataOK = NO;
    }
    if (isMDRD && dataOK){
        if ([segmentRace selectedSegmentIndex] == UISegmentedControlNoSegment){
            dataOK = NO;
            titleMessage = @"Race is a required selection for the MDRD equation.";
            alertMessage = @"Select YES or NO for African race or deselect MDRD.";
        }
        if ([segmentAlbumin selectedSegmentIndex] == UISegmentedControlNoSegment && dataOK){
            dataOK = NO;
            titleMessage = @"Albumin is a required value for the MDRD equation.";
            alertMessage = @"Select a unit of measure for albumin.";
        }
        if ([segmentBUN selectedSegmentIndex] == UISegmentedControlNoSegment && dataOK){
            dataOK = NO;
            titleMessage =@"BUN is a required value for the MDRD equation.";
            alertMessage = @"Select a unit of measure for BUN.";
        }
        if ([segmentBUN ])
        
        
    }
    if (isCKDEPI && dataOK && [segmentRace selectedSegmentIndex] == UISegmentedControlNoSegment){
        titleMessage =@"Race is a required selection for the CKD-EPI equation.";
        alertMessage =@"Select YES or NO for African race or deselect CKD-EPI.";
        dataOK = NO;
    }
    
    
    
    

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleMessage message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
                                
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:act];
    [self presentViewController:alert animated:YES completion:nil];
}




@end
