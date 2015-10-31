//
//  Molecule.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//
#import "Molecule.h"

@implementation Molecule

@synthesize molarAmount, massAmount, massunit, molarunit, molecularWeight, returnAsMolar;

-(instancetype)initWithMolarFloat:(float)amt molarUnit:(MolarUnit)un molecularWeight:(float)mw
{
    self = [super init];
    [self setMolecularWeight:mw];
    [self setMolarunit:un];
    [self setMolarAmount:[NSNumber numberWithFloat:amt]];
    [self setMassAmount:[NSNumber numberWithFloat:amt * [self molecularWeight]]];
    [self setMassunit:(MassUnit)un];
    [self setReturnAsMolar:YES];
    return  self;
}

-(instancetype)initWithMassFloat:(float)amt massUnit:(MassUnit)un molecularWeight:(float)mw
{
    self = [super init];
    [self setMolecularWeight:mw];
    [self setMassunit:un];
    [self setMassAmount:[NSNumber numberWithFloat:amt]];
    [self setMolarAmount:[NSNumber numberWithFloat:amt / [self molecularWeight]]];
    [self setMolarunit:(MolarUnit)un];
    [self setReturnAsMolar:NO];
    return  self;
}


-(instancetype)init
{
    self = [self initWithMassFloat:0 massUnit:MILLIGRAM molecularWeight:1];
    return  self;
}


-(NSString*)unitString
{
    if ([self returnAsMolar]){
        if ([self molarunit] == MOL) return @"mole(s)";
        else if ([self molarunit] ==MILLIMOL) return  @"millimole(s)";
        else return @"micromole(s)";
    }
    else{
        if ([self massunit] == G) return @"gram(s)";
        else if ([self massunit] == MILLIGRAM) return @"milligram(s)";
        else return  @"microgram(s)";
    }
}
-(NSString*)valueAsString
{
    NSNumberFormatter *format = [[NSNumberFormatter alloc]init];
    [format setMaximumFractionDigits:4];
    if ([self returnAsMolar]){
        return [NSString stringWithFormat:@"%@", [format stringFromNumber:[self molarAmount]]];
    }
    else
        return [NSString stringWithFormat:@"%@", [format stringFromNumber:[self massAmount]]];
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"%@ %@", [self valueAsString], [self unitString]];
}
-(float)getValueInMolar:(MolarUnit)mu
{
    if ([self molarunit] > mu ){
        int factor = (int)[self molarunit] / (int)mu;
        return  [[self molarAmount]floatValue] / factor;
    }
    else if ([self molarunit] < mu){
        int factor = (int)mu / (int)[self molarunit];
        return  [[self molarAmount] floatValue] * factor;
    }
    else
        return  [[self molarAmount]floatValue];
}
-(float)getValueInMass:(MassUnit)mu
{
    if ([self massunit] > mu ){
        int factor = (int)[self massunit] / (int)mu;
        return  [[self massAmount]floatValue] / factor;
    }
    else if ([self massunit] < mu){
        int factor = (int)mu / (int)[self massunit];
        return  [[self massAmount] floatValue] * factor;
    }
    else
        return  [[self massAmount]floatValue];
}

-(void)convertToMassUnit:(MassUnit)mu
{
    if ([self massunit] > mu ){
        int factor = (int)[self massunit] / (int)mu;
        [self setMassAmount:[NSNumber numberWithFloat:[[self massAmount]floatValue] / factor]];
        [self setMassunit:mu];
    }
    else if ([self massunit] < mu){
        int factor = (int)mu / (int)[self massunit];
        [self setMassAmount:[NSNumber numberWithFloat:[[self massAmount]floatValue] * factor]];
        [self setMassunit:mu];
    }
}
-(void)convertToMolarUnit:(MolarUnit)mu
{
    if ([self molarunit] > mu ){
        int factor = (int)[self molarunit] / (int)mu;
        [self setMolarAmount:[NSNumber numberWithFloat:[[self molarAmount]floatValue] / factor]];
        [self setMolarunit:mu];
    }
    else if ([self molarunit] < mu){
        int factor = (int)mu / (int)[self molarunit];
        [self setMolarAmount:[NSNumber numberWithFloat:[[self molarAmount]floatValue] * factor]];
        [self setMolarunit:mu];
    }
}

/*
 
 -(NSString*)valueAsString
 {
 NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
 [format setMaximumFractionDigits:4];
 return [NSString stringWithFormat:@"%@", [ format stringFromNumber:[self amount]]];
 }
 
 
 -(NSString*)unitString
 {
 if ([self unit] == MG){
 return @"mg";
 }
 else
 return @"mmol";
 }
 
 -(NSString*)description
 {
 return [NSString stringWithFormat:@"%@ %@",[self valueAsString], [self unitString]];
 }
 -(float)getValueIn:(MassUnit)mu
 {
 if (mu == MOL && [self unit] == MMOL){
 return [[self amount]floatValue] / 1000.0;
 }
 else if (mu == MOL && [self unit] == MICROMOL){
 return  [[self amount]floatValue] / 1000000.0;
 }
 else if (mu == MMOL && [self unit] == MOL){
 return [[self amount]floatValue] * 1000.0;
 }
 else if (mu == MMOL && [self unit] == MICROMOL){
 return  [[self amount]floatValue] / 1000.0;
 }
 else if (mu == MICROMOL && [self unit] == MMOL){
 return [[self amount]floatValue] * 1000.0;
 }
 else if (mu == MICROMOL && [self unit] == MOL){
 return [[self amount] floatValue] * 1000000.0;
 }
 else if (mu == MG && [self unit] == G){
 return  [[self amount] floatValue] * 1000.0;
 }
 else if (mu == G && [self unit] == MG){
 return  [[self amount]floatValue] / 1000.0;
 }
 else if ((mu == MMOL && [self unit] == MG) || (mu == MOL && [self unit] == G)){
 return [[self amount]floatValue] / [self molecularWeight];
 }
 else if ((mu == MG && [self unit] == MMOL) || (mu == G && [self unit] == MOL)){
 return [[self amount]floatValue] * [self molecularWeight];
 }
 else if (mu == MG && [self unit] == MOL){
 return  [self getValueIn:MMOL] * [self molecularWeight];
 }
 else if (mu == MG && [self unit] == MICROMOL){
 return  [self getValueIn:MMOL] * [self molecularWeight];
 }
 else if (mu == G && [self unit] == MICROMOL){
 return [self getValueIn:MOL] * [self molecularWeight];
 }
 else if (mu == G && [self unit] == MMOL){
 return [self getValueIn:MOL] * [self molecularWeight];
 }
 else if (mu == MMOL && [self unit] == G){
 return  [self getValueIn:MG] / [self molecularWeight];
 }
 else if (mu == MOL && [self unit] == MG){
 return  [self getValueIn:G] /[ self molecularWeight];
 }
 else if (mu == MICROMOL && [self unit] == MG){
 return ([[self amount]floatValue] / 1000.0) /[self molecularWeight];
 }
 else if (mu == MICROMOL && [self unit] == G){
 return ([[self amount]floatValue] / 1000000.0)/ [self molecularWeight];
 }
 else
 return [[self amount]floatValue];
 }
 */




@end
