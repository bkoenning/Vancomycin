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

-(Molecule*)convertedToMolarUnit:(MolarUnit)mu
{
    Molecule *result = [[Molecule alloc]init];
    if ([self molarunit] > mu){
        int factor = (int)[self molarunit] / (int) mu;
        [result setMolarAmount:[NSNumber numberWithFloat:[[self molarAmount]floatValue] /factor]];
        [result setMolarunit:mu];
        [result setMassAmount:[NSNumber numberWithFloat:([[self molarAmount]floatValue]  / factor) * [self molecularWeight]]];
        [result setMassunit:(MassUnit)mu];
        [result setReturnAsMolar:YES];
        [result setMolecularWeight:[self molecularWeight]];
    }
    else if ([self molarunit] < mu){
        int factor = (int) mu / (int)[self molarunit];
        [result setMolarAmount:[NSNumber numberWithFloat:[[self molarAmount]floatValue]  * factor]];
        [result setMolarunit:mu];
        [result setMassAmount:[NSNumber numberWithFloat:([[self molarAmount]floatValue]  * factor) * [self molecularWeight]]];
        [result setMassunit:(MassUnit)mu];
        [result setReturnAsMolar:YES];
        [result setMolecularWeight:[self molecularWeight]];
    }
    else
        result = [self copy];
    
    return  result;
}


-(Molecule*)convertedToMassUnit:(MassUnit)mu
{
    Molecule *result = [[Molecule alloc]init];
    
    if ([self massunit] > mu){
        int factor = (int)[self massunit] / (int)mu;
        [result setMassAmount:[NSNumber numberWithFloat:[[self massAmount]floatValue] / factor]];
        [result setMassunit:mu];
        [result setMolarAmount:[NSNumber numberWithFloat:([[self massAmount]floatValue] / factor) / [self molecularWeight]]];
        [result setMolarunit:(MolarUnit)mu];
        [result setReturnAsMolar:NO];
        [result setMolecularWeight:[self molecularWeight]];
    }
    else if ([self massunit] < mu){
        int factor = (int)mu / (int)[self massunit];
        [result setMassAmount:[NSNumber numberWithFloat:[[self massAmount]floatValue] * factor]];
        [result setMassunit:mu];
        [result setMolarAmount:[NSNumber numberWithFloat:([[self massAmount]floatValue] * factor) / [self molecularWeight]]];
        [result setMolarunit:(MolarUnit)mu];
        [result setReturnAsMolar:NO];
        [result setMolecularWeight:[self molecularWeight]];
    }
    else
        result = [self copy];
    
    return  result;
}




-(instancetype)copyWithZone:(NSZone *)zone
{
    Molecule *mcopy = [[Molecule allocWithZone:zone]init];
    [mcopy setMolarAmount:[NSNumber numberWithFloat:[[self molarAmount]floatValue]]];
    [mcopy setMolarunit:[self molarunit]];
    [mcopy setMassAmount:[NSNumber numberWithFloat:[[self massAmount]floatValue]]];
    [mcopy setMassunit:massunit];
    [mcopy setReturnAsMolar:[self returnAsMolar]];
    [mcopy setMolecularWeight:[self molecularWeight]];
    return mcopy;
}

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

@end
