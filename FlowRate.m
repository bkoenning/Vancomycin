//
//  FlowRate.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/30/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "FlowRate.h"


@implementation FlowRate

@synthesize volume,time;

-(instancetype)copyWithZone:(NSZone *)zone
{
    return [[FlowRate allocWithZone:zone]initWithVolume:[[self volume]copy] andTime:[[self time]copy]];
}

-(instancetype)initWithVolume:(Volume *)vol andTime:(Time *)t
{
    self = [super init];
    [self setVolume:[vol copy]];
    [self setTime:[t copy]];
    return  self;
}

-(FlowRate*)reduced
{
    float num = [[[self volume]volume]floatValue] / [[[self time]time]floatValue];
    Volume *reducedVol = [[Volume alloc]initWithFloat:num andUnits:[[self volume]unit]];
    return [[FlowRate alloc]initWithVolume:reducedVol andTime:[[Time alloc]initWithFloat:1.0 andTimeUnit:[[self time]timeUnit]]];
}

-(Volume*)withTime:(Time *)t
{
    Time *ti = [t convertedTo:[[self time]timeUnit]];
    FlowRate *reducedRate = [self reduced];
    float newvol = [[ti time]floatValue] * [[[reducedRate volume]volume]floatValue];
    return  [[Volume alloc]initWithFloat:newvol andUnits:[[self volume]unit]];
}

-(Time*)withVolume:(Volume *)v
{
    Volume *vo = [v converted:[[self volume]unit]];
    FlowRate *reducedRate = [self reduced];
    float newTime = [[vo volume]floatValue] / [[[reducedRate volume]volume]floatValue];
    return  [[Time alloc]initWithFloat:newTime andTimeUnit:[[self time]timeUnit]];
}

-(FlowRate*)perTimeUnit:(TimeUnit)u
{
    Time *ti = [[self time]convertedTo:u];
    
    
}





@end
