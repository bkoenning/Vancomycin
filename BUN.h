//
//  BUN.h
//  Vancomycin
//
//  Created by Brandon Koenning on 11/19/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Molecule.h"

@interface BUN : Molecule

-(instancetype)initWithMassFloat:(float)m massUnit:(MassUnit)u;
-(instancetype)initWithMolarFloat:(float)m molarUnit:(MolarUnit)u;

-(BUN*)convertToMolarUnit:(MolarUnit)mu;
-(BUN*)convertToMassUnit:(MassUnit)mu;










@end
