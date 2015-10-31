//
//  Creatinine.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Creatinine.h"

@implementation Creatinine

-(instancetype)initWithMassFloat:(float)amt massUnit:(MassUnit)un
{
    self = [super initWithMassFloat:amt massUnit:un molecularWeight:113.1179];
    return self;
}
-(instancetype)initWithMolarFloat:(float)amt molarUnit:(MolarUnit)un
{
    self = [super initWithMolarFloat:amt molarUnit:un molecularWeight:113.1179];
    return  self;
}

-(instancetype)init
{
    self = [self initWithMassFloat:0 massUnit:MILLIGRAM];
    return  self;
}


@end