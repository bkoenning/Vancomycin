//
//  UrineVolume.h
//  Vancomycin
//
//  Created by Brandon Koenning on 11/4/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Volume.h"

@interface UrineVolume : Volume

+(UrineVolume*)maxDaily;
+(UrineVolume*)minDaily;

-(UrineVolume*)converted: (VolumeUnit)vu;

@end
