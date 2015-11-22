//
//  BUNConcentration.h
//  Vancomycin
//
//  Created by Brandon Koenning on 11/20/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Concentration.h"
#import "BUN.h"
#import "Volume.h"


@interface BUNConcentration : Concentration

-(instancetype)initWithMolecularAmount:(BUN*)m andVolume:(Volume *)vol;




@end
