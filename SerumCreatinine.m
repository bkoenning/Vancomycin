//
//  SerumCreatinine.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "SerumCreatinine.h"
//const float MICROMOLES_PER_LITER_PER_MILLIGRAMS_PER_DECILITER = 88.4;

@implementation SerumCreatinine

//-(instancetype)initWithCreatinineAmount:(Creatinine *)cr andVolume:(Volume *)v
//{
  //  self = [super initWithCreatinineAmount:cr andVolume:v];
    //return  self;
//}

//-(instancetype)init
//{
  //  self = [self initWithCreatinineAmount:[[Creatinine alloc]initWithMassFloat:0 massUnit:MILLIGRAM] andVolume:[[Volume alloc]initWithFloat:1 andUnits:DL]];
   // return self;
//}

//@synthesize  value, units;

//-(instancetype)initWithFloat:(float)val andUnits:(SerumCreatinineConcentrationUnit)un
//{
//  self = [super init];
// [self setValue:[NSNumber numberWithFloat: val]];
// [self setUnits:un];
//return  self;
//}

/*
 -(instancetype) init
 {
 self = [self initWithFloat:0 andUnits:MG_PER_DECILITER];
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
 if ([self units] == MG_PER_DECILITER){
 return [NSString stringWithFormat:@"%@", @"mg/dL"];
 }
 else{
 return [NSString stringWithFormat:@"%@",@"\u00B5mol/L"];
 }
 }
 
 -(NSString*) description
 {
 return [NSString stringWithFormat:@"%@ %@", [self valueAsString], [self unitString]];
 }
 
 -(void)convertTo:(SerumCreatinineConcentrationUnit)un
 {
 if (un == MG_PER_DECILITER && [self units] == MICRO_MOL_PER_LITER){
 [self setValue:[NSNumber numberWithFloat:[[self value]floatValue] / MICROMOLES_PER_LITER_PER_MILLIGRAMS_PER_DECILITER]];
 [self setUnits:un];
 }
 else if (un == MICRO_MOL_PER_LITER && [self units] == MG_PER_DECILITER){
 [self setValue:[NSNumber numberWithFloat:[[self value]floatValue] * MICROMOLES_PER_LITER_PER_MILLIGRAMS_PER_DECILITER]];
 [self setUnits:un];
 }
 }
 */
@end
