//
//  Weight.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Weight.h"

const float pounds_per_kg = 2.20462;


@interface Weight()

@end

@implementation Weight

@synthesize weight, units;


-(instancetype) initWithFloat:(float)value unit:(WeightUnit)u
{
    self = [super init];
    if (self){
        self.weight = [NSNumber numberWithFloat:value];
        self.units = u;
    }
    return self;
}

-(instancetype) init
{
    self = [self initWithFloat:0.0 unit:KG];
    return self;
}
-(instancetype)copyWithZone:(NSZone *)zone
{
    Weight *weightCopy = [[Weight allocWithZone:zone]init];
    [weightCopy setWeight:[NSNumber numberWithFloat:[[self weight]floatValue]]];
    [weightCopy setUnits:[self units]];
    return weightCopy;
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"%@ %@", [ self valueAsString], [self unitString]];
}

-(NSString *) unitString
{
    if ([ self units] == KG) return @"kg";
    else return @"lb";
}

-(NSString*) valueAsString
{
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    [format setMaximumFractionDigits:2];
    return [NSString stringWithFormat:@"%@", [ format stringFromNumber:[self weight]]];
}

-(void) convertTo:(WeightUnit)wu
{
    if (wu == KG && [self units] == LB){
        [self setWeight:[ NSNumber numberWithFloat:[[self weight]floatValue] / pounds_per_kg]];
        [self setUnits:wu];
    }
    else if (wu == LB && [self units] == KG){
        [self setWeight:[NSNumber numberWithFloat:[[self weight] floatValue] * pounds_per_kg]];
        [self setUnits:wu];
    }
}

-(NSNumber*) getValueAs:(WeightUnit)wu
{
    if (wu == KG && [self units] == LB){
        return  [NSNumber numberWithFloat:[[self weight]floatValue] / pounds_per_kg];
    }
    else if (wu == LB && [self units ] == KG){
        return [NSNumber numberWithFloat:[[self weight] floatValue ] * pounds_per_kg];
    }
    else
        return [self weight];
}

-(Weight*)getWeightAs:(WeightUnit)wu
{
    if ([self units] == wu)
        return self;
    else if ([self units] == KG && wu == LB){
        return [[Weight alloc]initWithFloat:[[self weight]floatValue] * pounds_per_kg unit:LB];
    }
    else
        return [[Weight alloc]initWithFloat:[[self weight]floatValue] / pounds_per_kg unit:KG];
}

-(void) dealloc
{
    weight = nil;
}

@end
