//
//  CreatinineConcentration.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Concentration.h"
#import "Creatinine.h"
#import "Volume.h"

@interface CreatinineConcentration : Concentration

//-(instancetype)initWithCreatinineAmount: (Creatinine*)cr andVolume: (Volume*)v;
-(instancetype)initWithMolecularAmount:(Creatinine *)m andVolume:(Volume *)vol;

@end