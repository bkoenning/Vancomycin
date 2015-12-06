//
//  BUNConcentration.m
//  Vancomycin
//
//  Created by Brandon Koenning on 11/20/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "BUNConcentration.h"


@implementation BUNConcentration

-(instancetype)initWithMolecularAmount:(BUN *)m andVolume:(Volume *)vol
{
    self = [super initWithMolecularAmount:m andVolume:vol];
    return  self;
}

+(BUNConcentration*)minConcentrationInMgDL
{
    return [[BUNConcentration alloc]initWithMolecularAmount:[[BUN alloc]initWithMassFloat:5.0 massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1.0 andUnits:DL]];
}
+(BUNConcentration*)maxConcentrationInMgDL
{
    return [[BUNConcentration alloc]initWithMolecularAmount:[[BUN alloc]initWithMassFloat:80.0 massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1.0 andUnits:DL]];
}

+(BUNConcentration*)minConcentrationInMMOLL
{
    return  [[BUNConcentration alloc]initWithMolecularAmount:[[BUN alloc]initWithMolarFloat:1.78 molarUnit:MILLIMOL] andVolume:[[Volume alloc]initWithFloat:1.0 andUnits:L]];
}

+(BUNConcentration*)maxConcentrationInMMOLL
{
    return [[BUNConcentration alloc]initWithMolecularAmount:[[BUN alloc]initWithMolarFloat:28.56 molarUnit:MILLIMOL] andVolume:[[Volume alloc]initWithFloat:1.0 andUnits:L]];
}

+(BOOL)regexCheckInMicromolesPerLiter:(NSString *)bunString
{
    NSRegularExpression *wholeNumberWithOptionalDecimalPoint = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1,2}\\.?)$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *wholeNumberWithOptionalDecimalPointMatch = [wholeNumberWithOptionalDecimalPoint firstMatchInString:bunString options:0 range:NSMakeRange(0, [bunString length])];
    
    
    NSRegularExpression *wholeNumberWithTwoDecimalPlaces = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1,2}\\.\\d{1,2})$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *wholeNumberWithTwoDecimalPlacesMatch = [wholeNumberWithTwoDecimalPlaces firstMatchInString:bunString options:0 range:NSMakeRange(0, [bunString length])];
    
    NSRegularExpression *wholeNumber = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1,2})$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *wholeNumberMatch = [wholeNumber firstMatchInString:bunString options:0 range:NSMakeRange(0, [bunString length])];
    
    return wholeNumberWithOptionalDecimalPointMatch || wholeNumberWithTwoDecimalPlacesMatch || wholeNumberMatch;
}

+(BOOL)regexCheckInMilligramsPerDeciliter:(NSString *)bunString
{
    
    NSRegularExpression *wholeNumberWithUpTo2Places = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1,2})$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *match = [wholeNumberWithUpTo2Places firstMatchInString:bunString options:0 range:NSMakeRange(0, [bunString length])];
  
    return match;
}





@end
