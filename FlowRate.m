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
    Volume *vo = [v convertedToVolumeUnit:[[self volume]unit]];
    FlowRate *reducedRate = [self reduced];
    float newTime = [[vo volume]floatValue] / [[[reducedRate volume]volume]floatValue];
    return  [[Time alloc]initWithFloat:newTime andTimeUnit:[[self time]timeUnit]];
}

-(FlowRate*)inTimeUnit:(TimeUnit)u
{
    Time *ti = [[self time]convertedTo:u];
    float newflowrate = [[[self volume]volume]floatValue] / [[ti time]floatValue];
    Volume *newvol = [[Volume alloc]initWithFloat:newflowrate andUnits:[[self volume]unit]];
    Time *newtime = [[Time alloc]initWithFloat:1.0 andTimeUnit:u];
    return  [[FlowRate alloc]initWithVolume:newvol andTime:newtime];
}

-(FlowRate*)inVolumeUnit:(VolumeUnit)u
{
    Volume *v = [[self volume]convertedToVolumeUnit:u];
    float newflowrate = [[v volume]floatValue] / [[[self time]time]floatValue];
    Volume *newvolume = [[Volume alloc]initWithFloat:newflowrate andUnits:u];
    Time *newtime = [[Time alloc]initWithFloat:1.0 andTimeUnit:[[self time]timeUnit]];
    return  [[FlowRate alloc]initWithVolume:newvolume andTime:newtime];
}

-(FlowRate*)inVolumeUnit:(VolumeUnit)vu andTimeUnit:(TimeUnit)tu
{
    Volume *v = [[self volume]convertedToVolumeUnit:vu];
    Time *t = [[self time]convertedTo:tu];
    float newflowrate = [[v volume]floatValue] / [[t time]floatValue];
    Volume *newVolume = [[Volume alloc]initWithFloat:newflowrate andUnits:vu];
    Time *newTime = [[Time alloc]initWithFloat:1.0 andTimeUnit:tu];
    return [[FlowRate alloc]initWithVolume:newVolume andTime:newTime];
}

-(int)compareTo:(FlowRate *)fr
{
    FlowRate *self_reduced = [self inVolumeUnit:[[fr volume]unit] andTimeUnit:[[fr time]timeUnit]];
    FlowRate *fr_reduced = [fr reduced];
    
    float difference = fabsf([[[self_reduced volume]volume]floatValue] - [[[fr_reduced volume]volume]floatValue]);
    if (difference < 0.00000001)
        return  0;
    else if ([[[self_reduced volume]volume]floatValue] > [[[fr_reduced volume]volume]floatValue])
        return 1;
    else
        return -1;
}

-(BOOL)isInRangeLower:(FlowRate *)lower upper:(FlowRate *)upper
{
    if ([lower compareTo:upper] >= 0){
        NSLog(@"Range arguments are equal or in wrong order");
        return false;
    }
    else if ([self compareTo:lower] == -1 || [self compareTo:upper] == 1)
        return false;
    else
        return true;
    
}

-(NSString*)description
{
    if ([[[self time]time]floatValue] == 1.0){
        return  [NSString stringWithFormat:@"%@/%@", [[self volume]description], [[self time]unitString]];
    }
    else
        return  [NSString stringWithFormat:@"%@/%@", [[self volume]description], [[self time]description]];
}











@end
