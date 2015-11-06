//
//  SerumCreatinine.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "SerumCreatinine.h"

@implementation SerumCreatinine

+(SerumCreatinine*)maxConcentration
{
    return [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMassFloat:5.5 massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1 andUnits:DL]];
}

+(SerumCreatinine*)minConcentration
{
    return  [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMassFloat:0.2 massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1 andUnits:DL]];
}

-(SerumCreatinine*)convertedToMassUnit:(MassUnit)mu andVolumeUnit:(VolumeUnit)vu
{
    Concentration *c = [super convertedToMassUnit:mu andVolumeUnit:vu];
    
    return [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMassFloat:[[[c mol]massAmount]floatValue] massUnit:[[c mol]massunit]] andVolume:[[Volume alloc]initWithFloat:1 andUnits:vu]];
    
}
-(SerumCreatinine*)convertedToMolarUnit:(MolarUnit)mu andVolumeUnit:(VolumeUnit)vu
{
    Concentration *c = [super convertedToMolarUnit:mu andVolumeUnit:vu];
    return [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMolarFloat:[[[c mol]molarAmount]floatValue] molarUnit:mu] andVolume:[[Volume alloc]initWithFloat:1 andUnits:vu]];
}




@end
