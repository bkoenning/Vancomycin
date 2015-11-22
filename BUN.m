//
//  BUN.m
//  Vancomycin
//
//  Created by Brandon Koenning on 11/19/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "BUN.h"


@implementation BUN

-(instancetype)init
{
    self = [super initWithMassFloat:0 massUnit:MILLIGRAM molecularWeight:28.0134];
    return  self;
}

-(instancetype)initWithMassFloat:(float)m massUnit:(MassUnit)u
{
    self = [super initWithMassFloat:m massUnit:u molecularWeight:28.0134];
    return  self;
}
-(instancetype)initWithMolarFloat:(float)m molarUnit:(MolarUnit)u
{
    self = [super initWithMolarFloat:m molarUnit:u molecularWeight:28.0134];
    return  self;
}

-(BUN*)convertToMassUnit:(MassUnit)mu
{
    Molecule *b = [super convertedToMassUnit:mu];
    return  [[BUN alloc]initWithMassFloat:[[b massAmount]floatValue] massUnit:mu];
}

-(BUN*)convertToMolarUnit:(MolarUnit)mu
{
    Molecule *b = [super convertedToMolarUnit:mu];
    return [[BUN alloc]initWithMolarFloat:[[b molarAmount]floatValue] molarUnit:mu];
}





@end
