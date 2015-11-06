//
//  UrineVolume.m
//  Vancomycin
//
//  Created by Brandon Koenning on 11/4/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "UrineVolume.h"

@implementation UrineVolume

+(UrineVolume*)minDaily
{
    return [[UrineVolume alloc]initWithFloat:600 andUnits:ML];
}
+(UrineVolume*)maxDaily
{
    return [[UrineVolume alloc]initWithFloat:8000 andUnits:ML];
}

-(UrineVolume*)converted:(VolumeUnit)vu
{
    //Volume *rawVol = [self converted:vu];
    Volume *rawVol = [super convertedToVolumeUnit:vu];
    
    return  [[UrineVolume alloc]initWithFloat:[[rawVol volume]floatValue] andUnits:vu];
}


@end
