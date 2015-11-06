//
//  Volume.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Volume.h"

@implementation Volume

@synthesize volume, unit;

-(instancetype)initWithFloat:(float)vol andUnits:(VolumeUnit)un
{
    self =  [super init];
    [self setVolume:[NSNumber numberWithFloat:vol]];
    [self setUnit:un];
    return  self;
}

-(NSString*)unitString
{
    if ([self unit] == ML) return @"mL";
    else if ([self unit] == DL)return @"dL";
    else return @"L";
}

-(Volume*)convertedToVolumeUnit:(VolumeUnit)vu
{
    Volume *result = [[Volume alloc]init];
    if ([self unit] > vu){
        int factor = (int)[self unit] / (int) vu;
        [result setVolume:[NSNumber numberWithFloat:[[self volume]floatValue]/factor]];
        [result setUnit:vu];
    }
    else if ([self unit] < vu){
        int factor = (int)vu / (int)[self unit];
        [result setVolume:[NSNumber numberWithFloat:[[self volume]floatValue] * factor]];
        [result setUnit:vu];
    }
    else
        result = [self copy];
    
    return  result;
}

-(NSString*) valueAsString
{
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    [format setMaximumFractionDigits:2];
    [format setMinimumIntegerDigits:1];
    return [NSString stringWithFormat:@"%@", [ format stringFromNumber:[self volume]]];
}

-(instancetype)copyWithZone:(NSZone *)zone
{
    Volume *volcopy = [[Volume allocWithZone:zone]initWithFloat:[[self volume]floatValue] andUnits:[self unit]];
    return  volcopy;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"%@ %@", [self valueAsString], [self unitString]];
}

-(int)compareTo:(Volume *)v
{
    Volume *convert = [self convertedToVolumeUnit:[v unit]];
    float dif = fabsf([[convert volume]floatValue] - [[v volume]floatValue]);
    
    if (dif < 0.0000000001)
        return 0;
    else if ([[v volume]floatValue] > [[convert volume]floatValue])
        return  -1;
    else
        return  1;
    
}

-(BOOL)isInRangeLower:(Volume *)lower upper:(Volume *)upper
{
    if ([lower compareTo:upper] >=0){
        NSLog(@"Range arguments are equal or in wrong order");
        return false;
    }
    else if ([self compareTo:lower] == -1 || [self compareTo:upper] ==1)
        return  false;
    else
        return true;
}

@end
