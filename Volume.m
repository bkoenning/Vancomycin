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

-(Volume*)converted:(VolumeUnit)vu
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


/*-(void)convertTo:(VolumeUnit)vu
{
    if ([self unit] > vu){
        int factor = (int)[self unit] / (int) vu;
        [self setVolume:[NSNumber numberWithFloat:[[self volume]floatValue] / factor]];
        [self setUnit:vu];
    }
    else if ([self unit] < vu){
        int factor = (int)vu / (int)[self unit];
        [self setVolume:[NSNumber numberWithFloat:[[self volume]floatValue] * factor]];
        [self setUnit:vu];
    }
}
 

-(Volume*)getVolumeAs:(VolumeUnit)vu
{
    
    if ([self unit] > vu){
        int factor = (int)[self unit] / (int)vu;
        return  [[Volume alloc]initWithFloat:[[self volume]floatValue] / factor andUnits:vu];
    }
    else if ([self unit] < vu){
        int factor = (int)vu / (int)[self unit];
        return  [[Volume alloc]initWithFloat:[[self volume]floatValue] * factor andUnits:vu];
    }
    else
        return  [[Volume alloc] initWithFloat:[[self volume]floatValue] andUnits:vu];
}
 */
-(NSString*) valueAsString
{
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    [format setMaximumFractionDigits:2];
    return [NSString stringWithFormat:@"%@", [ format stringFromNumber:[self volume]]];
}

-(instancetype)copyWithZone:(NSZone *)zone
{
    Volume *volcopy = [[Volume allocWithZone:zone]initWithFloat:[[self volume]floatValue] andUnits:[self unit]];
    return  volcopy;
}
/*
 -(NSNumber*) getValueAs:(VolumeUnit)vu
 {
 if (vu == L && [self unit] == ML){
 return  [NSNumber numberWithFloat:[[self volume]floatValue] / 1000];
 }
 else if (vu == ML && [self unit ] == L){
 return [NSNumber numberWithFloat:[[self volume] floatValue ] * 1000];
 }
 else
 return [self volume];
 }
 */

-(NSString*)description
{
    return [NSString stringWithFormat:@"%@%@", [self valueAsString], [self unitString]];
}

@end
