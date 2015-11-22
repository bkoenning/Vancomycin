//
//  _24HourUrineCollection.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "_24HourUrineCollection.h"


@implementation _24HourUrineCollection

@synthesize urineCr, urineVolume, serumCr;

-(instancetype)init
{
    self = [super initWithTitle:@"24 Hour Urine Collection"];
    [self setUrineCr:[[UrineCreatinine alloc]init]];
    [self setSerumCr:[[SerumCreatinine alloc]init]];
    [self setUrineVolume:[[UrineVolume alloc]initWithFloat:0 andUnits:L]];
    [self setIsSet:NO];
    return  self;
}

-(NSString*)tableDescription
{
    NSMutableString *string = [NSMutableString stringWithString:@"Data entered:\n"];
    [string appendString:@"Serum creatinine:  "];
    if (![self serumCr]){
        [string appendString:@"null"];
    }
    [string appendString:[[self serumCr]description]];
    [string appendString:@"\nUrine creatinine:  "];
    [string appendString:[[self urineCr]description]];
    [string appendString:@"\nUrine Volume:  "];
    [string appendString:[[self urineVolume]description]];
    [string appendString:@"\nDerived data:"];
    [string appendString:@"\nCreatinine excreted:  "];
    [string appendString:[[self creatinineExcreted]description]];
    [string appendString:@"\nCreatinine clearance:  "];
    [string appendString:[[self creatinineClearance]description]];
    return [NSString stringWithString:string];
}

-(Creatinine*)creatinineExcreted
{
    if ([[[self urineCr]mol]returnAsMolar]){
        Molecule *num = [[self urineCr]withVolume:[self urineVolume]];
        num = [num convertedToMolarUnit:MILLIMOL];
        return  [[Creatinine alloc]initWithMolarFloat:[[num molarAmount]floatValue] molarUnit:[num molarunit]];
        
    }
    else{
        Molecule *num = [[self urineCr]withVolume:[self urineVolume]];
        num = [num convertedToMassUnit:MILLIGRAM];
        return [[Creatinine alloc]initWithMassFloat:[[num massAmount]floatValue] massUnit:[num massunit]];
    }
}

-(CreatinineClearance*)creatinineClearance
{
    Concentration *ucr = [[self urineCr]convertedToMassUnit:MILLIGRAM andVolumeUnit:DL];
    ucr = [ucr reduced];
    Volume *urineVol = [[self urineVolume]convertedToVolumeUnit:ML];
    Concentration *scr = [[self serumCr]convertedToMassUnit:MILLIGRAM andVolumeUnit:DL];
    scr = [scr reduced];
    float flow = ([[[ucr mol]massAmount]floatValue] * ([[urineVol volume]floatValue] / 1440.0)) / [[[scr mol]massAmount]floatValue];
    
    return  [[CreatinineClearance alloc]initWithVolume:[[Volume alloc]initWithFloat:flow andUnits:ML] andTime:[[Time alloc]initWithFloat:1.0 andTimeUnit:MINUTE]];
    
    
    
    
    
    //CreatinineConcentration *ucr = [[self urineCr]convertedToMassUnit:MILLIGRAM andVolumeUnit:DL];
}



@end
