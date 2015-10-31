//
//  Concentration.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Molecule.h"
#import "Volume.h"

@interface Concentration : NSObject

@property (nonatomic) Molecule *mol;
@property (nonatomic) Volume *vol;

-(instancetype)initWithMolecularAmount: (Molecule*)m andVolume: (Volume*)vol;

-(void)reduce;
-(void)changeVolumeToUnits: (VolumeUnit)un;
-(Molecule*)getAmountPerVolume: (Volume*)v;
-(Volume*)getVolumePerMolecule: (Molecule*)m;



@end