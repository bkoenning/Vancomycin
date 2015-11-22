//
//  AlbuminConcentration.h
//  Vancomycin
//
//  Created by Brandon Koenning on 11/20/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Concentration.h"
#import "Albumin.h"

@interface AlbuminConcentration : Concentration

-(instancetype)initWithMolecularAmount:(Albumin*)m andVolume:(Volume *)vol;

@end
