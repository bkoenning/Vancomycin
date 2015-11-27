//
//  UrineCreatinine.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "UrineCreatinine.h"

@implementation UrineCreatinine



+(BOOL)regexForUrineCreatinineConcentrationInMgDL:(NSString *)ucr
{
    NSRegularExpression *wholeNumberWithOptionalDecimalPoint = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1,3}\\.?)$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *wholeNumberWithOptionalDecimalPointMatch = [wholeNumberWithOptionalDecimalPoint firstMatchInString:ucr options:0 range:NSMakeRange(0, [ucr length])];
    
    NSRegularExpression *wholeNumberWithOptionalDecimalPortion = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1,3})(\\.\\d{1,2})?$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *wholeNumberWithOptionalDecimalPortionMatch = [wholeNumberWithOptionalDecimalPortion firstMatchInString:ucr options:0 range:NSMakeRange(0, [ucr length])];
    
    
    return wholeNumberWithOptionalDecimalPortionMatch || wholeNumberWithOptionalDecimalPointMatch;
    
}

+(BOOL)regexForUrineCreatinineConcentrationInMicromolL:(NSString *)ucr
{
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"^\\d{3,5}$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *regMatch = [reg firstMatchInString:ucr options:0 range:NSMakeRange(0, [ucr length])];
    
    return  regMatch;
}

+(Creatinine*)maxDailyExcretion
{
    return [[Creatinine alloc]initWithMassFloat:3750 massUnit:MILLIGRAM];
}
+(Creatinine*)minDailyExcretion
{
    return [[Creatinine alloc]initWithMassFloat:375 massUnit:MILLIGRAM];
}

-(Creatinine*)creatinineExcreted:(Volume *)v
{
    Volume *converted  = [v convertedToVolumeUnit:[[self vol]unit]];
    Concentration *conc = [self reduced];
    float creat = [[[conc mol]massAmount]floatValue] * [[converted volume]floatValue];
    return [[Creatinine alloc]initWithMassFloat:creat massUnit:[[conc mol]massunit]];
}





/*

@synthesize  value, units;

-(instancetype)initWithFloat:(float)val andUnits:(UrineCreatinineConcentrationUnit)un
{
    self = [super init];
    [self setValue:[NSNumber numberWithFloat: val]];
    [self setUnits:un];
    return  self;
}

-(instancetype) init
{
    self = [self initWithFloat:0 andUnits:MILLIGRAMS_PER_DECILITER];
    return self;
}


-(NSString*)valueAsString
{
    NSNumberFormatter *format = [[NSNumberFormatter alloc]init];
    [format setMaximumFractionDigits:2];
    return  [NSString stringWithFormat:@"%@",[format stringFromNumber:[self value]]];
}

-(NSString*)unitString
{
    if ([self units] == MILLIGRAMS_PER_DECILITER){
        return [NSString stringWithFormat:@"%@", @"mg/dL"];
    }
    else{
        return [NSString stringWithFormat:@"%@",@"\u00B5mol/dL"];
    }
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"%@ %@", [self valueAsString], [self unitString]];
}

-(void)convertTo:(UrineCreatinineConcentrationUnit)un
{
    if (un == MILLIGRAMS_PER_DECILITER && [self units] == MICRO_MOLES_PER_LITER){
        [self setValue:[NSNumber numberWithFloat:[[self value]floatValue] / MICROMOL_PER_LITER_PER_MILLIGRAMS_PER_DECILITER]];
        [self setUnits:un];
    }
    else if (un == MICRO_MOLES_PER_LITER && [self units] == MILLIGRAMS_PER_DECILITER){
        [self setValue:[NSNumber numberWithFloat:[[self value]floatValue] * MICROMOL_PER_LITER_PER_MILLIGRAMS_PER_DECILITER]];
        [self setUnits:un];
    }
}
 */
@end
