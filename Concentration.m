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

-(Concentration*)convertedToMolarUnit:(MolarUnit)mu andVolumeUnit:(VolumeUnit)vu
{
    Molecule *newMol = [[self mol]convertedToMolarUnit:mu];
    Volume *newVol = [[self vol]convertedToVolumeUnit:vu];
    float newConc = [[newMol molarAmount]floatValue] / [[newVol volume]floatValue];
    return [[Concentration alloc]initWithMolecularAmount:[[Molecule alloc]initWithMolarFloat:newConc molarUnit:mu molecularWeight:[[self mol]molecularWeight]] andVolume:[[Volume alloc]initWithFloat:1 andUnits:vu]];
}


-(int)compareTo:(Concentration *)c
{
    Concentration *convertedSelf = [self convertedToMassUnit:[[c mol]massunit] andVolumeUnit:[[c vol]unit]];
    Concentration *reducedC = [c reduced];
    
    //float dif = fabsf([[[convertedSelf mol]massAmount]floatValue] - [[[reducedC mol]massAmount]floatValue]);
    float ratio = [[[convertedSelf mol]massAmount]floatValue] / [[[reducedC mol]massAmount]floatValue];
    
    float percent = fabsf(1.0f - ratio) * 100.0f;
    
    if (percent < 0.0005f)
        return 0;
    else if ([[[convertedSelf mol]massAmount]floatValue] > [[[reducedC mol]massAmount]floatValue])
        return 1;
    else
        return -1;
}

-(BOOL)isInRangeLower:(Concentration *)lower upper:(Concentration *)upper
{
    if ([lower compareTo:upper] >= 0){
        NSLog(@"Range arguments are equal or in wrong order");
        return false;
    }
    else if ([self compareTo:lower] == -1 || [self compareTo:upper] == 1)
        return false;
    else
        return true;
    
    
}

-(Concentration*)convertedToMassUnit:(MassUnit)mu andVolumeUnit:(VolumeUnit)vu
{
    Volume *newVol = [[self vol]convertedToVolumeUnit:vu];
    Molecule *newMol = [[self mol]convertedToMassUnit:mu];
    float newConc = [[newMol massAmount]floatValue] / [[newVol volume]floatValue];
    Volume *returnVol = [[Volume alloc]initWithFloat:1.0 andUnits:vu];
    Molecule *returnMol = [[Molecule alloc]initWithMassFloat:newConc massUnit:mu molecularWeight:[[self mol]molecularWeight]];
    return [[Concentration alloc]initWithMolecularAmount:returnMol andVolume:returnVol];
    
    
}

//-(int)compareTo:(Concentration *)c
//{
  //  Concentration *converted = [self ]
    
    
//}

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
    Volume *copy = [v convertedToVolumeUnit:[[self vol]unit]];
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
