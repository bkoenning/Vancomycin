//
//  SerumCreatinine.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "SerumCreatinine.h"

@implementation SerumCreatinine

+(SerumCreatinine*)maxConcentrationMass
{
    return [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMassFloat:5.5 massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1 andUnits:DL]];
}

+(SerumCreatinine*)minConcentrationMass
{
    return  [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMassFloat:0.2 massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1 andUnits:DL]];
}

+(SerumCreatinine*)minConcentrationMolar
{
    return  [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMolarFloat:17.68 molarUnit:MICROMOL] andVolume:[[Volume alloc]initWithFloat:1 andUnits:L]];
}

+(SerumCreatinine*)maxConcentrationMolar
{
    return  [[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMolarFloat:486.22 molarUnit:MICROMOL] andVolume:[[Volume alloc]initWithFloat:1 andUnits:L]];
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

+(BOOL)regexCheckInMicromolesPerLiter:(NSString *)serumCreatinineString
{
    NSRegularExpression *wholeNumberWithOptionalDecimalPoint = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{2,3}\\.?)$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *wholeNumberWithOptionalDecimalPointMatch = [wholeNumberWithOptionalDecimalPoint firstMatchInString:serumCreatinineString options:0 range:NSMakeRange(0, [serumCreatinineString length])];
    
    
    NSRegularExpression *wholeNumberWithTwoDecimalPlaces = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{2,3}\\.\\d{1,2})$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *wholeNumberWithTwoDecimalPlacesMatch = [wholeNumberWithTwoDecimalPlaces firstMatchInString:serumCreatinineString options:0 range:NSMakeRange(0, [serumCreatinineString length])];
    
    return wholeNumberWithOptionalDecimalPointMatch || wholeNumberWithTwoDecimalPlacesMatch;
}

+(BOOL)regexCheckInMilligramsPerDeciliter:(NSString *)serumCreatinineString
{
    NSRegularExpression *decimalValueWithNoLeadingZero = [NSRegularExpression regularExpressionWithPattern:@"^(\\.\\d{1,2})$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *decimalValueWithNoLeadingZeroMatch = [decimalValueWithNoLeadingZero firstMatchInString:serumCreatinineString options:0 range:NSMakeRange(0, [serumCreatinineString length])];
    
    NSRegularExpression *wholeNumberWithOptionalDecimalPoint = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1}\\.?)$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *wholeNumberWithOptionalDecimalPointMatch = [wholeNumberWithOptionalDecimalPoint firstMatchInString:serumCreatinineString options:0 range:NSMakeRange(0, [serumCreatinineString length])];
    
    NSRegularExpression *numberWithLeadingDecimalPlaceAndTwoDecimalPlaces = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1}\\.\\d{1,2})$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *numberWithLeadingDecimalPlaceAndTwoDecimalPlacesMatch = [numberWithLeadingDecimalPlaceAndTwoDecimalPlaces firstMatchInString:serumCreatinineString options:0 range:NSMakeRange(0, [serumCreatinineString length])];
    
    return decimalValueWithNoLeadingZeroMatch || wholeNumberWithOptionalDecimalPointMatch || numberWithLeadingDecimalPlaceAndTwoDecimalPlacesMatch;
}

-(NSString*)description
{
    [[self mol]setMaxFractionDigits:2];
    [[self mol]setFractionDigits:2];
    
    return [super description];

}




@end
