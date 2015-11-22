//
//  Albumin.h
//  Vancomycin
//
//  Created by Brandon Koenning on 11/20/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Molecule.h"

@interface Albumin : Molecule

-(instancetype)initWithMassFloat:(float)amt massUnit:(MassUnit)un;
-(instancetype)initWithMolarFloat:(float)amt molarUnit:(MolarUnit)un;

@end
