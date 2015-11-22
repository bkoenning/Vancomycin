//
//  DualSerumCreatinineInformation.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "DualSerumCreatinineInformation.h"

@implementation DualSerumCreatinineInformation

@synthesize scr1, scr2, timeBetweenLevels;

-(instancetype)init
{
    
    self = [super initWithTitle:@"Dual Serum Creatinine"];
    [self setScr2:[[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMassFloat:1 massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1 andUnits:DL]]];
    [self setScr1:[[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMassFloat:1 massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1 andUnits:DL]]];
    [self setTimeBetweenLevels:[[Time alloc]initWithFloat:12 andTimeUnit:HOUR]];
    return  self;
    
    //return [self initWithScr1:[[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMassFloat:1 massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1 andUnits:DL]] Scr2:[[SerumCreatinine alloc]initWithMolecularAmount:[[Creatinine alloc]initWithMassFloat:1 massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1 andUnits:DL]] timeBetweenLevels:[[Time alloc]initWithFloat:12 andTimeUnit:HOUR]];
}

-(instancetype)initWithScr1:(SerumCreatinine *)s1 Scr2:(SerumCreatinine *)s2 timeBetweenLevels:(Time *)t
{
    self = [super initWithTitle:@"Dual Serum Creatinine"];
    [self setScr1:[s1 copy]];
    [self setScr2:[s2 copy]];
    [self setTimeBetweenLevels:[t copy]];
    return  self;
}

-(NSString*)tableDescription
{
    NSMutableString *string = [NSMutableString stringWithFormat:@"Data entered:\n"];
    [string appendString:@"Serum creatinine #1:  "];
    [string appendString:[scr1 description]];
    [string appendString:@"\nSerum creatinine #2:  "];
    [string appendString:[scr2 description]];
    [string appendString:@"\nTime between levels:  "];
    [string appendString:[timeBetweenLevels description]];
    return  string;
}

@end