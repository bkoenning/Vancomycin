//
//  Concentration.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Concentration.h"

@implementation Concentration

@synthesize mol,vol;

-(Concentration*)reduced
{
    Concentration *result = [[Concentration alloc]init];
    if ([[self mol]returnAsMolar]){
        float molarAmount = [[[self mol]molarAmount]floatValue] / [[[self vol]volume]floatValue];
    //float massAmount = [[[self mol]massAmount]floatValue] / [[[self vol]volume]floatValue];
        [result setMol:[[Molecule alloc]initWithMolarFloat:molarAmount molarUnit:[[self mol]molarunit] molecularWeight:[[self mol]molecularWeight]]];
    }
    else{
        float massAmount = [[[self mol]massAmount]floatValue] / [[[self vol]volume]floatValue];
        [result setMol:[[Molecule alloc]initWithMassFloat:massAmount massUnit:[[self mol]massunit] molecularWeight:[[self mol]molecularWeight]]];
    }
    [result setVol:[[Volume alloc]initWithFloat:1.0 andUnits:[[self vol]unit]]];
    
    return  result;
}

-(Molecule*)withVolume:(Volume *)v
{
    Volume *copy = [v converted:[[self vol]unit]];
    Concentration *reduced = [self reduced];
    if ([[self mol]returnAsMolar])
        return  [[Molecule alloc]initWithMolarFloat:[[copy volume]floatValue] * [[[reduced mol]molarAmount]floatValue] molarUnit:[[self mol]molarunit] molecularWeight:[[self mol]molecularWeight]];
    else
        return  [[Molecule alloc]initWithMassFloat:[[copy volume]floatValue] * [[[reduced mol]massAmount]floatValue] massUnit:[[self mol]massunit] molecularWeight:[[self mol]molecularWeight]];
}


-(instancetype)copyWithZone:(NSZone *)zone
{
    Concentration *ccopy = [[Concentration allocWithZone:zone]initWithMolecularAmount:[[self mol]copy] andVolume:[[self vol]copy]];
    return ccopy;
}

-(instancetype)initWithMolecularAmount:(Molecule *)m andVolume:(Volume *)v
{
    self = [super init];
    [self setMol:[m copy]];
    [self setVol:[v copy]];
    return  self;
}


-(NSString*)description
{
    if ([[[self vol]volume]floatValue] == 1.0){
        return [NSString stringWithFormat:@"%@/%@",[[self mol]description], [[self vol]unitString]];
    }
    else
        return [NSString stringWithFormat:@"%@/%@", [[self mol]description], [[self vol]description]];
}

@end
