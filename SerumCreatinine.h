//
//  SerumCreatinine.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CreatinineConcentration.h"

@interface SerumCreatinine : CreatinineConcentration


+(SerumCreatinine*)maxConcentrationMass;
+(SerumCreatinine*)minConcentrationMass;
+(SerumCreatinine*)minConcentrationMolar;
+(SerumCreatinine*)maxConcentrationMolar;

-(SerumCreatinine*)convertedToMolarUnit: (MolarUnit)mu andVolumeUnit: (VolumeUnit)vu;
-(SerumCreatinine*)convertedToMassUnit: (MassUnit)mu andVolumeUnit: (VolumeUnit)vu;
+(BOOL)regexCheckInMilligramsPerDeciliter: (NSString*)serumCreatinineString;
+(BOOL)regexCheckInMicromolesPerLiter:(NSString *)serumCreatinineString;










@end
