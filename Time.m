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


+(BOOL)regexForTimeBetweenSerumCreatinineLevelsInHours:(NSString *)text
{
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1,2})(\\.\\d{1,2}?)?$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *timeMatch = [reg firstMatchInString: text options:0 range:NSMakeRange(0, [text length])];
    return timeMatch;
}

-(NSString*)valueAsString
{
    NSNumberFormatter *format = [[NSNumberFormatter alloc]init];
    [format setMaximumFractionDigits:4];
    [format setMinimumIntegerDigits:1];
    return [NSString stringWithFormat:@"%@", [format stringFromNumber:[self time]]];
}

-(NSString*)unitString
{
    if ([self timeUnit] == SECOND) return @"sec";
    else if ([self timeUnit] == MINUTE) return @"min";
    else if ([self timeUnit] == HOUR) return @"hr";
    else return @"day";
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"%@ %@", [self valueAsString],[self unitString]];
}

-(int)compareTo:(Time *)t
{
    Time *tcopy = [self convertedTo:[t timeUnit]];
    
    float dif = fabsf([[tcopy time]floatValue] - [[t time]floatValue]);
    
    if (dif < 0.00000001)
        return  0;
    else if ([[tcopy time]floatValue] > [[t time]floatValue])
        return  1;
    return -1;
}

-(BOOL)isInRangeLower:(Time *)lower upper:(Time *)upper
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
