//
//  Creatinine.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Molecule.h"


@interface Creatinine : Molecule

-(instancetype)initWithMassFloat:(float)amt massUnit:(MassUnit)un;
-(instancetype)initWithMolarFloat:(float)amt molarUnit:(MolarUnit)un;

-(Creatinine*)convertedToMolarUnit:(MolarUnit)mu;
-(Creatinine*)convertedToMassUnit: (MassUnit)mu;
@end
