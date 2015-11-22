//
//  Albumin.m
//  Vancomycin
//
//  Created by Brandon Koenning on 11/20/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Albumin.h"

@implementation Albumin

-(instancetype)initWithMassFloat:(float)amt massUnit:(MassUnit)un
{
    self = [super initWithMassFloat:amt massUnit:un molecularWeight:66500];
    return  self;
    
}
-(instancetype)initWithMolarFloat:(float)amt molarUnit:(MolarUnit)un
{
    self = [super initWithMolarFloat:amt molarUnit:un molecularWeight:66500];
    return  self;
}

@end
