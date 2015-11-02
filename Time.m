//
//  Time.m
//  Vancomycin
//
//  Created by Brandon Koenning on 11/1/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Time.h"

@implementation Time

@synthesize time, timeUnit;

-(instancetype)initWithFloat:(float)num andTimeUnit:(TimeUnit)tu
{
    self = [super init];
    [self setTime:[NSNumber numberWithFloat:num]];
    [self setTimeUnit:tu];
    return  self;
    
}

-(instancetype)init
{
    self = [self initWithFloat:0 andTimeUnit:SECOND];
    return  self;
}

-(Time*)convertedTo:(TimeUnit)tu
{
    if ([self timeUnit] > tu){
        int factor = (int)[self timeUnit] / (int)tu;
        return [[Time alloc]initWithFloat:[[self time]floatValue] * factor andTimeUnit:tu];
    }
    else if ([self timeUnit] < tu){
        int factor = (int)tu / (int)[self timeUnit];
        return  [[Time alloc]initWithFloat:[[self time]floatValue] /factor andTimeUnit:tu];
    }
    else
        return [self copy];
}
-(instancetype)copyWithZone:(NSZone *)zone
{
    return [[Time allocWithZone:zone]initWithFloat:[[self time]floatValue] andTimeUnit:[self timeUnit]];
}


@end
